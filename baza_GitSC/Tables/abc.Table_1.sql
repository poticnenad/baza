SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [abc].[Table_1] (
		[kolonaID]           [int] NOT NULL,
		[kolonaInt]          [int] NULL,
		[kolona VarChar]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [abc].[Table_1]
	ADD
	CONSTRAINT [PK_Table_1]
	PRIMARY KEY
	CLUSTERED
	([kolonaID])
	ON [PRIMARY]
GO
ALTER TABLE [abc].[Table_1] SET (LOCK_ESCALATION = TABLE)
GO
