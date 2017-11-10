SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION ut.ut_funkcija
(
	-- Add the parameters for the function here
)
RETURNS VARCHAR
AS
BEGIN
	-- Declare the return variable here
	

	-- Add the T-SQL statements to compute the return value here
	DECLARE @out VARCHAR(20)
	SET @out = 'Uspesno!'

	-- Return the result of the function
	RETURN @out

END
GO
