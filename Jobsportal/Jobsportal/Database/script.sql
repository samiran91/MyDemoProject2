USE [Jobsportal]
GO
ALTER TABLE [dbo].[USERS] DROP CONSTRAINT [TBLUSERS_PERSONID_FK]
GO
ALTER TABLE [dbo].[JOBIMPDATES] DROP CONSTRAINT [FK__JOBIMPDAT__JOBNO__38996AB5]
GO
ALTER TABLE [dbo].[JOBIMNOTES] DROP CONSTRAINT [FK__JOBIMNOTE__JOBNO__3D5E1FD2]
GO
ALTER TABLE [dbo].[JOBCOMMUNITY] DROP CONSTRAINT [FK__JOBCOMMUN__JOBNO__3A81B327]
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 07-02-2019 08:59:12 ******/
DROP TABLE [dbo].[USERS]
GO
/****** Object:  Table [dbo].[PERSON]    Script Date: 07-02-2019 08:59:12 ******/
DROP TABLE [dbo].[PERSON]
GO
/****** Object:  Table [dbo].[JOBIMPDATES]    Script Date: 07-02-2019 08:59:12 ******/
DROP TABLE [dbo].[JOBIMPDATES]
GO
/****** Object:  Table [dbo].[JOBIMNOTES]    Script Date: 07-02-2019 08:59:12 ******/
DROP TABLE [dbo].[JOBIMNOTES]
GO
/****** Object:  Table [dbo].[JOBCOMMUNITY]    Script Date: 07-02-2019 08:59:12 ******/
DROP TABLE [dbo].[JOBCOMMUNITY]
GO
/****** Object:  Table [dbo].[JOB]    Script Date: 07-02-2019 08:59:12 ******/
DROP TABLE [dbo].[JOB]
GO
/****** Object:  Table [dbo].[EmailServer]    Script Date: 07-02-2019 08:59:12 ******/
DROP TABLE [dbo].[EmailServer]
GO
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 07-02-2019 08:59:12 ******/
DROP TABLE [dbo].[ActivityLog]
GO
/****** Object:  StoredProcedure [dbo].[USP_SIGNUP]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[USP_SIGNUP]
GO
/****** Object:  StoredProcedure [dbo].[USP_PERSON_GETPERSONDETAILS]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[USP_PERSON_GETPERSONDETAILS]
GO
/****** Object:  StoredProcedure [dbo].[USP_PERSON_CANDIDATEINSERTUPDATE]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[USP_PERSON_CANDIDATEINSERTUPDATE]
GO
/****** Object:  StoredProcedure [dbo].[usp_JOBIMPDATES_GetEventDateTime]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[usp_JOBIMPDATES_GetEventDateTime]
GO
/****** Object:  StoredProcedure [dbo].[USP_JOBIMNOTES_INSERTIMNOTES]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[USP_JOBIMNOTES_INSERTIMNOTES]
GO
/****** Object:  StoredProcedure [dbo].[usp_JOBIMNOTES_GetJobNotes]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[usp_JOBIMNOTES_GetJobNotes]
GO
/****** Object:  StoredProcedure [dbo].[USP_JOBEVENTDATETIME_INSERTJOBDETAILS]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[USP_JOBEVENTDATETIME_INSERTJOBDETAILS]
GO
/****** Object:  StoredProcedure [dbo].[USP_JOB_INSERTUPDATE]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[USP_JOB_INSERTUPDATE]
GO
/****** Object:  StoredProcedure [dbo].[USP_JOB_INSERTJOBDETAILS]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[USP_JOB_INSERTJOBDETAILS]
GO
/****** Object:  StoredProcedure [dbo].[usp_Job_GetJobDetails]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[usp_Job_GetJobDetails]
GO
/****** Object:  StoredProcedure [dbo].[sp_TrySignIn]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[sp_TrySignIn]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetEmailConfig]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[sp_GetEmailConfig]
GO
/****** Object:  StoredProcedure [dbo].[sp_EmailServer_Save]    Script Date: 07-02-2019 08:59:12 ******/
DROP PROCEDURE [dbo].[sp_EmailServer_Save]
GO
/****** Object:  StoredProcedure [dbo].[sp_EmailServer_Save]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  procedure [dbo].[sp_EmailServer_Save](@Host nvarchar(max),@Port nvarchar(50),@SSL bit,@Email nvarchar(max),@Password nvarchar(max))
as

update EmailServer SET Host=@Host,Port=@Port,SSL=@SSL,Email=@Email,[Password]=@Password




GO
/****** Object:  StoredProcedure [dbo].[sp_GetEmailConfig]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_GetEmailConfig]
as
Select Host,Port,[SSL],Email,[Password] from EmailServer



GO
/****** Object:  StoredProcedure [dbo].[sp_TrySignIn]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE  procedure [dbo].[sp_TrySignIn](@username nvarchar(max),@password nvarchar(max))
as

Select Roles from Users where Username=@username and [Password]=@password and IsActive=1



GO
/****** Object:  StoredProcedure [dbo].[usp_Job_GetJobDetails]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_Job_GetJobDetails]

 @i_DBOP INT,
 @Keyword nvarchar(100)='',
   @Location nvarchar(100)='All',
    @Posted INT='-365'

AS

	BEGIN



		BEGIN TRY

		--SET NOCOUNT ON;
			IF(@i_DBOP=0)
			IF(LEN(@Keyword)>0)
				BEGIN
							SELECT JOBNO,JOBTITLE,JOBDESC,POSTEDDATE,QUALIFICATION,APPLYLINK,POINT = 2*(LEN(JOBTITLE) - LEN(REPLACE(JOBTITLE, @Keyword, '')))/LEN(@Keyword)+1 * (LEN(JOBDESC) - LEN(REPLACE(JOBDESC, @Keyword, '')))/LEN(@Keyword)+ 2 * (LEN(QUALIFICATION) - LEN(REPLACE(QUALIFICATION, @Keyword, '')))/LEN(@Keyword) FROM JOB
					where POSTEDDATE>DATEADD(DAY,@Posted,GETDATE()) and 1=1   order by POINT desc,posteddate desc
				END
ELSE
SELECT JOBNO,JOBTITLE,JOBDESC,POSTEDDATE,QUALIFICATION,APPLYLINK,0 as POINT FROM JOB where POSTEDDATE>DATEADD(DAY,@Posted,GETDATE()) and 1=1 order by posteddate desc
			ELSE

				BEGIN

					SELECT JOBNO,JOBTITLE,JOBDESC,POSTEDDATE,QUALIFICATION,APPLYLINK FROM JOB WHERE JOBNO=@i_DBOP

				END


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





GO
/****** Object:  StoredProcedure [dbo].[USP_JOB_INSERTJOBDETAILS]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[USP_JOB_INSERTJOBDETAILS]

(

	@STR_JOBTITLE NVARCHAR(100),

	@STR_JOBDESC NVARCHAR(MAX),

	@DT_JOBPOSTEDDATE DATETIME,

	@STR_QUALIFICATION NVARCHAR(300),

	@STR_APPLYLINK VARCHAR(500),
	@i_intJOBNO INT

)

AS

	BEGIN

		BEGIN TRY

			DECLARE @BIT_SUCCESS INT = 0;

			DECLARE @JOBNUMBER INT;
			if not exists (select JOBTITLE from JOB  where JOBNO =@i_intJOBNO)
			BEGIN
					INSERT INTO JOB(JOBTITLE,JOBDESC,POSTEDDATE,QUALIFICATION,APPLYLINK) VALUES (@STR_JOBTITLE,@STR_JOBDESC,@DT_JOBPOSTEDDATE,@STR_QUALIFICATION,@STR_APPLYLINK)

					SET @BIT_SUCCESS = 1;

					SET @JOBNUMBER= SCOPE_IDENTITY();

			SELECT @JOBNUMBER AS JOB_NUMBER, @BIT_SUCCESS AS SUCCESS 
			END
			ELSE

			BEGIN
								UPDATE JOB SET JOBTITLE=@STR_JOBTITLE,JOBDESC=@STR_JOBDESC,POSTEDDATE=@DT_JOBPOSTEDDATE,QUALIFICATION=@STR_QUALIFICATION, APPLYLINK=@STR_APPLYLINK WHERE JOBNO = @i_intJOBNO
								SET @JOBNUMBER=@i_intJOBNO
								SET @BIT_SUCCESS = 1;

								SELECT @JOBNUMBER AS JOB_NUMBER, @BIT_SUCCESS AS SUCCESS 

			END



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



GO
/****** Object:  StoredProcedure [dbo].[USP_JOB_INSERTUPDATE]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[USP_JOB_INSERTUPDATE]
(
	@i_strJOBTITLE NVARCHAR(100),
	@i_strJOBDESC NVARCHAR(MAX),
	@i_dt_POSTEDDATE DATE,
	@i_str_QUALIFICATION NVARCHAR(300),
	@i_intJOBNO INT

)
AS
	BEGIN
		BEGIN TRY

			DECLARE @i_strMessage VARCHAR(200);
			DECLARE @i_bitSuccess BIT = 0;

			if not exists (select JOBTITLE from JOB  where JOBNO =@i_intJOBNO)
				BEGIN

					INSERT INTO JOB(JOBTITLE,JOBDESC,POSTEDDATE,QUALIFICATION) VALUES (@i_strJOBTITLE,@i_strJOBDESC,@i_dt_POSTEDDATE,@i_str_QUALIFICATION)

					SET @i_strMessage = 'Insert Success';
					SET @i_bitSuccess = 1;

				END
			ELSE
				BEGIN

					UPDATE JOB SET JOBTITLE=@i_strJOBTITLE,JOBDESC=@i_strJOBDESC,POSTEDDATE=@i_dt_POSTEDDATE,QUALIFICATION=@i_str_QUALIFICATION  WHERE JOBNO = @i_intJOBNO

					SET @i_strMessage = 'Update Success';
					SET @i_bitSuccess = 1;

				END


			SELECT @i_strMessage AS Message, @i_bitSuccess AS Success 

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

GO
/****** Object:  StoredProcedure [dbo].[USP_JOBEVENTDATETIME_INSERTJOBDETAILS]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[USP_JOBEVENTDATETIME_INSERTJOBDETAILS]
(
	@JobNumber INT,
	@STR_EVENTS NVARCHAR(300),
	@DT_EVENTSDATETIME DATETIME,
	@INT_INSERT INT
	--@STR_JOBTITLE NVARCHAR(100)

)
AS
	BEGIN
		BEGIN TRY

			DECLARE @STR_MESSAGE VARCHAR(200);
			DECLARE @BIT_SUCCESS INT = 0;

			IF @INT_INSERT = 0 
				BEGIN
				--BEGIN TRANSACTION
				Delete JOBIMPDATES where JOBNO=@JobNumber
					INSERT INTO JOBIMPDATES(JOBNO,EVENTS,EVENTSDATETIME) VALUES (@JobNumber,@STR_EVENTS, @DT_EVENTSDATETIME)
					SET @STR_MESSAGE = 'Insert Success';
					SET @BIT_SUCCESS = 1;
				--COMMIT TRANSACTION

				END
			ELSE
				BEGIN

					--UPDATE JOB SET JOBTITLE=@i_strJOBTITLE,JOBDESC=@i_strJOBDESC,POSTEDDATE=@i_dt_POSTEDDATE,QUALIFICATION=@i_str_QUALIFICATION  WHERE JOBNO = @i_intJOBNO

					SET @STR_MESSAGE = 'Update Success';
					SET @BIT_SUCCESS = 1;

				END


			SELECT @STR_MESSAGE AS MESSAGE, @BIT_SUCCESS AS SUCCESS 

		END TRY
		
		BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) ;
            DECLARE @ErrorSeverity INT ;
            DECLARE @ErrorState INT ;

            SELECT  @ErrorMessage = ERROR_MESSAGE() ,
                    @ErrorSeverity = ERROR_SEVERITY() ,
                    @ErrorState = ERROR_STATE()

            RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState) ;
		--	ROLLBACK TRANSACTION
       END CATCH
	END


GO
/****** Object:  StoredProcedure [dbo].[usp_JOBIMNOTES_GetJobNotes]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_JOBIMNOTES_GetJobNotes]



@JobNumber INT



AS







	BEGIN





		BEGIN TRY





			SELECT TITLE,DOWNLOADLINK FROM JOBIMNOTES WHERE JOBNO=@JobNumber ORDER BY TITLE







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
GO
/****** Object:  StoredProcedure [dbo].[USP_JOBIMNOTES_INSERTIMNOTES]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[USP_JOBIMNOTES_INSERTIMNOTES]
(
	@JobNumber INT,
	@STR_TITLE NVARCHAR(300),
	@DT_UPLODEDDATE DATETIME,
	@STR_DOWNLOADLINK NVARCHAR(500),
	@STR_UPLODEDBY VARCHAR(100),
	@INT_INSERT INT

)
AS
	BEGIN
		BEGIN TRY

			DECLARE @STR_MESSAGE VARCHAR(200);
			DECLARE @BIT_SUCCESS INT = 0;

			IF @INT_INSERT = 0 
				BEGIN
				--BEGIN TRANSACTION
				   Delete JOBIMNOTES where JOBNO=@JobNumber
					INSERT INTO JOBIMNOTES(JOBNO,TITLE,DOWNLOADLINK,UPLODEDBY,UPLODEDDATE) VALUES (@JobNumber,@STR_TITLE, @STR_DOWNLOADLINK,@STR_UPLODEDBY,@DT_UPLODEDDATE)
					SET @STR_MESSAGE = 'InsertSuccess';
					SET @BIT_SUCCESS = 1;
				--COMMIT TRANSACTION

				END
			ELSE
				BEGIN

					--UPDATE JOB SET JOBTITLE=@i_strJOBTITLE,JOBDESC=@i_strJOBDESC,POSTEDDATE=@i_dt_POSTEDDATE,QUALIFICATION=@i_str_QUALIFICATION  WHERE JOBNO = @i_intJOBNO

					SET @STR_MESSAGE = 'Update Success';
					SET @BIT_SUCCESS = 1;

				END


			SELECT @STR_MESSAGE AS MESSAGE, @BIT_SUCCESS AS SUCCESS 

		END TRY
		
		BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000) ;
            DECLARE @ErrorSeverity INT ;
            DECLARE @ErrorState INT ;

            SELECT  @ErrorMessage = ERROR_MESSAGE() ,
                    @ErrorSeverity = ERROR_SEVERITY() ,
                    @ErrorState = ERROR_STATE()

            RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState) ;
		--	ROLLBACK TRANSACTION
       END CATCH
	END



GO
/****** Object:  StoredProcedure [dbo].[usp_JOBIMPDATES_GetEventDateTime]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_JOBIMPDATES_GetEventDateTime]

@JobNumber INT

AS



	BEGIN


		BEGIN TRY


			SELECT EVENTS,EVENTSDATETIME FROM JOBIMPDATES WHERE JOBNO=@JobNumber ORDER BY EVENTSDATETIME



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



	--exec usp_JOBIMPDATES_GetEventDateTime
GO
/****** Object:  StoredProcedure [dbo].[USP_PERSON_CANDIDATEINSERTUPDATE]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












CREATE PROC [dbo].[USP_PERSON_CANDIDATEINSERTUPDATE]







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





























GO
/****** Object:  StoredProcedure [dbo].[USP_PERSON_GETPERSONDETAILS]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE PROCEDURE [dbo].[USP_PERSON_GETPERSONDETAILS](@phoneno nvarchar(100))

AS

	BEGIN

		BEGIN TRY

			SELECT ID,PERSONID,NAME,GENDER,ISNULL(DOB,'') DOB,ADDRESS,EMAIL,MOBILE,QUALIFICATION,EXPERIANCE,INTEREST,IMGPATH FROM PERSON WHERE PERSONID=(select PERSONID from USERS where USERNAME=@phoneno)


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




GO
/****** Object:  StoredProcedure [dbo].[USP_SIGNUP]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[USP_SIGNUP]

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
/****** Object:  Table [dbo].[ActivityLog]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Timestamp] [datetime] NULL,
	[Session] [nvarchar](max) NULL,
	[IP] [nvarchar](200) NULL,
	[Browser] [nvarchar](200) NULL,
	[Device] [nvarchar](200) NULL,
	[Message] [nvarchar](max) NULL,
	[PageName] [nvarchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmailServer]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailServer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[host] [nvarchar](max) NULL,
	[port] [nvarchar](50) NULL,
	[ssl] [bit] NULL,
	[email] [nvarchar](max) NULL,
	[password] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JOB]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JOB](
	[JOBNO] [int] IDENTITY(100000,1) NOT NULL,
	[JOBTITLE] [nvarchar](100) NOT NULL,
	[JOBDESC] [nvarchar](max) NOT NULL,
	[POSTEDDATE] [datetime] NOT NULL,
	[QUALIFICATION] [nvarchar](300) NOT NULL,
	[APPLYLINK] [varchar](500) NULL,
PRIMARY KEY CLUSTERED 
(
	[JOBNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[JOBCOMMUNITY]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JOBCOMMUNITY](
	[JOBNO] [int] NOT NULL,
	[USERS] [nvarchar](50) NULL,
	[COMMENTS] [nvarchar](500) NULL,
	[DATE] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JOBIMNOTES]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JOBIMNOTES](
	[JOBNO] [int] NOT NULL,
	[TITLE] [nvarchar](300) NOT NULL,
	[DOWNLOADLINK] [nvarchar](500) NOT NULL,
	[UPLODEDBY] [varchar](100) NULL,
	[UPLODEDDATE] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[JOBIMPDATES]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JOBIMPDATES](
	[JOBNO] [int] NOT NULL,
	[EVENTS] [nvarchar](300) NOT NULL,
	[EVENTSDATETIME] [datetime] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PERSON]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PERSON](
	[ID] [int] IDENTITY(10000,1) NOT NULL,
	[PERSONID] [int] NOT NULL,
	[NAME] [varchar](100) NOT NULL,
	[GENDER] [varchar](10) NOT NULL,
	[DOB] [date] NULL,
	[ADDRESS] [varchar](500) NULL,
	[EMAIL] [varchar](50) NOT NULL,
	[MOBILE] [varchar](50) NOT NULL,
	[QUALIFICATION] [nvarchar](max) NULL,
	[EXPERIANCE] [nvarchar](max) NULL,
	[INTEREST] [nvarchar](500) NULL,
	[IMGPATH] [varchar](200) NULL,
 CONSTRAINT [PERSONID_PK] PRIMARY KEY CLUSTERED 
(
	[PERSONID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[USERS]    Script Date: 07-02-2019 08:59:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USERS](
	[USERNAME] [nvarchar](max) NULL,
	[PASSWORD] [nvarchar](max) NULL,
	[ROLES] [nvarchar](max) NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PERSONID] [int] NOT NULL,
	[ISACTIVE] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[ActivityLog] ON 

INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (1, CAST(0x0000AA7B0033DA84 AS DateTime), N'd3x15qxinqxrbkr4anyyfwpz', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (2, CAST(0x0000AA7B0034C85D AS DateTime), N'wi25zagkoj2idve32vbemzik', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (3, CAST(0x0000AA7B0034D8B7 AS DateTime), N'ecdoilmgpqxfhlw5ke5ffwvr', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (4, CAST(0x0000AA7B00368DD6 AS DateTime), N'g40zufb1li34qn5cnvdqdaxb636973949169614317', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (5, CAST(0x0000AA7B00369E35 AS DateTime), N'g40zufb1li34qn5cnvdqdaxb636973949169614317', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (6, CAST(0x0000AA7B00385036 AS DateTime), N'h20cplpf1qdsuldmhyzpt2xx636973953010899188', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (7, CAST(0x0000AA7B00386E57 AS DateTime), N'h20cplpf1qdsuldmhyzpt2xx636973953010899188', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (8, CAST(0x0000AA7B00387E6F AS DateTime), N'h20cplpf1qdsuldmhyzpt2xx636973953010899188', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (9, CAST(0x0000AA7B003886AE AS DateTime), N'h20cplpf1qdsuldmhyzpt2xx636973953010899188', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (10, CAST(0x0000AA7B005E4C94 AS DateTime), N'2etvmahazk5eqrx1v2q3csz1636974035994585196', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (11, CAST(0x0000AA7B005E82DB AS DateTime), N'2etvmahazk5eqrx1v2q3csz1636974035994585196', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (12, CAST(0x0000AA7B005E95E9 AS DateTime), N'2etvmahazk5eqrx1v2q3csz1636974035994585196', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (13, CAST(0x0000AA7B0068E856 AS DateTime), N'2ztlf2iw30jwfibt1rwki3sw636974059166212511', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (14, CAST(0x0000AA7B00690F90 AS DateTime), N'2ztlf2iw30jwfibt1rwki3sw636974059166212511', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (15, CAST(0x0000AA7B00691CEC AS DateTime), N'2ztlf2iw30jwfibt1rwki3sw636974059166212511', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (16, CAST(0x0000AA7B006B7417 AS DateTime), N'2qsymujjxwt0c02krcuvgc5c636974064727439703', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (17, CAST(0x0000AA7B006B868D AS DateTime), N'2qsymujjxwt0c02krcuvgc5c636974064727439703', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (18, CAST(0x0000AA7B006B959A AS DateTime), N'2qsymujjxwt0c02krcuvgc5c636974064727439703', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (19, CAST(0x0000AA7B0071454F AS DateTime), N'ranjxeqbqnzys44fpnzmq2rp636974077433832294', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (20, CAST(0x0000AA7B007183CF AS DateTime), N'ranjxeqbqnzys44fpnzmq2rp636974077433832294', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (21, CAST(0x0000AA7B007191F9 AS DateTime), N'ranjxeqbqnzys44fpnzmq2rp636974077433832294', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (22, CAST(0x0000AA7B007753CD AS DateTime), N'0l1q40wqfgch3v0duukrlcu5636974090669397757', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (23, CAST(0x0000AA7B00777C38 AS DateTime), N'0l1q40wqfgch3v0duukrlcu5636974090669397757', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (24, CAST(0x0000AA7B00777CD5 AS DateTime), N'0l1q40wqfgch3v0duukrlcu5636974090669397757', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (25, CAST(0x0000AA7B00778AC7 AS DateTime), N'0l1q40wqfgch3v0duukrlcu5636974090669397757', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (26, CAST(0x0000AA7B00868E03 AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (27, CAST(0x0000AA7B0086D676 AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (28, CAST(0x0000AA7B0086E70E AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (29, CAST(0x0000AA7B0086F419 AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (30, CAST(0x0000AA7B0086F81E AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (31, CAST(0x0000AA7B00870B4F AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (32, CAST(0x0000AA7B00876E56 AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (33, CAST(0x0000AA7B0087FB2E AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (34, CAST(0x0000AA7B0088016A AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (35, CAST(0x0000AA7B008802DD AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (36, CAST(0x0000AA7B00880495 AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (37, CAST(0x0000AA7B008805FB AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (38, CAST(0x0000AA7B0088082F AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (39, CAST(0x0000AA7B00880A01 AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (40, CAST(0x0000AA7B00880BD2 AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (41, CAST(0x0000AA7B00880D34 AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (42, CAST(0x0000AA7B00893BA1 AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (43, CAST(0x0000AA7B00895781 AS DateTime), N'olboxax0gvo0yngwpmxcinry636974123931977942', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (44, CAST(0x0000AA7B008D0DF9 AS DateTime), N'e1n0m1t3ccbuofmxrwqzeydz636974138128721307', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (45, CAST(0x0000AA7B008D19A5 AS DateTime), N'e1n0m1t3ccbuofmxrwqzeydz636974138128721307', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (46, CAST(0x0000AA7B008D3440 AS DateTime), N'e1n0m1t3ccbuofmxrwqzeydz636974138128721307', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (47, CAST(0x0000AA7B008F7C36 AS DateTime), N'co2vwel2mb3nr5dyj35qyrlo636974143433833328', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (48, CAST(0x0000AA7B008F9C73 AS DateTime), N'co2vwel2mb3nr5dyj35qyrlo636974143433833328', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (49, CAST(0x0000AA7B00900A37 AS DateTime), N'co2vwel2mb3nr5dyj35qyrlo636974143433833328', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (50, CAST(0x0000AA7B0090470A AS DateTime), N'co2vwel2mb3nr5dyj35qyrlo636974143433833328', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (51, CAST(0x0000AA7B00905407 AS DateTime), N'co2vwel2mb3nr5dyj35qyrlo636974143433833328', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (52, CAST(0x0000AA7B0091BF03 AS DateTime), N'1xlpx4o1jkwwruduk55apaad636974148379900320', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (53, CAST(0x0000AA7B00924FD6 AS DateTime), N'1xlpx4o1jkwwruduk55apaad636974148379900320', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (54, CAST(0x0000AA7B00925ECC AS DateTime), N'1xlpx4o1jkwwruduk55apaad636974148379900320', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (55, CAST(0x0000AA7B00952074 AS DateTime), N'1xlpx4o1jkwwruduk55apaad636974155764938118', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (56, CAST(0x0000AA7B009537D2 AS DateTime), N'1xlpx4o1jkwwruduk55apaad636974155764938118', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (57, CAST(0x0000AA7B0095455A AS DateTime), N'1xlpx4o1jkwwruduk55apaad636974155764938118', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (58, CAST(0x0000AA7B00DD8E4E AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974313985369959', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (59, CAST(0x0000AA7B00DDA9C7 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974313985369959', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (60, CAST(0x0000AA7B00DDB919 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974313985369959', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (61, CAST(0x0000AA7B00DEBFD5 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974313985369959', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (62, CAST(0x0000AA7B00DECF08 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974313985369959', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (63, CAST(0x0000AA7B00DF3653 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974313985369959', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (64, CAST(0x0000AA7B00DF5C33 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974313985369959', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (65, CAST(0x0000AA7B00DF611E AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974313985369959', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (66, CAST(0x0000AA7B00DF6743 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974313985369959', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (67, CAST(0x0000AA7B00DF8EF6 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974313985369959', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (68, CAST(0x0000AA7B00E0124A AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974313985369959', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (69, CAST(0x0000AA7B00E3E270 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974327812604152', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (70, CAST(0x0000AA7B00E408B7 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974327812604152', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (71, CAST(0x0000AA7B00E41570 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974327812604152', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (72, CAST(0x0000AA7B00E41A94 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974327812604152', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (73, CAST(0x0000AA7B00E47C6B AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974327812604152', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (74, CAST(0x0000AA7B00E4825A AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974327812604152', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (75, CAST(0x0000AA7B00E4BFE8 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974327812604152', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (76, CAST(0x0000AA7B00E4C376 AS DateTime), N'2tno0aonvxu2mqittkzmtwtf636974327812604152', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (77, CAST(0x0000AA7B00E5C63E AS DateTime), N'x3u33yq5o12g205zd2ghix04636974331942609591', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (78, CAST(0x0000AA7B00E5ED82 AS DateTime), N'x3u33yq5o12g205zd2ghix04636974331942609591', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (79, CAST(0x0000AA7B00E5FC3B AS DateTime), N'x3u33yq5o12g205zd2ghix04636974331942609591', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (80, CAST(0x0000AA7B00E60044 AS DateTime), N'x3u33yq5o12g205zd2ghix04636974331942609591', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (81, CAST(0x0000AA7B00E64600 AS DateTime), N'x3u33yq5o12g205zd2ghix04636974331942609591', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (82, CAST(0x0000AA7B00E6608A AS DateTime), N'x3u33yq5o12g205zd2ghix04636974331942609591', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (83, CAST(0x0000AA7B00E82EC6 AS DateTime), N'bpaaqj5pha3rcem1kbwjtpzl636974337197949142', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (84, CAST(0x0000AA7B00E8351D AS DateTime), N'bpaaqj5pha3rcem1kbwjtpzl636974337197949142', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (85, CAST(0x0000AA7B00E84C07 AS DateTime), N'bpaaqj5pha3rcem1kbwjtpzl636974337197949142', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (86, CAST(0x0000AA7B00E861C5 AS DateTime), N'bpaaqj5pha3rcem1kbwjtpzl636974337197949142', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (87, CAST(0x0000AA7B00E9304D AS DateTime), N'bpaaqj5pha3rcem1kbwjtpzl636974337197949142', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (88, CAST(0x0000AA7B00EC3248 AS DateTime), N'bpaaqj5pha3rcem1kbwjtpzl636974337197949142', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (89, CAST(0x0000AA7B00EC58AA AS DateTime), N'bpaaqj5pha3rcem1kbwjtpzl636974337197949142', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (90, CAST(0x0000AA7B00ECE2E0 AS DateTime), N'bpaaqj5pha3rcem1kbwjtpzl636974337197949142', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (91, CAST(0x0000AA7B00ED2E54 AS DateTime), N'bpaaqj5pha3rcem1kbwjtpzl636974337197949142', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (92, CAST(0x0000AA7B00EE1CA3 AS DateTime), N'bpaaqj5pha3rcem1kbwjtpzl636974337197949142', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (93, CAST(0x0000AA7B00F0AB2D AS DateTime), N'v4wpeg3ngu2dmwyhoqas1deo636974355741394343', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (94, CAST(0x0000AA7B00F0B684 AS DateTime), N'v4wpeg3ngu2dmwyhoqas1deo636974355741394343', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (95, CAST(0x0000AA7B00F0CB46 AS DateTime), N'v4wpeg3ngu2dmwyhoqas1deo636974355741394343', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (96, CAST(0x0000AA7B00F0D3A4 AS DateTime), N'v4wpeg3ngu2dmwyhoqas1deo636974355741394343', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (97, CAST(0x0000AA7B00F13196 AS DateTime), N'v4wpeg3ngu2dmwyhoqas1deo636974355741394343', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (98, CAST(0x0000AA7B00F1EDD6 AS DateTime), N'v4wpeg3ngu2dmwyhoqas1deo636974355741394343', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (99, CAST(0x0000AA7B00F3B09E AS DateTime), N'ivkr2yyxxjibumfdsqawstz2636974362340964833', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
GO
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (100, CAST(0x0000AA7B00F3B6AC AS DateTime), N'ivkr2yyxxjibumfdsqawstz2636974362340964833', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (101, CAST(0x0000AA7B00F3C635 AS DateTime), N'ivkr2yyxxjibumfdsqawstz2636974362340964833', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (102, CAST(0x0000AA7B00F3D127 AS DateTime), N'ivkr2yyxxjibumfdsqawstz2636974362340964833', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (103, CAST(0x0000AA7B00F4E46C AS DateTime), N'zwuwznjloujxygnafoge2bc2636974364955489048', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (104, CAST(0x0000AA7B00F50195 AS DateTime), N'zwuwznjloujxygnafoge2bc2636974364955489048', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (105, CAST(0x0000AA7B00F50E3E AS DateTime), N'zwuwznjloujxygnafoge2bc2636974364955489048', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (106, CAST(0x0000AA7B00F5259B AS DateTime), N'zwuwznjloujxygnafoge2bc2636974364955489048', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (107, CAST(0x0000AA7B00F5BDAC AS DateTime), N'zwuwznjloujxygnafoge2bc2636974364955489048', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (108, CAST(0x0000AA7B00F5BE4A AS DateTime), N'zwuwznjloujxygnafoge2bc2636974364955489048', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (109, CAST(0x0000AA7B00F60C5C AS DateTime), N'zwuwznjloujxygnafoge2bc2636974364955489048', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (110, CAST(0x0000AA7B00F8061E AS DateTime), N'oggghfsmj2sth5g2yk4ph0p4636974371808034759', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (111, CAST(0x0000AA7B00F80D99 AS DateTime), N'oggghfsmj2sth5g2yk4ph0p4636974371808034759', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (112, CAST(0x0000AA7B00F81C3A AS DateTime), N'oggghfsmj2sth5g2yk4ph0p4636974371808034759', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (113, CAST(0x0000AA7B00F8246D AS DateTime), N'oggghfsmj2sth5g2yk4ph0p4636974371808034759', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (114, CAST(0x0000AA7B00F95AD0 AS DateTime), N'kvitfepqsc34fehe5wplldrm636974374711593266', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (115, CAST(0x0000AA7B00F97FD0 AS DateTime), N'kvitfepqsc34fehe5wplldrm636974374711593266', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (116, CAST(0x0000AA7B00F98BF4 AS DateTime), N'kvitfepqsc34fehe5wplldrm636974374711593266', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (117, CAST(0x0000AA7B00F9959D AS DateTime), N'kvitfepqsc34fehe5wplldrm636974374711593266', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (118, CAST(0x0000AA7B00FA5CC8 AS DateTime), N'kvitfepqsc34fehe5wplldrm636974374711593266', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (119, CAST(0x0000AA7B00FCA439 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974381898391902', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (120, CAST(0x0000AA7B00FCD8F4 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974381898391902', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (121, CAST(0x0000AA7B00FCE8E0 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974381898391902', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (122, CAST(0x0000AA7B00FCFAAD AS DateTime), N'v1tflmghnzd32hvqtildhupy636974381898391902', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (123, CAST(0x0000AA7B00FD6177 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974381898391902', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (124, CAST(0x0000AA7B00FE5915 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974381898391902', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (125, CAST(0x0000AA7B0110610E AS DateTime), N'v1tflmghnzd32hvqtildhupy636974425013229925', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (126, CAST(0x0000AA7B0114FDBC AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (127, CAST(0x0000AA7B01156390 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (128, CAST(0x0000AA7B01157AC2 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (129, CAST(0x0000AA7B011582FF AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (130, CAST(0x0000AA7B01159DF4 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (131, CAST(0x0000AA7B0115AADC AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (132, CAST(0x0000AA7B0115CE9E AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (133, CAST(0x0000AA7B0115E7E0 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (134, CAST(0x0000AA7B0115F4C8 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (135, CAST(0x0000AA7B01160E9F AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (136, CAST(0x0000AA7B01163449 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (137, CAST(0x0000AA7B01165D6C AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (138, CAST(0x0000AA7B01166127 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (139, CAST(0x0000AA7B0116AA4B AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (140, CAST(0x0000AA7B0116B7E4 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (141, CAST(0x0000AA7B0116EEE0 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (142, CAST(0x0000AA7B011744A0 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (143, CAST(0x0000AA7B01178598 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (144, CAST(0x0000AA7B011799B1 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (145, CAST(0x0000AA7B01180F78 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (146, CAST(0x0000AA7B0118134F AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (147, CAST(0x0000AA7B011912A3 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (148, CAST(0x0000AA7B01191F6A AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (149, CAST(0x0000AA7B0119390D AS DateTime), N'tqo2lswn0jfez0wbzxvdtpep636974444340709583', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (150, CAST(0x0000AA7B0119448D AS DateTime), N'tqo2lswn0jfez0wbzxvdtpep636974444340709583', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (151, CAST(0x0000AA7B011965B6 AS DateTime), N'tqo2lswn0jfez0wbzxvdtpep636974444340709583', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (152, CAST(0x0000AA7B01196B9E AS DateTime), N'tqo2lswn0jfez0wbzxvdtpep636974444340709583', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (153, CAST(0x0000AA7B011AF2A9 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (154, CAST(0x0000AA7B011B1490 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (155, CAST(0x0000AA7B011B1EDB AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (156, CAST(0x0000AA7B011B2F04 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (157, CAST(0x0000AA7B011B361D AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (158, CAST(0x0000AA7B011B4E0A AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (159, CAST(0x0000AA7B011BAB8A AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (160, CAST(0x0000AA7B011BF905 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (161, CAST(0x0000AA7B011C6621 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (162, CAST(0x0000AA7B011C8251 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (163, CAST(0x0000AA7B011D718D AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (164, CAST(0x0000AA7B011EFD33 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (165, CAST(0x0000AA7B011F4E7D AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (166, CAST(0x0000AA7B01219589 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (167, CAST(0x0000AA7B0121E41F AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (168, CAST(0x0000AA7B01224C0D AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (169, CAST(0x0000AA7B0122ABD3 AS DateTime), N'v1tflmghnzd32hvqtildhupy636974435090233787', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (170, CAST(0x0000AA7C002A05ED AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (171, CAST(0x0000AA7C002BFDBA AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (172, CAST(0x0000AA7C002C7474 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (173, CAST(0x0000AA7C002D2EAF AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (174, CAST(0x0000AA7C002D7DD4 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (175, CAST(0x0000AA7C002DB1A7 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (176, CAST(0x0000AA7C002DC5BD AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (177, CAST(0x0000AA7C002DC704 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (178, CAST(0x0000AA7C002E2D24 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (179, CAST(0x0000AA7C002EB9DC AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (180, CAST(0x0000AA7C002EDE94 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (181, CAST(0x0000AA7C002FF77B AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At JobDetails', N'JobDetails')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (182, CAST(0x0000AA7C0030147C AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (183, CAST(0x0000AA7C00302439 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (184, CAST(0x0000AA7C00303218 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (185, CAST(0x0000AA7C00320DE5 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (186, CAST(0x0000AA7C003238AF AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (187, CAST(0x0000AA7C0032ED58 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (188, CAST(0x0000AA7C00333770 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (189, CAST(0x0000AA7C00342DC9 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (190, CAST(0x0000AA7C0034941B AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (191, CAST(0x0000AA7C0035DECB AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (192, CAST(0x0000AA7C0035F070 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (193, CAST(0x0000AA7C00361574 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (194, CAST(0x0000AA7C0036A559 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (195, CAST(0x0000AA7C0036F032 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (196, CAST(0x0000AA7C00378559 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (197, CAST(0x0000AA7C0037DC24 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (198, CAST(0x0000AA7C0037E64E AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974785791501808', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (199, CAST(0x0000AA7C00383165 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974816743866194', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
GO
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (200, CAST(0x0000AA7C00383DB5 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974816743866194', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (201, CAST(0x0000AA7C00384B27 AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974816743866194', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (202, CAST(0x0000AA7C0038519E AS DateTime), N'isrro0ypnmb5zn33awsitsfu636974816743866194', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (203, CAST(0x0000AA7C00489578 AS DateTime), N'nqbcu3cttj1hgivzfvsdcovh636974852552331582', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (204, CAST(0x0000AA7C00534359 AS DateTime), N'lxlrxpntpdfnxpgckmfraw2o636974875884209566', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (205, CAST(0x0000AA7C00536AA1 AS DateTime), N'lxlrxpntpdfnxpgckmfraw2o636974875884209566', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (206, CAST(0x0000AA7C00537879 AS DateTime), N'lxlrxpntpdfnxpgckmfraw2o636974875884209566', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (207, CAST(0x0000AA7C00546181 AS DateTime), N'lxlrxpntpdfnxpgckmfraw2o636974875884209566', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (208, CAST(0x0000AA7C0055DF93 AS DateTime), N'fmumx0napwyx0nbledju2gaf636974881584762938', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (209, CAST(0x0000AA7C0055E629 AS DateTime), N'fmumx0napwyx0nbledju2gaf636974881584762938', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (210, CAST(0x0000AA7C0055F33C AS DateTime), N'fmumx0napwyx0nbledju2gaf636974881584762938', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (211, CAST(0x0000AA7C0056104F AS DateTime), N'fmumx0napwyx0nbledju2gaf636974881584762938', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (212, CAST(0x0000AA7C00575333 AS DateTime), N'fmumx0napwyx0nbledju2gaf636974881584762938', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (213, CAST(0x0000AA7C0059B550 AS DateTime), N'ezjlli0gg3r4xfg40133ez0r636974889960976127', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (214, CAST(0x0000AA7C0059C88E AS DateTime), N'ezjlli0gg3r4xfg40133ez0r636974889960976127', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (215, CAST(0x0000AA7C0059D834 AS DateTime), N'ezjlli0gg3r4xfg40133ez0r636974889960976127', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (216, CAST(0x0000AA7C0059FB9F AS DateTime), N'ezjlli0gg3r4xfg40133ez0r636974889960976127', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (217, CAST(0x0000AA7C005A2491 AS DateTime), N'ezjlli0gg3r4xfg40133ez0r636974889960976127', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (218, CAST(0x0000AA7C005A69D2 AS DateTime), N'ezjlli0gg3r4xfg40133ez0r636974889960976127', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (219, CAST(0x0000AA7C005AE0AC AS DateTime), N'ezjlli0gg3r4xfg40133ez0r636974892515319509', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (220, CAST(0x0000AA7C005B3361 AS DateTime), N'ezjlli0gg3r4xfg40133ez0r636974892515319509', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (221, CAST(0x0000AA7C005B408F AS DateTime), N'ezjlli0gg3r4xfg40133ez0r636974892515319509', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (222, CAST(0x0000AA7C005B9C5A AS DateTime), N'ezjlli0gg3r4xfg40133ez0r636974892515319509', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (223, CAST(0x0000AA7C005BDCA8 AS DateTime), N'ezjlli0gg3r4xfg40133ez0r636974892515319509', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (224, CAST(0x0000AA7C005F707E AS DateTime), N'd5vrefzqgovfoy4pehza0ca3636974902485323567', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (225, CAST(0x0000AA7C00607AA0 AS DateTime), N'd5vrefzqgovfoy4pehza0ca3636974902485323567', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (226, CAST(0x0000AA7C0060853E AS DateTime), N'd5vrefzqgovfoy4pehza0ca3636974902485323567', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (227, CAST(0x0000AA7C0060C1A1 AS DateTime), N'd5vrefzqgovfoy4pehza0ca3636974902485323567', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (228, CAST(0x0000AA7C00622DBD AS DateTime), N'd5vrefzqgovfoy4pehza0ca3636974902485323567', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (229, CAST(0x0000AA7C00627EDD AS DateTime), N'd5vrefzqgovfoy4pehza0ca3636974902485323567', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (230, CAST(0x0000AA7C0062A349 AS DateTime), N'd5vrefzqgovfoy4pehza0ca3636974902485323567', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (231, CAST(0x0000AA7C0062E236 AS DateTime), N'd5vrefzqgovfoy4pehza0ca3636974902485323567', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (232, CAST(0x0000AA7C0062E2DF AS DateTime), N'd5vrefzqgovfoy4pehza0ca3636974902485323567', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (233, CAST(0x0000AA7C00631ABF AS DateTime), N'd5vrefzqgovfoy4pehza0ca3636974902485323567', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (234, CAST(0x0000AA7C00634B24 AS DateTime), N'd5vrefzqgovfoy4pehza0ca3636974902485323567', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (235, CAST(0x0000AA7C0067A7CB AS DateTime), N'ww3fk1o5f4qvqvu1ucmuhqh1636974920419584275', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (236, CAST(0x0000AA7C0067C130 AS DateTime), N'ww3fk1o5f4qvqvu1ucmuhqh1636974920419584275', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (237, CAST(0x0000AA7C00693005 AS DateTime), N'ww3fk1o5f4qvqvu1ucmuhqh1636974920419584275', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (238, CAST(0x0000AA7C00717A90 AS DateTime), N'ww3fk1o5f4qvqvu1ucmuhqh1636974941898127256', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (239, CAST(0x0000AA7C00718F70 AS DateTime), N'ww3fk1o5f4qvqvu1ucmuhqh1636974941898127256', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (240, CAST(0x0000AA7C0071983E AS DateTime), N'ww3fk1o5f4qvqvu1ucmuhqh1636974941898127256', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (241, CAST(0x0000AA7C007A05CF AS DateTime), N'5py40ksgvt1v4zpk4vitf431636974960557112048', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (242, CAST(0x0000AA7C007B0515 AS DateTime), N'5py40ksgvt1v4zpk4vitf431636974960557112048', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (243, CAST(0x0000AA7C007B1164 AS DateTime), N'5py40ksgvt1v4zpk4vitf431636974960557112048', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (244, CAST(0x0000AA7D00F32EC7 AS DateTime), N'hwyzzf4tpxahzzpcbmecmw5k636976089240226834', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (245, CAST(0x0000AA7D00F33444 AS DateTime), N'hwyzzf4tpxahzzpcbmecmw5k636976089240226834', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (246, CAST(0x0000AA7D00F33FB9 AS DateTime), N'hwyzzf4tpxahzzpcbmecmw5k636976089240226834', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (247, CAST(0x0000AA7D00F43AD8 AS DateTime), N'hwyzzf4tpxahzzpcbmecmw5k636976089240226834', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (248, CAST(0x0000AA7D00F44B23 AS DateTime), N'hwyzzf4tpxahzzpcbmecmw5k636976089240226834', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (249, CAST(0x0000AA7D00F47857 AS DateTime), N'hwyzzf4tpxahzzpcbmecmw5k636976089240226834', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (250, CAST(0x0000AA7D00F502E7 AS DateTime), N'hwyzzf4tpxahzzpcbmecmw5k636976089240226834', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (251, CAST(0x0000AA7D00F510FB AS DateTime), N'hwyzzf4tpxahzzpcbmecmw5k636976089240226834', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (252, CAST(0x0000AA7D00F7446D AS DateTime), N'ejiykdatojg2jpircypxte0p636976098163074501', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (253, CAST(0x0000AA7D00F787D5 AS DateTime), N'ejiykdatojg2jpircypxte0p636976098163074501', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (254, CAST(0x0000AA7D00F82667 AS DateTime), N'ejiykdatojg2jpircypxte0p636976098163074501', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (255, CAST(0x0000AA7D00F8698F AS DateTime), N'ejiykdatojg2jpircypxte0p636976098163074501', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (256, CAST(0x0000AA7D00F87DAE AS DateTime), N'ejiykdatojg2jpircypxte0p636976098163074501', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (257, CAST(0x0000AA7D00FAF078 AS DateTime), N'ejiykdatojg2jpircypxte0p636976098163074501', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (258, CAST(0x0000AA7D00FB004B AS DateTime), N'ejiykdatojg2jpircypxte0p636976098163074501', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (259, CAST(0x0000AA7D00FBAD58 AS DateTime), N'ejiykdatojg2jpircypxte0p636976098163074501', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (260, CAST(0x0000AA7D00FBB8A3 AS DateTime), N'ejiykdatojg2jpircypxte0p636976098163074501', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (261, CAST(0x0000AA7D00FC0D01 AS DateTime), N'ejiykdatojg2jpircypxte0p636976098163074501', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (262, CAST(0x0000AA7D00FC1AB8 AS DateTime), N'ejiykdatojg2jpircypxte0p636976098163074501', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (263, CAST(0x0000AA7D00FC8348 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976109622472184', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (264, CAST(0x0000AA7D00FC89D1 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976109622472184', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (265, CAST(0x0000AA7D00FC93B6 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976109622472184', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (266, CAST(0x0000AA7D00FFBEBE AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976116682861012', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (267, CAST(0x0000AA7D00FFC48F AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976116682861012', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (268, CAST(0x0000AA7D0107D561 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976134353036449', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (269, CAST(0x0000AA7D0108F9D9 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976134353036449', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (270, CAST(0x0000AA7D010A528D AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976139790040432', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (271, CAST(0x0000AA7D010A63FB AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976139790040432', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (272, CAST(0x0000AA7D010AE45A AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976139790040432', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (273, CAST(0x0000AA7D010B6E0A AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976142208863787', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (274, CAST(0x0000AA7D010B70CC AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976142208863787', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (275, CAST(0x0000AA7D010CE73B AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976145427810427', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (276, CAST(0x0000AA7D010CFE05 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976145427810427', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (277, CAST(0x0000AA7D010D525E AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976145427810427', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (278, CAST(0x0000AA7D010DA552 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976147049601432', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (279, CAST(0x0000AA7D010DA7F1 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976147049601432', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (280, CAST(0x0000AA7D0114DA25 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976162792480814', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (281, CAST(0x0000AA7D0114DFD8 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976162792480814', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (282, CAST(0x0000AA7D011509FD AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976162792480814', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (283, CAST(0x0000AA7D0115A8B3 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976164555113499', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (284, CAST(0x0000AA7D0115AC4C AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976164555113499', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (285, CAST(0x0000AA7D0115CA79 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976164555113499', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (286, CAST(0x0000AA7D01167F73 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976166386346744', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (287, CAST(0x0000AA7D01168493 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976166386346744', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (288, CAST(0x0000AA7D0116FAD1 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976166386346744', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (289, CAST(0x0000AA7D0117A02A AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976168851013167', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (290, CAST(0x0000AA7D0117A293 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976168851013167', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (291, CAST(0x0000AA7D0117DD50 AS DateTime), N'nkghzxc1akncvnvkdeq5o3xu636976168851013167', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (292, CAST(0x0000AA7D012096AE AS DateTime), N's0j5w2auv4uvsug0xupamazr636976188430865023', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (293, CAST(0x0000AA7D0120BCD4 AS DateTime), N's0j5w2auv4uvsug0xupamazr636976188430865023', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (294, CAST(0x0000AA7D0121132A AS DateTime), N's0j5w2auv4uvsug0xupamazr636976188430865023', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (295, CAST(0x0000AA7D0121C64D AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (296, CAST(0x0000AA7D0121CB58 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (297, CAST(0x0000AA7D01220C63 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (298, CAST(0x0000AA7D0123898A AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (299, CAST(0x0000AA7D0123A5A9 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
GO
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (300, CAST(0x0000AA7D0123DCC4 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (301, CAST(0x0000AA7D01242A76 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (302, CAST(0x0000AA7D0124CF3D AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (303, CAST(0x0000AA7D01254DE6 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (304, CAST(0x0000AA7D0125FBED AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (305, CAST(0x0000AA7D01262DA1 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (306, CAST(0x0000AA7D0126DA9B AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (307, CAST(0x0000AA7D0127798A AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (308, CAST(0x0000AA7D0127811B AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (309, CAST(0x0000AA7D012787B5 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (310, CAST(0x0000AA7D01278ACC AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (311, CAST(0x0000AA7D01278DDF AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (312, CAST(0x0000AA7D01279B61 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (313, CAST(0x0000AA7D0127A9E5 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (314, CAST(0x0000AA7D0127B5C0 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (315, CAST(0x0000AA7D0127C672 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (316, CAST(0x0000AA7D0127D071 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976191022122311', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (317, CAST(0x0000AA7D012820BC AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976204900629278', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (318, CAST(0x0000AA7D012827AE AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (319, CAST(0x0000AA7D01282A98 AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (320, CAST(0x0000AA7D012834CC AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (321, CAST(0x0000AA7D01284976 AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (322, CAST(0x0000AA7D01293330 AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (323, CAST(0x0000AA7D01293905 AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (324, CAST(0x0000AA7D01294B36 AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (325, CAST(0x0000AA7D012B08EB AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (326, CAST(0x0000AA7D012B15E3 AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (327, CAST(0x0000AA7D012B77F2 AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (328, CAST(0x0000AA7D012B84B3 AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (329, CAST(0x0000AA7D012C022D AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (330, CAST(0x0000AA7D012C5C34 AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (331, CAST(0x0000AA7D012C65D2 AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (332, CAST(0x0000AA7D012C93FC AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (333, CAST(0x0000AA7D012C9E3B AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976204960457909', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (334, CAST(0x0000AA7D012CE69B AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976215327246825', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (335, CAST(0x0000AA7D012CE69A AS DateTime), N'z4laiu5bit3y5stt5qa34o5t636976215327246825', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (336, CAST(0x0000AA7D012CE963 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976215327246825', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (337, CAST(0x0000AA7D012CF691 AS DateTime), N'nun3nlyg4yn0nmfqcvbrv50t636976215327246825', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (338, CAST(0x0000AA7D012D9F83 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (339, CAST(0x0000AA7D012DA1F2 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (340, CAST(0x0000AA7D012E18A2 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (341, CAST(0x0000AA7D012E993A AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (342, CAST(0x0000AA7D012ED549 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (343, CAST(0x0000AA7D012F20AC AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (344, CAST(0x0000AA7D012FA6AA AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (345, CAST(0x0000AA7D012FEA41 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (346, CAST(0x0000AA7D013172A9 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (347, CAST(0x0000AA7D0131F679 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (348, CAST(0x0000AA7D0132014F AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (349, CAST(0x0000AA7D0132C56A AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (350, CAST(0x0000AA7D013328D5 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (351, CAST(0x0000AA7D01335BD5 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (352, CAST(0x0000AA7D01339721 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (353, CAST(0x0000AA7D0133E2DB AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (354, CAST(0x0000AA7D01341273 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (355, CAST(0x0000AA7D01347406 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (356, CAST(0x0000AA7D01348FB0 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (357, CAST(0x0000AA7D0134DA19 AS DateTime), N'4uzi0f2kddeh0itbvhdew4uh636976216905071285', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (358, CAST(0x0000AA7D013E341B AS DateTime), N'cqvfzbgmlingy1gavhxtszhb636976253125514143', N'::1', N'Chrome', N'WinNT', N'At List Job', N'ListJob')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (359, CAST(0x0000AA7D013E658C AS DateTime), N'cqvfzbgmlingy1gavhxtszhb636976253125514143', N'::1', N'Chrome', N'WinNT', N'At LoginRegistration', N'LoginRegistration')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (360, CAST(0x0000AA7D013E91C1 AS DateTime), N'cqvfzbgmlingy1gavhxtszhb636976253125514143', N'::1', N'Chrome', N'WinNT', N'At CandidateProfile', N'CandidateProfile')
INSERT [dbo].[ActivityLog] ([Id], [Timestamp], [Session], [IP], [Browser], [Device], [Message], [PageName]) VALUES (361, CAST(0x0000AA7D013E9DF2 AS DateTime), N'cqvfzbgmlingy1gavhxtszhb636976253125514143', N'::1', N'Chrome', N'WinNT', N'At Job_Internal', N'Job_Internal')
SET IDENTITY_INSERT [dbo].[ActivityLog] OFF
SET IDENTITY_INSERT [dbo].[EmailServer] ON 

INSERT [dbo].[EmailServer] ([Id], [host], [port], [ssl], [email], [password]) VALUES (1, N'mail.drashtainfotech.com', N'25', 0, N'noreply@drashtainfotech.com', N'12345@a123')
SET IDENTITY_INSERT [dbo].[EmailServer] OFF
SET IDENTITY_INSERT [dbo].[JOB] ON 

INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100000, N'EVENT CONTROL MANAGER', N'<b>Job Description
</b>We are looking for an HTML5 developer who is motivated to combine the art of design with the art of programming. Responsibilities will include the translation of the UI/UX design wireframes to actual code that will produce visual elements of the application. You will work with the UI/UX designer and bridge the gap between graphical design and technical implementation, taking an active role on both sides and defining how the application looks as well as how it works.', CAST(0x0000AA53014BB5C3 AS DateTime), N'BTECH', N'https://www.google.com/')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100001, N'EVENT CONTROL MANAGER', N'BBB', CAST(0x0000AA53014BCCB5 AS DateTime), N'MTECH', N'https://www.javatpoint.com/')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100002, N'RAILWAY LOCO PILOT', N'CCC', CAST(0x0000AA53014C06B2 AS DateTime), N'BCA', N'https://www.tutorialsteacher.com/')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100003, N'RAILWAY GUARD', N'DDD', CAST(0x0000AA53014C2EC6 AS DateTime), N'ANY GRADUATE', N'https://www.tutorialspoint.com/index.htm')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100004, N'INDIAN POST GUARD', N'DDD', CAST(0x0000AA53014C6219 AS DateTime), N'ANY GRADUATE', N'https://www.w3schools.com/')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100005, N'AAA', N'AAA', CAST(0x0000AA53014BB5C3 AS DateTime), N'AAA', N'AAA')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100006, N'AAACCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC', N'AAA', CAST(0x0000AA53014BB5C3 AS DateTime), N'AAA', N'AAA')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100007, N'AAACCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC', N'AAA', CAST(0x0000AA53014BB5C3 AS DateTime), N'AAA', N'AAA')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100008, N'ccc', N'asdasdasdsad', CAST(0x0000AA6A00000000 AS DateTime), N'Chase,Jason', N'aaaa')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100009, N'ccc', N'asdasdasdsad', CAST(0x0000AA6A00000000 AS DateTime), N'Chase,Jason', N'aaaa')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100010, N'Train Job', N'Itis cricket job', CAST(0x0000AA6900000000 AS DateTime), N'Jason,Jasmine,Jasmine', N'www.cricbuzz.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100011, N'Bus Conductor', N'asas', CAST(0x0000AA6800000000 AS DateTime), N'Jasmine,Jasmine,Jason', N'www.nabanna.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100012, N'Bus Conductor', N'asas', CAST(0x0000AA6800000000 AS DateTime), N'Jasmine,Jasmine,Jason', N'www.nabanna.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100013, N'Taxi Driver', N'asaas', CAST(0x0000AA7200000000 AS DateTime), N'Chase,Asher,Easton', N'www.taxidriver.co.in')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100014, N'Railway Loco Pilot', N'this is loco pilot job', CAST(0x0000AA6900000000 AS DateTime), N'Jason,Easton', N'www.railwatrecruitmentboard.in')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100015, N'aa', N'aa', CAST(0x0000AA7300000000 AS DateTime), N'Jason', N'aa')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100016, N'aa', N'aa', CAST(0x0000AA7300000000 AS DateTime), N'Jason', N'aa')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100017, N'aa', N'aa', CAST(0x0000AA7300000000 AS DateTime), N'Jason', N'aa')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100019, N'xxx', N'zzzz', CAST(0x0000AA7100000000 AS DateTime), N'Jasmine', N'zzzzzz')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100020, N'as', N'as', CAST(0x0000AA6A00000000 AS DateTime), N'Jason', N'as')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100021, N'a', N'a', CAST(0x0000AA6A00000000 AS DateTime), N'Jason', N'a')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100022, N'a', N'a', CAST(0x0000AA7000000000 AS DateTime), N'Asher,Jasmine', N'aa')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100023, N'Railroad engineer (engine driver)', N'Manages the business relationship between the rail organisation and the client or business partner. Depending on the nature of the work, it may be either financial or sales focused. Normally, you will be required to hold a related degree. You will need to be well organised and have good administration and interpersonal skills for this role.', CAST(0x0000AA6900000000 AS DateTime), N'Easton,Jason,Chase', N'www.railwayrecruitmentboard.org')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100024, N'Account Executive', N'Manages the business relationship between the rail organisation and the client or business partner. Depending on the nature of the work, it may be either financial or sales focused. Normally, you will be required to hold a related degree. You will need to be well organised and have good administration and interpersonal skills for this role.', CAST(0x0000AA6B00000000 AS DateTime), N'Chase,Jasmine', N'www.railwayrecruitmentboard.org')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100025, N'Accounts Officer', N'Arranges the payment of bills and accounts, assists with administering payroll and maintains petty cash for the office. You may work in this area without formal qualifications, but vocational qualifications are well regarded. Must have an eye for detail, accurate numeracy and good computer skills.', CAST(0x0000AA6A00000000 AS DateTime), N'Chase,Jason,Asher', N'www.railwayrecruitmentboard.co.in')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100026, N'Accounts Field Officer ', N'Arranges the payment of bills and accounts, assists with administering payroll and maintains petty cash for the office. You may work in this area without formal qualifications, but vocational qualifications are well regarded. Must have an eye for detail, accurate numeracy and good computer skills.', CAST(0x0000AA6B00000000 AS DateTime), N'Chase,Easton', N'www.indianpost.in')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100027, N'Assistant Engineer', N'Assists with the planning, designing, installing and maintenance of equipment, facilities and distribution systems. Usually works on jobs that lie between trade and engineering, under direction of a professional engineer. Requires a Cert III trade certificate and relevant experience.', CAST(0x0000AA6900000000 AS DateTime), N'Jason,Asher', N'www.rail.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100028, N'hj', N'hjh', CAST(0x0000AA6C00000000 AS DateTime), N'Easton', N'hjh')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100029, N'a', N'a', CAST(0x0000AA6A00000000 AS DateTime), N'Asher', N'a')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100030, N'.Net Developer', N'Test B.Tech', CAST(0x0000AA7300000000 AS DateTime), N'Stella,Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100031, N'.Net Dev', N'Test B.Tech', CAST(0x0000AA7400000000 AS DateTime), N'Stella,Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100032, N'.Net Developer', N'Test B.Tech', CAST(0x0000AA7B00000000 AS DateTime), N'Stella,Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100033, N'.net developer', N'Test B.Tech', CAST(0x0000AA7B00000000 AS DateTime), N'Stella,Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100034, N'.net Developer', N'Test NSEC', CAST(0x0000AA7B00000000 AS DateTime), N'Stella,Chase', N'www.gooogle.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100035, N'.Net Develper', N'Test NSEC', CAST(0x0000AA7B00000000 AS DateTime), N'Stella,Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100036, N'Developer56', N'NSEC', CAST(0x0000AA8700000000 AS DateTime), N'Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100037, N'test', N'NSEC', CAST(0x0000AA7A00000000 AS DateTime), N'Chase', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100038, N'test job', N'NSEC', CAST(0x0000AA7B00000000 AS DateTime), N'Chase', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100039, N'test jobs', N'NSEC', CAST(0x0000AA7200000000 AS DateTime), N'Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100040, N'Test Job', N'NSEC', CAST(0x0000AA6C00000000 AS DateTime), N'Chase', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100041, N'Test Job', N'NSEC', CAST(0x0000AA7B00000000 AS DateTime), N'Chase', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100042, N'Test Job', N'NSEC', CAST(0x0000AA7B00000000 AS DateTime), N'Chase', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100043, N'test job', N'NSEC', CAST(0x0000AA7300000000 AS DateTime), N'Chase', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100044, N'Test Job', N'NSEC', CAST(0x0000AA7A00000000 AS DateTime), N'Chase', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100045, N'Test Job', N'NSEC IT', CAST(0x0000AA6C00000000 AS DateTime), N'Chase', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100046, N'.Net Developer20', N'Test B.Tech', CAST(0x0000AA7B00000000 AS DateTime), N'Stella,Chase', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100047, N'.Net Developer2', N'Test B.Tech', CAST(0x0000AA7300000000 AS DateTime), N'Stella,Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100048, N'.Net Developer2', N'Test B.Tech', CAST(0x0000AA7B00000000 AS DateTime), N'Stella,Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100049, N'.Net Developer3', N'Test B.Tech', CAST(0x0000AA7B00000000 AS DateTime), N'Stella,Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100050, N'.Net Developer3', N'Test B.Tech', CAST(0x0000AA7B00000000 AS DateTime), N'Stella,Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100051, N'.Net Developer4', N'Test B.Tech', CAST(0x0000AA7B00000000 AS DateTime), N'Stella,Chase', N'www.google.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100052, N'Test Job', N'test', CAST(0x0000AA7400000000 AS DateTime), N'Christian', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100053, N'Test Job20', N'Test', CAST(0x0000AA7B00000000 AS DateTime), N'Zachary', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100054, N'Test Job 30', N'this is test', CAST(0x0000AA7B00000000 AS DateTime), N'Chase', N'www.facebook.com')
INSERT [dbo].[JOB] ([JOBNO], [JOBTITLE], [JOBDESC], [POSTEDDATE], [QUALIFICATION], [APPLYLINK]) VALUES (100055, N'Test Job', N'This is test.', CAST(0x0000AA7B00000000 AS DateTime), N'Hunter', N'www.google.com')
SET IDENTITY_INSERT [dbo].[JOB] OFF
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100000, N'Job', N'https://1drv.ms/u/s!AnF1nNmAAEnbtUINLvN5Ly3C6Lra', NULL, NULL)
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100000, N'job1', N'https://1drv.ms/u/s!AnF1nNmAAEnbtUINLvN5Ly3C6Lra', NULL, NULL)
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100000, N'job2', N'https://1drv.ms/u/s!AnF1nNmAAEnbtUINLvN5Ly3C6Lra', NULL, NULL)
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100026, N'Administration Careers', N'https://1drv.ms/u/s!AnF1nNmAAEnbtUINLvN5Ly3C6Lra', N'maynak', NULL)
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100029, N'2019-6-29-0-15-9-191920T000079744.pdf', N'~/CandidateImages/2019-6-29-0-15-9-191920T000079744.pdf', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100033, N'2019-6-29-11-20-29-22290455_1335946753197840_410341701_n.jpg', N'~/CandidateImages/2019-6-29-11-20-29-22290455_1335946753197840_410341701_n.jpg', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100034, N'2019-6-29-11-20-29-22290455_1335946753197840_410341701_n.jpg', N'~/CandidateImages/2019-6-29-11-20-29-22290455_1335946753197840_410341701_n.jpg', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100035, N'2019-6-29-11-20-29-22290455_1335946753197840_410341701_n.jpg', N'~/CandidateImages/2019-6-29-11-20-29-22290455_1335946753197840_410341701_n.jpg', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100036, N'2019-7-2-0-50-20-_Performance Review Document 2 for Pia Gregorio - Copy.pdf', N'/CandidateImages/2019-7-2-0-50-20-_Performance Review Document 2 for Pia Gregorio - Copy.pdf', N'Maynak Nandi', CAST(0x0000AA7E00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100037, N'2019-6-29-11-54-36-Dakhineswar.jpg', N'~/CandidateImages/2019-6-29-11-54-36-Dakhineswar.jpg', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100038, N'2019-6-29-12-2-58-Timeoff.png', N'~/CandidateImages/2019-6-29-12-2-58-Timeoff.png', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100040, N'2019-6-29-12-24-44-Timeoff.png', N'~/CandidateImages/2019-6-29-12-24-44-Timeoff.png', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100042, N'2019-6-29-12-24-44-Timeoff.png', N'~/CandidateImages/2019-6-29-12-24-44-Timeoff.png', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100044, N'2019-6-29-12-46-33-22290455_1335946753197840_410341701_n.jpg', N'~/CandidateImages/2019-6-29-12-46-33-22290455_1335946753197840_410341701_n.jpg', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100039, N'2019-6-29-12-2-58-Timeoff.png', N'~/CandidateImages/2019-6-29-12-2-58-Timeoff.png', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100041, N'2019-6-29-12-24-44-Timeoff.png', N'~/CandidateImages/2019-6-29-12-24-44-Timeoff.png', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100043, N'2019-6-29-12-24-44-Timeoff.png', N'~/CandidateImages/2019-6-29-12-24-44-Timeoff.png', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100046, N'2019-6-29-19-37-56-22290455_1335946753197840_410341701_n.jpg', N'~/CandidateImages/2019-6-29-19-37-56-22290455_1335946753197840_410341701_n.jpg', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100051, N'2019-6-29-19-56-29-Timeoff.png', N'~/CandidateImages/2019-6-29-19-56-29-Timeoff.png', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100051, N'2019-6-29-19-56-29-Timeoff.png', N'~/CandidateImages/2019-6-29-19-56-29-Timeoff.png', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMNOTES] ([JOBNO], [TITLE], [DOWNLOADLINK], [UPLODEDBY], [UPLODEDDATE]) VALUES (100054, N'2019-6-29-20-53-50-Timeoff.png', N'~/CandidateImages/2019-6-29-20-53-50-Timeoff.png', N'Maynak Nandi', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100000, N'Form Date', CAST(0x0000AA53014BB5C3 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100000, N'Apply Date', CAST(0x0000AA5D014BB5C3 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100000, N'Last Date', CAST(0x0000AA5F014BB5C3 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100001, N'A', CAST(0x0000AA6600000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100001, N'A', CAST(0x0000AA6600000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100001, N'Work', CAST(0x0000AA7300000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100001, N'zzz', CAST(0x0000AA7100000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100001, N'zzz', CAST(0x0000AA7100000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100008, N'ccc', CAST(0x0000AA7200000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100008, N'cccccc', CAST(0x0000AA6300000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100009, N'ccczzzzzzz', CAST(0x0000AA7200000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100010, N'One', CAST(0x0000AA6800000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100010, N'Two', CAST(0x0000AA6F00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100010, N'Three', CAST(0x0000AA7100000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100011, N'Bus1', CAST(0x0000AA6900000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100011, N'bus2', CAST(0x0000AA7000000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100012, N'Bus1', CAST(0x0000AA6900000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100012, N'bus2', CAST(0x0000AA7000000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100013, N'Taxi1', CAST(0x0000AA6200000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100013, N'Taxi2', CAST(0x0000AA7000000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100014, N'Loco1', CAST(0x0000AA6900000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100014, N'Loco2', CAST(0x0000AA6F00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100019, N'as', CAST(0x0000AA6F00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100021, N'a', CAST(0x0000AA6B00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100022, N'a', CAST(0x0000AA6A00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100023, N'Event1', CAST(0x0000AA7000000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100023, N'Event2', CAST(0x0000AA7200000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100024, N'Event1', CAST(0x0000AA6800000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100024, N'Event2', CAST(0x0000AA7200000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100024, N'Event3', CAST(0x0000AA7100000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100025, N'Event1', CAST(0x0000AA6A00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100025, N'Event2', CAST(0x0000AA7200000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100029, N'a', CAST(0x0000AA6D00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100033, N'Last date', CAST(0x0000AA7300000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100033, N'Open date', CAST(0x0000AA6B00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100034, N'Last date', CAST(0x0000AA7300000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100034, N'Open date', CAST(0x0000AA6B00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100035, N'Lats Date', CAST(0x0000AA7300000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100035, N'Open date', CAST(0x0000AA6B00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100036, N'Open Date', CAST(0x0000AA8D00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100038, N'open date', CAST(0x0000AA6C00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100040, N'Last date', CAST(0x0000AA7300000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100042, N'Last Date', CAST(0x0000AA7300000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100044, N'Last Date', CAST(0x0000AA7A00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100001, N'AA', CAST(0x0000AA7200000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100001, N'AA', CAST(0x0000AA7200000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100001, N'VV', CAST(0x0000AA6B00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100001, N'CC', CAST(0x0000AA7400000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100020, N'df', CAST(0x0000AA6900000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100020, N'as', CAST(0x0000AA7100000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100045, N'Last Date', CAST(0x0000AA6B00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100055, N'Test', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100037, N'last date', CAST(0x0000AA6B00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100037, N'open date', CAST(0x0000AA7100000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100039, N'open date', CAST(0x0000AA6C00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100039, N'last date', CAST(0x0000AA7100000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100041, N'Last Date', CAST(0x0000AA7300000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100043, N'Last date', CAST(0x0000AA7300000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100046, N'Last Date', CAST(0x0000AA7A00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100047, N'Last Date', CAST(0x0000AA7A00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100048, N'Last Date', CAST(0x0000AA7B00000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100051, N'Last Date', CAST(0x0000AA7400000000 AS DateTime))
INSERT [dbo].[JOBIMPDATES] ([JOBNO], [EVENTS], [EVENTSDATETIME]) VALUES (100054, N'Last Date', CAST(0x0000AA7B00000000 AS DateTime))
SET IDENTITY_INSERT [dbo].[PERSON] ON 

INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10009, 10000, N'SAMIRAN SEN', N'MALE', CAST(0xAE3F0B00 AS Date), N'KAIKHALI', N'SSEN@GMAIL.COM', N'9564125457', N'A', N'6YEARS', N'A', NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10010, 10010, N'SAMIRAN SEN', N'MALE', CAST(0xAE3F0B00 AS Date), N'KAIKHALI', N'SSEN@GMAIL.COM', N'9564125457', N'A', N'6YEARS', N'A', NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10011, 10011, N'sadad', N'SELECT', NULL, NULL, N'maynak@gmail.com', N'9564125457', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10012, 10012, N'Maynak', N'SELECT', NULL, NULL, N'maynak@gmail.com', N'9564125457', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10013, 10013, N'Moumita Kathma', N'SELECT', NULL, NULL, N'mkathma@gmail.com', N'7760285492', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10014, 10014, N'Maynak', N'SELECT', NULL, NULL, N'maynak@gmail.com', N'9564125457', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10015, 10015, N'Samiran Sen', N'SELECT', NULL, NULL, N'ssen@gmail.com', N'7760285492', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10016, 10016, N'Maynak', N'SELECT', NULL, NULL, N'maynak@gmail.com', N'9564125457', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10017, 10017, N'Prasenjit Malakar', N'SELECT', NULL, NULL, N'maynak@gmail.com', N'9874327601', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10018, 10018, N'aa', N'SELECT', NULL, NULL, N'a@a.com', N'1234567890', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10019, 10019, N'Sourav Bagchi', N'SELECT', NULL, NULL, N'sbagchi19@gmail.com', N'9564125457', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10020, 10020, N'Rahul Kathma', N'SELECT', NULL, NULL, N'rkathma@gmail.com', N'7894561230', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10022, 10021, N'Priyankar Polley', N'Male', CAST(0x1B7A0A00 AS Date), NULL, N'priyankarpolley@gmail.com', N'9434449749', N'B.Tech', NULL, N'Easton,Jason,', N'2019-7-1-23-43-5-Jhopkins.jpeg')
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10023, 10023, N'Amarnath Chatterjee', N'Male', CAST(0x753E0B00 AS Date), N'Howrah', N'amarnathchatterjee19@gmail.com', N'9832457812', N'B.Tech In Computer Science and Technology', N'2years and 7 months in Software Development', N'Chase,Jasmine', N'~/CandidateImages/2019-6-26-20-19-46-pic.jpg')
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10024, 10024, N'Amarnath Chatterjee', N'Male', CAST(0xCE3F0B00 AS Date), N'Howrah', N'amarnathchatterjee19@gmail.com', N'9832457812', N'B.Tech In Computer Science and Technology', N'2years and 7 months in Software Development', N'Jasmine,Chase,Jasmine', N'~/CandidateImages/')
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10025, 10025, N'Amarnath Chatterjee', N'Male', CAST(0xC83F0B00 AS Date), N'Howrah', N'amarnathchatterjee19@gmail.com', N'9832457812', N'B.Tech In Computer Science and Technology', N'2years and 7 months in Software Development and MBA', N'Chase,Jasmine', N'~/CandidateImages/')
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10026, 10026, N'Amarnath Chatterjee', N'Male', CAST(0xCE3F0B00 AS Date), N'Howrah', N'amarnathchatterjee19@gmail.com', N'9832457812', N'B.Tech In Computer Science and Technology', N'2years and 7 months in Software Development', N'Chase,Jasmine', N'~/CandidateImages/')
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10027, 10027, N'Amarnath Chatterjee', N'Male', CAST(0xC73F0B00 AS Date), N'Howrah', N'amarnathchatterjee19@gmail.com', N'9832457812', N'B.Tech In Computer Science and Technology', N'2years and 7 months in Software Development', N'Jason,Tyler,Chase,Jasmine', N'~/CandidateImages/')
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10028, 10028, N'Samiran Kumar Sen', N'Male', CAST(0xD73F0B00 AS Date), N'Kaikhali', N'samiran.sen427@gmail.com', N'9333867401', N'NSEC', N'NSEC', N'Chase,', N'2019-7-1-23-19-42-hush-naidoo-382152-unsplash.jpg')
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10029, 10029, N'Samiran1 Sen', N'Female', CAST(0xCF3F0B00 AS Date), N'Kaikhali', N'samiran.sen427@gmail.com', N'9333867401', N'NSEC', N'NSEC', N'Chase,', N'~/CandidateImages/')
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10030, 10030, N'Samiran1 Sen', N'Female', CAST(0xCF3F0B00 AS Date), N'Kaikhali', N'samiran.sen427@gmail.com', N'9333867401', N'NSEC', N'NSEC', N'Chase,', N'~/CandidateImages/')
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10031, 10031, N'Samiran Sen', N'Male', CAST(0xD73F0B00 AS Date), N'Kaikhali', N'samiran.sen427@gmail.com', N'9333867402', N'NSEC', N'NSEC', N'Chase,', N'~/CandidateImages/')
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10032, 10032, N'Ramakanta Kamar', N'SELECT', NULL, NULL, N'ramakantakamar@gmail.com', N'9686471192', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10033, 10033, N'Shama Prashad Mukharjee', N'SELECT', NULL, NULL, N'smukharjee@gmail.com', N'8910496797', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10034, 10034, N'Chanchal Choudhury', N'SELECT', NULL, NULL, N'choudhurychanchal@gmail.com', N'7760285492', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10035, 10035, N'Afrin Nisho', N'SELECT', NULL, NULL, N'nishoafrin2019@gmail.com', N'9563374959', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10036, 10036, N'Shilpi Chandra', N'SELECT', NULL, NULL, N'schandra@gmail.ocm', N'9614139176', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10037, 10037, N'Sudip Khan', N'SELECT', NULL, NULL, N'sudipkhan@gmail.com', N'9933157783', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10038, 10038, N'Sumanta Kamila', N'SELECT', NULL, NULL, N'skamila@gmail.com', N'9831546765', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10039, 10039, N'Subhankar Dey', N'Male', CAST(0x3C840A00 AS Date), N'Kalighat Metro Station, Kolkata', N'subhankar@gmail.com', N'9804315477', N'B.Tech in Electronics and Telecommunication Engineering from Techno India college of Technology in 2015', N'Work in Texcus Instruments since 2015', N'Mackenzie,Annabelle,', N'2019-7-1-23-10-45-dominik-lange-1183371-unsplash.jpg')
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10040, 10040, N'Devdutta Basu Roy', N'SELECT', NULL, NULL, N'devduttabasuroy@gmail.com', N'8617860049', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10041, 10041, N'Kalpana Ghoush', N'SELECT', NULL, NULL, N'kalpanaghoush@gmail.com', N'9987551880', NULL, NULL, NULL, NULL)
INSERT [dbo].[PERSON] ([ID], [PERSONID], [NAME], [GENDER], [DOB], [ADDRESS], [EMAIL], [MOBILE], [QUALIFICATION], [EXPERIANCE], [INTEREST], [IMGPATH]) VALUES (10042, 10042, N'Ritam Das', N'Male', CAST(0x58950A00 AS Date), NULL, N'ritamdas@gmail.com', N'8961819975', N'B.Tech in computer science and Engineering', N'6years of  Software Industries', N'Makayla,Chase,Isabella', N'2019-7-2-0-10-7-hush-naidoo-382152-unsplash.jpg')
SET IDENTITY_INSERT [dbo].[PERSON] OFF
SET IDENTITY_INSERT [dbo].[USERS] ON 

INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'sadad', N'asdasd', N'CANDIDATE', 1, 10011, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'Maynak', N'asad', N'CANDIDATE', 2, 10012, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'Moumita Kathma', N'123123', N'CANDIDATE', 3, 10013, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'Maynak', N'asad', N'CANDIDATE', 4, 10014, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'Samiran Sen', N'12345', N'ADMIN', 5, 10015, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'Maynak', N'asad', N'CANDIDATE', 6, 10016, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'Prasenjit Malakar', N'123123', N'CANDIDATE', 7, 10017, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'Sourav Bagchi', N'12345', N'CANDIDATE', 9, 10019, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'9434449749', N'12345', N'CANDIDATE', 12, 10021, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'9333867401', N'12345', N'ADMIN', 13, 10028, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'9686471192', N'12345', N'CANDIDATE', 14, 10032, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'8910496797', N'12345', N'CANDIDATE', 15, 10033, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'7760285492', N'12345', N'CANDIDATE', 16, 10034, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'aa', N'123', N'CANDIDATE', 8, 10018, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'Rahul Kathma', N'12345', N'CANDIDATE', 10, 10020, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'9563374959', N'12345', N'CANDIDATE', 17, 10035, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'9614139176', N'12345', N'CANDIDATE', 18, 10036, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'9933157783', N'12345', N'CANDIDATE', 19, 10037, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'9831546765', N'12345', N'CANDIDATE', 20, 10038, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'9804315477', N'12345', N'CANDIDATE', 21, 10039, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'8617860049', N'12345', N'CANDIDATE', 22, 10040, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'9987551880', N'12345', N'CANDIDATE', 23, 10041, 1)
INSERT [dbo].[USERS] ([USERNAME], [PASSWORD], [ROLES], [ID], [PERSONID], [ISACTIVE]) VALUES (N'8961819975', N'12345', N'CANDIDATE', 24, 10042, 1)
SET IDENTITY_INSERT [dbo].[USERS] OFF
ALTER TABLE [dbo].[JOBCOMMUNITY]  WITH CHECK ADD FOREIGN KEY([JOBNO])
REFERENCES [dbo].[JOB] ([JOBNO])
GO
ALTER TABLE [dbo].[JOBIMNOTES]  WITH CHECK ADD FOREIGN KEY([JOBNO])
REFERENCES [dbo].[JOB] ([JOBNO])
GO
ALTER TABLE [dbo].[JOBIMPDATES]  WITH CHECK ADD FOREIGN KEY([JOBNO])
REFERENCES [dbo].[JOB] ([JOBNO])
GO
ALTER TABLE [dbo].[USERS]  WITH CHECK ADD  CONSTRAINT [TBLUSERS_PERSONID_FK] FOREIGN KEY([PERSONID])
REFERENCES [dbo].[PERSON] ([PERSONID])
GO
ALTER TABLE [dbo].[USERS] CHECK CONSTRAINT [TBLUSERS_PERSONID_FK]
GO
