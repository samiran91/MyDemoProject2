
alter PROC [dbo].[usp_ResetPassword](
	@MOBILENUMBER VARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON;

	 DECLARE @USERNAME NVARCHAR(100);
     DECLARE @EMAIL NVARCHAR(100);
	 DECLARE @USERID INT;

	 Select @USERNAME = NAME, @EMAIL = EMAIL, @USERID=PERSONID from PERSON where PERSONID=(Select PERSONID from Users where  UserName = @MOBILENUMBER  and UserName!='admin')

	  IF(@USERNAME IS NOT NULL)
		BEGIN
			--If username exists
			DECLARE @GUID UniqueIdentifier
			SET @GUID = NEWID()
  
			INSERT INTO ResetPasswordRequests(Id, UserId, ResetRequestDateTime, IsDeleted) VALUES(@GUID, @USERID, GETDATE(),1)
  
			SELECT 1 AS ReturnCode, @GUID AS UniqueId, @Email AS Email, @USERNAME AS USERNAME
 END
 ELSE
 BEGIN
			--If username does not exist
			SELECT 0 AS ReturnCode, NULL AS UniqueId, NULL AS Email, NULL AS USERNAME
 END


END

GO


