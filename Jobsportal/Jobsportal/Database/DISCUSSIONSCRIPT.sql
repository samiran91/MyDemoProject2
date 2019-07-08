ALTER PROC USP_FETCHDISSCUSSION
(
	@JobNumber INT,
	@USERNAME NVARCHAR(MAX),
	@MESSAGES NVARCHAR(MAX)
)

AS
 BEGIN

			SET NOCOUNT ON
			DECLARE @CID INT = 0;

			SELECT @CID = MAX(CHATID) FROM DISCUSSION

				IF @CID IS NULL

						BEGIN 

							SET @CID=10000

						END

				ELSE
					   BEGIN 

							SET @CID = @CID + 1


	                   END

			INSERT INTO DISCUSSION(CHATID,USERNAME,JOBNO,MESSAGES,MSGDATETIME) VALUES (@CID,@USERNAME,@JobNumber,@MESSAGES,GETDATE())
 END
