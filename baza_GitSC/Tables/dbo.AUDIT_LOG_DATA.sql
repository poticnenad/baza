SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AUDIT_LOG_DATA] (
		[AUDIT_LOG_DATA_ID]            [int] IDENTITY(1, 1) NOT NULL,
		[AUDIT_LOG_TRANSACTION_ID]     [int] NOT NULL,
		[PRIMARY_KEY_DATA]             [nvarchar](1500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[COL_NAME]                     [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[OLD_VALUE_LONG]               [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NEW_VALUE_LONG]               [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[NEW_VALUE_BLOB]               [image] NULL,
		[NEW_VALUE]                    AS (isnull(CONVERT([nvarchar](4000),[NEW_VALUE_LONG]),CONVERT([varchar](8000),CONVERT([varbinary](8000),substring([NEW_VALUE_BLOB],(1),(8000)))))),
		[OLD_VALUE]                    AS (CONVERT([nvarchar](4000),[OLD_VALUE_LONG])),
		[PRIMARY_KEY]                  AS ([PRIMARY_KEY_DATA]),
		[DATA_TYPE]                    [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		[KEY1]                         [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KEY2]                         [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KEY3]                         [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[KEY4]                         [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK__AUDIT_LO__40D2552D2D302BFE]
		PRIMARY KEY
		CLUSTERED
		([AUDIT_LOG_DATA_ID])
	ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[AUDIT_LOG_DATA]
	ADD
	CONSTRAINT [DF__AUDIT_LOG__DATA___33D4B598]
	DEFAULT ('A') FOR [DATA_TYPE]
GO
ALTER TABLE [dbo].[AUDIT_LOG_DATA]
	WITH CHECK
	ADD CONSTRAINT [FK_AUDIT_LOG_TRANSACTION_ID]
	FOREIGN KEY ([AUDIT_LOG_TRANSACTION_ID]) REFERENCES [dbo].[AUDIT_LOG_TRANSACTIONS] ([AUDIT_LOG_TRANSACTION_ID])
ALTER TABLE [dbo].[AUDIT_LOG_DATA]
	CHECK CONSTRAINT [FK_AUDIT_LOG_TRANSACTION_ID]

GO
CREATE NONCLUSTERED INDEX [IDX1_AUDIT_LOG_DATA]
	ON [dbo].[AUDIT_LOG_DATA] ([COL_NAME])
	ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IDX2_AUDIT_LOG_DATA]
	ON [dbo].[AUDIT_LOG_DATA] ([AUDIT_LOG_TRANSACTION_ID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[AUDIT_LOG_DATA] SET (LOCK_ESCALATION = TABLE)
GO
