SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Table_2] (
		[id]        [int] NOT NULL,
		[data]      [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[data2]     [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[data3]     [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		[data4]     [nchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
		CONSTRAINT [PK_Table_2]
		PRIMARY KEY
		CLUSTERED
		([id])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Table_2] SET (LOCK_ESCALATION = TABLE)
GO
