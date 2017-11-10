SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_u_AUDIT_dodataPrva]
ON [dbo].[dodataPrva]
FOR UPDATE
	NOT FOR REPLICATION
As
-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"
-- --------------------------------------------------------------------------------------------------------------
-- Legal:        You may freely edit and modify this template and make copies of it.
-- Description:  UPDATE TRIGGER for Table:  [dbo].[dodataPrva]
-- Author:       ApexSQL Software
-- Date:		 11/10/2017 3:37:39 PM
-- --------------------------------------------------------------------------------------------------------------
BEGIN
	DECLARE 
		@IDENTITY_SAVE			varchar(50),
		@AUDIT_LOG_TRANSACTION_ID	Int,
		@PRIM_KEY			nvarchar(4000),
		@Inserted	    		bit,
		--@TABLE_NAME				nvarchar(4000),
 		@ROWS_COUNT				int
	SET NOCOUNT ON
	--Set @TABLE_NAME = '[dbo].[dodataPrva]'
	Select @ROWS_COUNT=count(*) from inserted
	SET @IDENTITY_SAVE = CAST(IsNull(@@IDENTITY,1) AS varchar(50))
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
		'dodataPrva',
		'dbo',
		1,	--	ACTION ID For UPDATE
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
	SET @Inserted = 0
	If UPDATE([id])
	BEGIN
		INSERT
		INTO [baza_new].dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG,
			DATA_TYPE
			, KEY1
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
		    convert(nvarchar(1500), IsNull('[id]='+CONVERT(nvarchar(4000), IsNull(OLD.[id], NEW.[id]), 0), '[id] Is Null')),
		    'id',
			CONVERT(nvarchar(4000), OLD.[id], 0),
			CONVERT(nvarchar(4000), NEW.[id], 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[id], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[id], 0)))
		FROM deleted OLD Full Outer Join inserted NEW On
			(CONVERT(nvarchar(4000), NEW.[id], 0)=CONVERT(nvarchar(4000), OLD.[id], 0) or (NEW.[id] Is Null and OLD.[id] Is Null))
			WHERE (
				(
					NEW.[id] <>
					OLD.[id]
				) Or
				(
					NEW.[id] Is Null And
					OLD.[id] Is Not Null
				) Or
				(
					NEW.[id] Is Not Null And
					OLD.[id] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	If UPDATE([colInt])
	BEGIN
		INSERT
		INTO [baza_new].dbo.AUDIT_LOG_DATA
		(
			AUDIT_LOG_TRANSACTION_ID,
			PRIMARY_KEY_DATA,
			COL_NAME,
			OLD_VALUE_LONG,
			NEW_VALUE_LONG,
			DATA_TYPE
			, KEY1
		)
		SELECT
			@AUDIT_LOG_TRANSACTION_ID,
		    convert(nvarchar(1500), IsNull('[id]='+CONVERT(nvarchar(4000), IsNull(OLD.[id], NEW.[id]), 0), '[id] Is Null')),
		    'colInt',
			CONVERT(nvarchar(4000), OLD.[colInt], 0),
			CONVERT(nvarchar(4000), NEW.[colInt], 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[id], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[id], 0)))
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[id], 0)=CONVERT(nvarchar(4000), OLD.[id], 0) or (NEW.[id] Is Null and OLD.[id] Is Null))
			where (
				(
					NEW.[colInt] <>
					OLD.[colInt]
				) Or
				(
					NEW.[colInt] Is Null And
					OLD.[colInt] Is Not Null
				) Or
				(
					NEW.[colInt] Is Not Null And
					OLD.[colInt] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	-- Watch
    --'
	-- Lookup
	IF @Inserted = 0
	BEGIN
		DELETE FROM [baza_new].dbo.AUDIT_LOG_TRANSACTIONS WHERE AUDIT_LOG_TRANSACTION_ID = @AUDIT_LOG_TRANSACTION_ID
	END
  -- Restore @@IDENTITY Value
    DECLARE @maxprec AS varchar(2)
    SET @maxprec=CAST(@@MAX_PRECISION as varchar(2))
    EXEC('SELECT IDENTITY(decimal('+@maxprec+',0),'+@IDENTITY_SAVE+',1) id INTO #tmp')
End
GO
EXEC sp_settriggerorder @triggername= '[dbo].[tr_u_AUDIT_dodataPrva]', @order='Last', @stmttype='UPDATE'
GO
