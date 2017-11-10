SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [abc].[tr_u_AUDIT_Table_1]
ON [abc].[Table_1]
FOR UPDATE
	NOT FOR REPLICATION
As
-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"
-- --------------------------------------------------------------------------------------------------------------
-- Legal:        You may freely edit and modify this template and make copies of it.
-- Description:  UPDATE TRIGGER for Table:  [abc].[Table_1]
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
	--Set @TABLE_NAME = '[abc].[Table_1]'
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
		'Table_1',
		'abc',
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
	If UPDATE([kolonaID])
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
		    convert(nvarchar(1500), IsNull('[kolonaID]='+CONVERT(nvarchar(4000), IsNull(OLD.[kolonaID], NEW.[kolonaID]), 0), '[kolonaID] Is Null')),
		    'kolonaID',
			CONVERT(nvarchar(4000), OLD.[kolonaID], 0),
			CONVERT(nvarchar(4000), NEW.[kolonaID], 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[kolonaID], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[kolonaID], 0)))
		FROM deleted OLD Full Outer Join inserted NEW On
			(CONVERT(nvarchar(4000), NEW.[kolonaID], 0)=CONVERT(nvarchar(4000), OLD.[kolonaID], 0) or (NEW.[kolonaID] Is Null and OLD.[kolonaID] Is Null))
			WHERE (
				(
					NEW.[kolonaID] <>
					OLD.[kolonaID]
				) Or
				(
					NEW.[kolonaID] Is Null And
					OLD.[kolonaID] Is Not Null
				) Or
				(
					NEW.[kolonaID] Is Not Null And
					OLD.[kolonaID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	If UPDATE([kolonaInt])
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
		    convert(nvarchar(1500), IsNull('[kolonaID]='+CONVERT(nvarchar(4000), IsNull(OLD.[kolonaID], NEW.[kolonaID]), 0), '[kolonaID] Is Null')),
		    'kolonaInt',
			CONVERT(nvarchar(4000), OLD.[kolonaInt], 0),
			CONVERT(nvarchar(4000), NEW.[kolonaInt], 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[kolonaID], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[kolonaID], 0)))
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[kolonaID], 0)=CONVERT(nvarchar(4000), OLD.[kolonaID], 0) or (NEW.[kolonaID] Is Null and OLD.[kolonaID] Is Null))
			where (
				(
					NEW.[kolonaInt] <>
					OLD.[kolonaInt]
				) Or
				(
					NEW.[kolonaInt] Is Null And
					OLD.[kolonaInt] Is Not Null
				) Or
				(
					NEW.[kolonaInt] Is Not Null And
					OLD.[kolonaInt] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	If UPDATE([kolona VarChar])
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
		    convert(nvarchar(1500), IsNull('[kolonaID]='+CONVERT(nvarchar(4000), IsNull(OLD.[kolonaID], NEW.[kolonaID]), 0), '[kolonaID] Is Null')),
		    'kolona VarChar',
			CONVERT(nvarchar(4000), OLD.[kolona VarChar], 0),
			CONVERT(nvarchar(4000), NEW.[kolona VarChar], 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[kolonaID], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[kolonaID], 0)))
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[kolonaID], 0)=CONVERT(nvarchar(4000), OLD.[kolonaID], 0) or (NEW.[kolonaID] Is Null and OLD.[kolonaID] Is Null))
			where (
				(
					NEW.[kolona VarChar] <>
					OLD.[kolona VarChar]
				) Or
				(
					NEW.[kolona VarChar] Is Null And
					OLD.[kolona VarChar] Is Not Null
				) Or
				(
					NEW.[kolona VarChar] Is Not Null And
					OLD.[kolona VarChar] Is Null
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
EXEC sp_settriggerorder @triggername= '[abc].[tr_u_AUDIT_Table_1]', @order='Last', @stmttype='UPDATE'
GO
