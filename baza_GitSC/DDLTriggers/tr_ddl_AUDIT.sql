SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [tr_ddl_AUDIT]
ON DATABASE 
FOR
DDL_DATABASE_LEVEL_EVENTS
AS
-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"
-- --------------------------------------------------------------------------------------------------------------
-- Legal:        You may freely edit and modify this template and make copies of it.
-- Description:  DDL TRIGGER for auditing DDL_DATABASE_LEVEL_EVENTS
-- Author:       ApexSQL Software
BEGIN
	DECLARE @data XML;
	DECLARE @databaseName nvarchar(100);
	DECLARE @schemaName nvarchar(100);
	DECLARE @objectType nvarchar(100);
	DECLARE @objectName nvarchar(100);
	DECLARE @action nvarchar(100);
	DECLARE @oldValue nvarchar(100);
	DECLARE @newValue nvarchar(100);
	DECLARE @modifiedBy nvarchar(100);
	DECLARE @modifiedDate datetime;
  DECLARE @appName nvarchar(100);
  DECLARE @hostName nvarchar(100);
  DECLARE @ddlDescription nvarchar(100);
  DECLARE @sqlCommand nvarchar(1000);
  SET NOCOUNT ON
	SET @data = EVENTDATA();
	SET @databaseName = @data.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'nvarchar(100)');
	SET @schemaName = @data.value('(/EVENT_INSTANCE/SchemaName)[1]', 'nvarchar(100)');
	SET @objectType = @data.value('(/EVENT_INSTANCE/ObjectType)[1]', 'nvarchar(100)');
	SET @objectName = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)');
	SET @action = @data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)');
	SET @oldValue = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)');
  SET @newValue = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)');
	SET @modifiedBy = @data.value('(/EVENT_INSTANCE/LoginName)[1]', 'nvarchar(100)');
	SET @modifiedDate = GETDATE();
  SET @appName = APP_NAME();
  SET @hostName = HOST_NAME();
  SET @ddlDescription = N' ';
  SET @sqlCommand = @data.value('(/EVENT_INSTANCE/TSQLCommand/CommandText)[1]', 'nvarchar(1000)');
  IF @action LIKE '%CREATE%'
    BEGIN
      SET @ddlDescription = UPPER(LEFT(@objectType,1))+LOWER(SUBSTRING(@objectType,2,LEN(@objectType))) + ' created';
      SET @oldValue = N'';
	    SET @action = 'CREATE';
    END
  ELSE IF @action LIKE '%ALTER%'
    BEGIN
      IF @sqlCommand LIKE '%ALTER TABLE%' AND @sqlCommand LIKE '% ADD CONSTRAINT %'
        BEGIN
          SET @ddlDescription = 'Added constraint'
          SET @oldValue = N'';
		  SET @newValue = @data.value('(/EVENT_INSTANCE/AlterTableActionList/Create/Constraints/Name)[1]', 'nvarchar(100)');
        END
      ELSE IF @sqlCommand LIKE '%ALTER TABLE%' AND @sqlCommand LIKE '% ADD INDEX %'
        BEGIN
          SET @ddlDescription = 'Added index on column'
          SET @oldValue = N'';
        END
      ELSE IF @sqlCommand LIKE '%ALTER TABLE%' AND @sqlCommand LIKE '% ADD%'
        BEGIN
          SET @ddlDescription = 'Table column created'
          SET @oldValue = N'';
		  SET @newValue = @data.value('(/EVENT_INSTANCE/AlterTableActionList/Create/Columns/Name)[1]', 'nvarchar(100)');
        END
      ELSE IF @sqlCommand LIKE '%ALTER TABLE%' AND @sqlCommand LIKE '% ALTER COLUMN %'
        BEGIN
          SET @ddlDescription = 'Table column modified'
        END
      ELSE IF @sqlCommand LIKE '%ALTER TABLE%' AND @sqlCommand LIKE '% DROP COLUMN %'
        BEGIN
          SET @ddlDescription = 'Table column deleted'
          SET @newValue = N'';
		  SET @oldValue = @data.value('(/EVENT_INSTANCE/AlterTableActionList/Drop/Columns/Name)[1]', 'nvarchar(100)');
        END
      ELSE IF @sqlCommand LIKE '%ALTER TABLE%' AND @sqlCommand LIKE '% DROP CONSTRAINT %'
        BEGIN
          SET @ddlDescription = 'Constraint deleted'
          SET @newValue = N'';
		  SET @oldValue = @data.value('(/EVENT_INSTANCE/AlterTableActionList/Drop/Constraints/Name)[1]', 'nvarchar(100)');
        END
      ELSE IF @sqlCommand LIKE '%ALTER TABLE%' AND @sqlCommand LIKE '% DROP INDEX %'
        BEGIN
          SET @ddlDescription = 'Index deleted'
          SET @newValue = N'';
        END
      ELSE
        BEGIN
          SET @ddlDescription = UPPER(LEFT(@objectType,1))+LOWER(SUBSTRING(@objectType,2,LEN(@objectType))) + ' altered';
        END
	    SET @action = 'ALTER';
    END
  ELSE IF @action LIKE '%DROP%'
    BEGIN
      SET @ddlDescription = UPPER(LEFT(@objectType,1))+LOWER(SUBSTRING(@objectType,2,LEN(@objectType))) + ' deleted';
      SET @newValue = N'';
	    SET @action = 'DROP';
    END
  IF @action = 'RENAME' AND @objectType = 'COLUMN'
    BEGIN
	    SET @objectType = 'TABLE';
	    SET @objectName = @data.value('(/EVENT_INSTANCE/TargetObjectName)[1]', 'nvarchar(100)');
	    SET @action = 'ALTER';
      SET @oldValue = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)');
      SET @newValue = @data.value('(/EVENT_INSTANCE/NewObjectName)[1]', 'nvarchar(100)');
	    SET @ddlDescription = 'Table column renamed';
	  END
  ELSE IF @action = 'RENAME'
    BEGIN
	    SET @action = 'ALTER';
      SET @oldValue = @data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)');
      SET @newValue = @data.value('(/EVENT_INSTANCE/NewObjectName)[1]', 'nvarchar(100)');
	    SET @ddlDescription = UPPER(LEFT(@objectType,1))+LOWER(SUBSTRING(@objectType,2,LEN(@objectType))) + ' renamed';
	  END
  IF @objectName NOT LIKE '%TRIGGER_%' AND @objectName NOT LIKE '%AUDIT_%' AND @sqlCommand NOT LIKE '%LOCK_ESCALATION%'
    BEGIN
	    INSERT INTO AUDIT_LOG_DDL
	    (
		    [DATABASE],
		    [SCHEMA],
		    OBJECT_TYPE,
		    OBJECT_NAME,
		    ACTION,
		    OLD_VALUE,
		    NEW_VALUE,
		    MODIFIED_BY,
		    MODIFIED_DATE,
        APP_NAME,
        HOST_NAME,
        DESCRIPTION
	    ) 
	    VALUES 
	    (
		    @databaseName,
		    @schemaName,
		    @objectType,
		    @objectName,
		    @action,
		    @oldValue,
		    @newValue,
		    @modifiedBy,
		    @modifiedDate,
        @appName,
        @hostName,
        @ddlDescription
	    );
    END
END
GO
