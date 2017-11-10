SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_d_AUDIT_StatickiPodaci]
ON [dbo].[StatickiPodaci]
FOR DELETE
	NOT FOR REPLICATION
AS
-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"
-- --------------------------------------------------------------------------------------------------------------
-- Legal:        You may freely edit and modify this template and make copies of it.
-- Description:  DELETE TRIGGER for Table:  [dbo].[StatickiPodaci]
-- Author:       ApexSQL Software
-- Date:		 11/10/2017 3:37:39 PM
-- --------------------------------------------------------------------------------------------------------------
BEGIN
	DECLARE 
		@IDENTITY_SAVE				varchar(50),
		@AUDIT_LOG_TRANSACTION_ID		Int,
		@PRIM_KEY				nvarchar(4000),
		--@TABLE_NAME				nvarchar(4000),
 		@ROWS_COUNT				int
	SET NOCOUNT ON
	--Set @TABLE_NAME = '[dbo].[StatickiPodaci]'
	Select @ROWS_COUNT=count(*) from deleted
	Set @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))
	INSERT
	INTO [baza_new].dbo.AUDIT_LOG_TRANSACTIONS
	(
		TABLE_NAME,
		TABLE_SCHEMA,
		AUDIT_ACTION_ID,
		HOST_NAME,
		APP_NAME,
		MODIFIED_BY,
		MODIFIED_DATE,
		AFFECTED_ROWS,
		[DATABASE]
	)
	values(
		'StatickiPodaci',
		'dbo',
		3,	--	ACTION ID For DELETE
		CASE 
		  WHEN LEN(HOST_NAME()) < 1 THEN ' '
		  ELSE HOST_NAME()
		END,
		CASE 
		  WHEN LEN(APP_NAME()) < 1 THEN ' '
		  ELSE APP_NAME()
		END,
		SUSER_SNAME(),
		GETDATE(),
		@ROWS_COUNT,
		'baza_new'
	)
	Set @AUDIT_LOG_TRANSACTION_ID = SCOPE_IDENTITY()
	INSERT
	INTO [baza_new].dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG,
		DATA_TYPE
		, KEY1
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		convert(nvarchar(1500), IsNull('[statickiPodaciID]='+CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0), '[statickiPodaciID] Is Null')),
		'statickiPodaciID',
		CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0),
		'A'
		,  CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0))
	FROM deleted OLD
	WHERE
		OLD.[statickiPodaciID] Is Not Null
	INSERT
	INTO [baza_new].dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG,
		DATA_TYPE
		, KEY1
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		convert(nvarchar(1500), IsNull('[statickiPodaciID]='+CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0), '[statickiPodaciID] Is Null')),
		'StatickiPodaciInt',
		CONVERT(nvarchar(4000), OLD.[StatickiPodaciInt], 0),
		'A'
		,  CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0))
	FROM deleted OLD
	WHERE
		OLD.[StatickiPodaciInt] Is Not Null
	INSERT
	INTO [baza_new].dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG,
		DATA_TYPE
		, KEY1
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		convert(nvarchar(1500), IsNull('[statickiPodaciID]='+CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0), '[statickiPodaciID] Is Null')),
		'StatickiPodaciDate',
		CONVERT(nvarchar(4000), OLD.[StatickiPodaciDate], 0),
		'A'
		,  CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0))
	FROM deleted OLD
	WHERE
		OLD.[StatickiPodaciDate] Is Not Null
	INSERT
	INTO [baza_new].dbo.AUDIT_LOG_DATA
	(
		AUDIT_LOG_TRANSACTION_ID,
		PRIMARY_KEY_DATA,
		COL_NAME,
		OLD_VALUE_LONG,
		DATA_TYPE
		, KEY1
	)
	SELECT
		@AUDIT_LOG_TRANSACTION_ID,
		convert(nvarchar(1500), IsNull('[statickiPodaciID]='+CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0), '[statickiPodaciID] Is Null')),
		'StatickiPodaciVarChar',
		CONVERT(nvarchar(4000), OLD.[StatickiPodaciVarChar], 0),
		'A'
		,  CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0))
	FROM deleted OLD
	WHERE
		OLD.[StatickiPodaciVarChar] Is Not Null
	-- Lookup
  -- Restore @@IDENTITY Value
    DECLARE @maxprec AS varchar(2)
    SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
    EXEC('SELECT IDENTITY(decimal('+@maxprec+',0),'+@IDENTITY_SAVE+',1) id INTO #tmp')
END
GO
EXEC sp_settriggerorder @triggername= '[dbo].[tr_d_AUDIT_StatickiPodaci]', @order='Last', @stmttype='DELETE'
GO
