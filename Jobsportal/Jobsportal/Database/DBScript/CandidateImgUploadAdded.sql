



ALTER PROC [dbo].[USP_PERSON_CANDIDATEINSERTUPDATE]



(



	@STR_NAME VARCHAR(100),



	@STR_GENDER VARCHAR(10),



	@DT_DOB DATETIME,



	@STR_ADDRESS VARCHAR(500),



	@STR_EMAIL VARCHAR(50),



	@STR_MOBILE VARCHAR(50),



	@STR_QUALIFICATION NVARCHAR(MAX),



	@STR_EXPERIANCE NVARCHAR(MAX),



	@STR_INTEREST NVARCHAR(500),



	@INT_DBOPERATION INT,



	@STR_CANDIDATEIMG VARCHAR(200)



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



	



	INSERT INTO PERSON (PERSONID,NAME,GENDER,DOB,ADDRESS,EMAIL,MOBILE,QUALIFICATION,EXPERIANCE,INTEREST,IMGPATH) VALUES (@INT_MAXID,@STR_NAME,@STR_GENDER,@DT_DOB,@STR_ADDRESS,@STR_EMAIL,@STR_MOBILE,@STR_QUALIFICATION,@STR_EXPERIANCE,@STR_INTEREST,@STR_CANDIDATEIMG)







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












