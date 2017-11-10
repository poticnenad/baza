SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[tr_u_AUDIT_StatickiPodaci]
ON [dbo].[StatickiPodaci]
FOR UPDATE
	NOT FOR REPLICATION
As
-- "<TAG>SQLAUDIT GENERATED - DO NOT REMOVE</TAG>"
-- --------------------------------------------------------------------------------------------------------------
-- Legal:        You may freely edit and modify this template and make copies of it.
-- Description:  UPDATE TRIGGER for Table:  [dbo].[StatickiPodaci]
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
	--Set @TABLE_NAME = '[dbo].[StatickiPodaci]'
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
		'StatickiPodaci',
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
	If UPDATE([statickiPodaciID])
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
		    convert(nvarchar(1500), IsNull('[statickiPodaciID]='+CONVERT(nvarchar(4000), IsNull(OLD.[statickiPodaciID], NEW.[statickiPodaciID]), 0), '[statickiPodaciID] Is Null')),
		    'statickiPodaciID',
			CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0),
			CONVERT(nvarchar(4000), NEW.[statickiPodaciID], 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[statickiPodaciID], 0)))
		FROM deleted OLD Full Outer Join inserted NEW On
			(CONVERT(nvarchar(4000), NEW.[statickiPodaciID], 0)=CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0) or (NEW.[statickiPodaciID] Is Null and OLD.[statickiPodaciID] Is Null))
			WHERE (
				(
					NEW.[statickiPodaciID] <>
					OLD.[statickiPodaciID]
				) Or
				(
					NEW.[statickiPodaciID] Is Null And
					OLD.[statickiPodaciID] Is Not Null
				) Or
				(
					NEW.[statickiPodaciID] Is Not Null And
					OLD.[statickiPodaciID] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	If UPDATE([StatickiPodaciInt])
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
		    convert(nvarchar(1500), IsNull('[statickiPodaciID]='+CONVERT(nvarchar(4000), IsNull(OLD.[statickiPodaciID], NEW.[statickiPodaciID]), 0), '[statickiPodaciID] Is Null')),
		    'StatickiPodaciInt',
			CONVERT(nvarchar(4000), OLD.[StatickiPodaciInt], 0),
			CONVERT(nvarchar(4000), NEW.[StatickiPodaciInt], 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[statickiPodaciID], 0)))
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[statickiPodaciID], 0)=CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0) or (NEW.[statickiPodaciID] Is Null and OLD.[statickiPodaciID] Is Null))
			where (
				(
					NEW.[StatickiPodaciInt] <>
					OLD.[StatickiPodaciInt]
				) Or
				(
					NEW.[StatickiPodaciInt] Is Null And
					OLD.[StatickiPodaciInt] Is Not Null
				) Or
				(
					NEW.[StatickiPodaciInt] Is Not Null And
					OLD.[StatickiPodaciInt] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	If UPDATE([StatickiPodaciDate])
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
		    convert(nvarchar(1500), IsNull('[statickiPodaciID]='+CONVERT(nvarchar(4000), IsNull(OLD.[statickiPodaciID], NEW.[statickiPodaciID]), 0), '[statickiPodaciID] Is Null')),
		    'StatickiPodaciDate',
			CONVERT(nvarchar(4000), OLD.[StatickiPodaciDate], 0),
			CONVERT(nvarchar(4000), NEW.[StatickiPodaciDate], 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[statickiPodaciID], 0)))
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[statickiPodaciID], 0)=CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0) or (NEW.[statickiPodaciID] Is Null and OLD.[statickiPodaciID] Is Null))
			where (
				(
					NEW.[StatickiPodaciDate] <>
					OLD.[StatickiPodaciDate]
				) Or
				(
					NEW.[StatickiPodaciDate] Is Null And
					OLD.[StatickiPodaciDate] Is Not Null
				) Or
				(
					NEW.[StatickiPodaciDate] Is Not Null And
					OLD.[StatickiPodaciDate] Is Null
				)
				)
		SET @Inserted = CASE WHEN @@ROWCOUNT > 0 Then 1 Else @Inserted End
	END
	If UPDATE([StatickiPodaciVarChar])
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
		    convert(nvarchar(1500), IsNull('[statickiPodaciID]='+CONVERT(nvarchar(4000), IsNull(OLD.[statickiPodaciID], NEW.[statickiPodaciID]), 0), '[statickiPodaciID] Is Null')),
		    'StatickiPodaciVarChar',
			CONVERT(nvarchar(4000), OLD.[StatickiPodaciVarChar], 0),
			CONVERT(nvarchar(4000), NEW.[StatickiPodaciVarChar], 0),
			'A'
			, IsNULL( CONVERT(nvarchar(500), CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0)), CONVERT(nvarchar(500), CONVERT(nvarchar(4000), NEW.[statickiPodaciID], 0)))
		FROM deleted OLD Inner Join inserted NEW On 
			(CONVERT(nvarchar(4000), NEW.[statickiPodaciID], 0)=CONVERT(nvarchar(4000), OLD.[statickiPodaciID], 0) or (NEW.[statickiPodaciID] Is Null and OLD.[statickiPodaciID] Is Null))
			where (
				(
					NEW.[StatickiPodaciVarChar] <>
					OLD.[StatickiPodaciVarChar]
				) Or
				(
					NEW.[StatickiPodaciVarChar] Is Null And
					OLD.[StatickiPodaciVarChar] Is Not Null
				) Or
				(
					NEW.[StatickiPodaciVarChar] Is Not Null And
					OLD.[StatickiPodaciVarChar] Is Null
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
EXEC sp_settriggerorder @triggername= '[dbo].[tr_u_AUDIT_StatickiPodaci]', @order='Last', @stmttype='UPDATE'
GO
