SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[dodataPrva] (
		[id]         [int] NOT NULL,
		[colInt]     [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[dodataPrva]
	ADD
	CONSTRAINT [PK_dodataPrva]
	PRIMARY KEY
	CLUSTERED
	([id])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[dodataPrva] SET (LOCK_ESCALATION = TABLE)
GO
