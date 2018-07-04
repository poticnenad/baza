#Note the important changes
<#
Instead of previously plain text used as an argument for $global:apiKey variable and -Password switch,
you should use the $global:apiKeyFile variable and -PasswordFile switch and provide to them a files where ApiKey/password is stored.

Examples:
$global:apiKeyFile = "ApiKey_file", 
New-ApexSQLSource ... -PasswordFile "SourcePassword" ...,
New-ApexSqlDatabaseConnection ... -PasswordFile "DBPassword" ...,
New-ApexSQLNotificationSettings ... -PasswordFile "GMailPassword" ...

To be able to provide your ApiKey and password files to $global:apiKeyFile variable and -PasswordFile switch, 
you have to save them to files using:

Read-Host -AsSecureString |ConvertFrom-SecureString |Out-File path_to_the_script\Passwords\ApiKey_file.txt
Read-Host -AsSecureString |ConvertFrom-SecureString |Out-File path_to_the_script\Passwords\SourcePassword.txt
Read-Host -AsSecureString |ConvertFrom-SecureString |Out-File path_to_the_script\Passwords\DBPassword.txt
Read-Host -AsSecureString |ConvertFrom-SecureString |Out-File path_to_the_script\Passwords\GMailPassword.txt
#>

#region Initial settings
Initialize-Globals -CurrentDirectory "$(Split-Path -parent $PSCommandPath)"

#Nuget package settings
$global:nugetId = "paket"
$global:nugetAuthors = "ApexSQL LLC"
$global:nugetOwners = "ApexSQL LLC"
$global:pushSource = "https://devopsnenad.pkgs.visualstudio.com/_packaging/test.apexsql/nuget/v3/index.json"
$global:apiKeyFile = "ApiKey"
$global:nugetExePath = "C:\Program Files\ApexSQL\ApexSQL CICD toolkit\Modules\ApexSQL_cicd\nuget.exe"

#Global options (pipeline name, output folder location and notification settings)
$options = New-ApexSqlOptions -PipelineName "CI_Pipeline"

#Email server settings used for notifications
$notificationSettings = New-ApexSQLNotificationSettings -EmailAddress "example@gmail.com" -Password "test" -SmtpServer "smtp.gmail.com" -Port 587 -UseSSL

#endregion


#region Data source definitions

#Define data source
$dsSC = New-ApexSQLSource -ConnectionName "tfs_source" -Source_Type "tfs" -Server "https://devopsnenad.visualstudio.com/" -Project "$/Database/SourceControl_DB" -UserName "devopsnenad" -PasswordFile "Source"

#Define target: new database (testing)
$dsQA = New-ApexSqlDatabaseConnection -ConnectionName "qaDB_dest" -Server "." -Database "izCLIa" -WindowsAuthentication

#endregion


#region CI pipeline steps in order of execution

#Notification step
#Invoke-ApexSqlNotifyStep -Options $options -DistributionList "*******@gmail.com" -Status started

#Build step
Invoke-ApexSqlBuildStep -Options $options -Source $dsSC -Database $dsQA | Out-Null

#Populate step
Invoke-ApexSqlPopulateStep -Options $options -Database $dsQA -RowCount 100 | Out-Null

#Audit step
Invoke-ApexSqlAuditStep -Options $options -Database $dsQA | Out-Null

#Review step
#Invoke-ApexSqlReviewStep -Options $options -Database $dsQA -ProjectFile "Review_RuleBase.axrb" -Passed -Failed -Errors | Out-Null

#Test step
Invoke-ApexSqlTestStep -Options $options -Database $dsQA -InstallSqlCop | Out-Null

#Package step
Invoke-ApexSqlPackageStep -Options $options -nugetVersion "10.0.13" -nugetReleaseNotes "Release_notes_here" -Publish | Out-Null

#Notification step
#Invoke-ApexSqlNotifyStep -Options $options -DistributionList "poticnenad@gmail.com" -Status completed

#endregion


