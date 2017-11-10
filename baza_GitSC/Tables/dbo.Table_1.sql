SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Table_1] (
		[kolonaID]           [int] NOT NULL,
		[kolonaInt]          [int] NULL,
		[kolona VarChar]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[newInt]             [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_Table_1]
		PRIMARY KEY
		CLUSTERED
		([kolonaID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Table_1] SET (LOCK_ESCALATION = TABLE)
GO
