ALTER PROCEDURE [dbo].[usp_GetJobDetails]



 @Jobno INT=0,

 @Keyword nvarchar(100)='',

   @Location nvarchar(100)='All',

    @Posted INT='-365'



AS

SET NOCOUNT ON

	BEGIN

			IF(@Jobno=0)

			BEGIN

			IF(LEN(@Keyword)>0)

				BEGIN

				IF(@Location<>'All')

				BEGIN

					SELECT JOBNO,JOBTITLE,JOBDESC,POSTEDDATE,QUALIFICATION,APPLYLINK,Location,Comments,POINT = 2*(LEN(JOBTITLE) - LEN(REPLACE(JOBTITLE, @Keyword, '')))/LEN(@Keyword)+1 * (LEN(JOBDESC) - LEN(REPLACE(JOBDESC, @Keyword, '')))/LEN(@Keyword)+ 2 * (LEN(QUALIFICATION) - LEN(REPLACE(QUALIFICATION, @Keyword, '')))/LEN(@Keyword) FROM JOB where POSTEDDATE>DATEADD(DAY,@Posted,GETDATE()) and Location like '%'+@Location+'%' and IsDeleted=0   order by POINT desc,posteddate desc

				END

				ELSE

				BEGIN

				SELECT JOBNO,JOBTITLE,JOBDESC,POSTEDDATE,QUALIFICATION,APPLYLINK,Location,Comments,POINT = 2*(LEN(JOBTITLE) - LEN(REPLACE(JOBTITLE, @Keyword, '')))/LEN(@Keyword)+1 * (LEN(JOBDESC) - LEN(REPLACE(JOBDESC, @Keyword, '')))/LEN(@Keyword)+ 2 * (LEN(QUALIFICATION) - LEN(REPLACE(QUALIFICATION, @Keyword, '')))/LEN(@Keyword) FROM JOB where POSTEDDATE>DATEADD(DAY,@Posted,GETDATE()) and IsDeleted=0   order by POINT desc,posteddate desc

				END

				END

ELSE

IF(@Location<>'All')

BEGIN

SELECT JOBNO,JOBTITLE,JOBDESC,POSTEDDATE,QUALIFICATION,APPLYLINK,Location,Comments,0 as POINT FROM JOB where POSTEDDATE>DATEADD(DAY,@Posted,GETDATE()) and Location like '%'+@Location+'%' and IsDeleted=0  order by posteddate desc

END

ELSE

BEGIN

SELECT JOBNO,JOBTITLE,JOBDESC,POSTEDDATE,QUALIFICATION,APPLYLINK,Location,Comments,0 as POINT FROM JOB where POSTEDDATE>DATEADD(DAY,@Posted,GETDATE()) and IsDeleted=0  order by posteddate desc

END

END

			ELSE



				BEGIN



					SELECT JOBNO,JOBTITLE,JOBDESC,POSTEDDATE,QUALIFICATION,APPLYLINK,Location,Comments FROM JOB WHERE JOBNO=@Jobno and IsDeleted=0



				END

	END