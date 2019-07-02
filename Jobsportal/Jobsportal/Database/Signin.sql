

ALTER PROC [dbo].[USP_SIGNUP]

(

	@STR_NAME NVARCHAR(MAX),

	@STR_MOBILE VARCHAR(50),

	@STR_EMAIL VARCHAR(50),

	@STR_PASSWORD NVARCHAR(MAX)

)



AS



BEGIN



BEGIN TRY







DECLARE @STR_MESSAGE VARCHAR(200);



DECLARE @INT_SUCCESS INT = 0;



DECLARE @INT_MAXID INT=0;

DECLARE @INT_COUNT INT=0;





BEGIN



	BEGIN TRANSACTION



	SELECT @INT_MAXID = MAX(ID) FROM PERSON

	SELECT @INT_COUNT = COUNT(USERNAME) FROM USERS WHERE USERNAME=@STR_MOBILE


	   IF(@INT_COUNT > 0)

			BEGIN


				SET @STR_MESSAGE='MOBILE_EXISTS';



				SET @INT_SUCCESS=0;




				

			END

     ELSE

	       BEGIN

		      	IF @INT_MAXID IS NULL

					BEGIN 



						SET @INT_MAXID=10000



					END



				ELSE



					BEGIN 



						SET @INT_MAXID = @INT_MAXID + 1



				END



						INSERT INTO PERSON (PERSONID,NAME,GENDER,EMAIL,MOBILE) VALUES (@INT_MAXID,@STR_NAME,'SELECT',@STR_EMAIL,@STR_MOBILE)



						INSERT INTO USERS(USERNAME,PASSWORD,ROLES,PERSONID,ISACTIVE) VALUES(@STR_MOBILE,@STR_PASSWORD,'CANDIDATE',@INT_MAXID,1)





						SET @STR_MESSAGE = 'InsertSuccess';



						SET @INT_SUCCESS = 1;

		END
	







	COMMIT TRANSACTION





	END



	SELECT @STR_MESSAGE AS Message, @INT_SUCCESS AS Success 







	END TRY









	BEGIN CATCH

		    ROLLBACK TRANSACTION

			DECLARE @ErrorMessage NVARCHAR(4000) ;

				DECLARE @ErrorSeverity INT ;

				DECLARE @ErrorState INT ;

				SELECT  @ErrorMessage = ERROR_MESSAGE() ,

						@ErrorSeverity = ERROR_SEVERITY() ,

						@ErrorState = ERROR_STATE()

				RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState) ;

    END CATCH

END
GO


