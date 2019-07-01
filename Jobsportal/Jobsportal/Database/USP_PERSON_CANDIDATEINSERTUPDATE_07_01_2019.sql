











ALTER PROC [dbo].[USP_PERSON_CANDIDATEINSERTUPDATE]







(







	@STR_NAME VARCHAR(100),







	@STR_GENDER VARCHAR(10)= NULL,







	@DT_DOB DATETIME = NULL,







	@STR_ADDRESS VARCHAR(500) = NULL,







	@STR_EMAIL VARCHAR(50),







	@STR_MOBILE VARCHAR(50),







	@STR_QUALIFICATION NVARCHAR(MAX) = NULL,







	@STR_EXPERIANCE NVARCHAR(MAX) = NULL,







	@STR_INTEREST NVARCHAR(500) = NULL,







	@INT_DBOPERATION INT,







	@STR_CANDIDATEIMG VARCHAR(200) = NULL







)







AS







BEGIN







BEGIN TRY















DECLARE @STR_MESSAGE VARCHAR(200);







DECLARE @INT_SUCCESS INT = 0;







DECLARE @INT_MAXID INT=0;







IF @INT_DBOPERATION = 0 







BEGIN



	



	SELECT @INT_MAXID = MAX(ID) FROM PERSON







	IF @INT_MAXID IS NULL



		BEGIN 







			SET @INT_MAXID=10000







		END







    ELSE







	   BEGIN 







			SET @INT_MAXID = @INT_MAXID + 1







	   END







	



	if not exists (select USERNAME from Users  where USERNAME =@STR_MOBILE )

	BEGIN



	INSERT INTO PERSON (PERSONID,NAME,GENDER,DOB,ADDRESS,EMAIL,MOBILE,QUALIFICATION,EXPERIANCE,INTEREST,IMGPATH) VALUES (@INT_MAXID,@STR_NAME,@STR_GENDER,@DT_DOB,@STR_ADDRESS,@STR_EMAIL,@STR_MOBILE,@STR_QUALIFICATION,@STR_EXPERIANCE,@STR_INTEREST,@STR_CANDIDATEIMG)





	END

	ELSE

	BEGIN

	Update person set  NAME=@STR_NAME,GENDER=@STR_GENDER,DOB=@DT_DOB,ADDRESS=@STR_ADDRESS,EMAIL=@STR_EMAIL,QUALIFICATION=@STR_QUALIFICATION,EXPERIANCE=@STR_EXPERIANCE,INTEREST=@STR_INTEREST,IMGPATH=@STR_CANDIDATEIMG where PERSONID=(select PERSONID from Users
  where USERNAME =@STR_MOBILE)



	END



	SET @STR_MESSAGE = 'InsertSuccess';







	SET @INT_SUCCESS = 1;















	END







	ELSE







	BEGIN















		UPDATE PERSON SET NAME=@STR_NAME WHERE PERSONID='00000'















		SET @STR_MESSAGE = 'Update Success';







	SET @INT_SUCCESS = 1;















	END























	SELECT @STR_MESSAGE AS Message,







	@INT_SUCCESS AS Success 















	END TRY







	BEGIN CATCH







	   DECLARE @ErrorMessage NVARCHAR(4000) ;







            DECLARE @ErrorSeverity INT ;







            DECLARE @ErrorState INT ;















            SELECT  @ErrorMessage = ERROR_MESSAGE() ,







                    @ErrorSeverity = ERROR_SEVERITY() ,







                    @ErrorState = ERROR_STATE()















            RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState) ;







	







       END CATCH







END




























