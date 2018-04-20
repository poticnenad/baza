#region Initial settings

Initialize-Globals -CurrentDirectory "$(Split-Path -parent $PSCommandPath)"

#Nuget package settings
$global:nugetId = "ApexSQL_CI"
$global:nugetAuthors = "ApexSQL LLC"
$global:nugetOwners = "ApexSQL LLC"
$global:pushSource = "cicd.apexsql"
$global:apiKey = "*******"
$global:userName = "user@email.com"
$global:password = "*******"
$global:nugetExePath = "C:\Program Files\ApexSQL\ApexSQL CICD toolkit\Modules\ApexSQL_cicd\nuget.exe"

#Email server settings used for notifications
$notificationSettings = New-ApexSQLNotificationSettings -EmailAddress "*******@gmail.com" -Password "*******" -SmtpServer "smtp.gmail.com" -Port 587 -UseSSL

#Global options (pipeline name, output folder location and notification settings)
$options = New-ApexSqlOptions -PipelineName "CI_Pipeline" -NotificationSettings $notificationSettings

#endregion


#region Data source definitions

#Define data source
$dsSC = New-ApexSQLSource -ConnectionName "git_source" -Source_Type "git" -Repository "https://github.com/poticnenad/baza" -Project "baza" -Branch "master" -UserName "poticnenad@gmail.com" -Password "nenadP1984"

#Define target: new database (testing)
$dsQA = New-ApexSqlDatabaseConnection -ConnectionName "qaDB_dest" -Server "." -Database "ps_tempDB" -WindowsAuthentication

#endregion


#region CI pipeline steps in order of execution

#Notification step
#Invoke-ApexSqlNotifyStep -Options $options -DistributionList "*******@gmail.com" -Status started

#Build step
Invoke-ApexSqlBuildStep -Options $options -Source $dsSC -Database $dsQA | Out-Null

#Populate step
Invoke-ApexSqlPopulateStep -Options $options -Database $dsQA -RowCount 1000 -FillOnlyEmptyTables $true | Out-Null

#Audit step
#Invoke-ApexSqlAuditStep -Options $options -Database $dsQA | Out-Null

#Review step
#Invoke-ApexSqlReviewStep -Options $options -Database $dsQA -ProjectFile "Review_RuleBase.axrb" -Passed -Failed -Errors | Out-Null

#Test step
#Invoke-ApexSqlTestStep -Options $options -Database $dsQA -InstallSqlCop | Out-Null

#Package step
Invoke-ApexSqlPackageStep -Options $options -nugetVersion "1.0.1" -nugetReleaseNotes "Release_notes_here" | Out-Null

#Notification step
#Invoke-ApexSqlNotifyStep -Options $options -DistributionList "*******@gmail.com" -Status completed

#endregion


