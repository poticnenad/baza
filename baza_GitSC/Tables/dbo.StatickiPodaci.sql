SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StatickiPodaci] (
		[statickiPodaciID]          [int] NOT NULL,
		[StatickiPodaciInt]         [int] NULL,
		[StatickiPodaciDate]        [date] NULL,
		[StatickiPodaciVarChar]     [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StatickiPodaci]
	ADD
	CONSTRAINT [PK_StatickiPodaci]
	PRIMARY KEY
	CLUSTERED
	([statickiPodaciID])
	ON [PRIMARY]
GO
ALTER TABLE [dbo].[StatickiPodaci] SET (LOCK_ESCALATION = TABLE)
GO
