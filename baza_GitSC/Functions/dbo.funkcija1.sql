SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION dbo.funkcija1
(
	-- Add the parameters for the function here
)
RETURNS INTEGER 
AS
BEGIN
	-- Declare the return variable here

	-- Add the T-SQL statements to compute the return value here
	DECLARE @varInt INTEGER 
	SET @VarInt =  2 + 8

	-- Return the result of the function
	RETURN @varInt

END
GO
