SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Nova tabela] (
		[ID]            [int] NOT NULL,
		[intColumn]     [int] NULL,
		CONSTRAINT [PK_Nova tabela]
		PRIMARY KEY
		CLUSTERED
		([ID])
	ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Nova tabela] SET (LOCK_ESCALATION = TABLE)
GO
