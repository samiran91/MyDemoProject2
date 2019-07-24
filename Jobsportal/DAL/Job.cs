using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Web;

namespace DAL
{

    public class Job
    {
        public int JobNo { get; set; }

        public String JobTitle { get; set; }

        public String JobDesc { get; set; }

        public DateTime PostedDate { get; set; }

        public String Qualification { get; set; }

        public String ApplyLink { get; set; }

        public String Location { get; set; }

        public int Point { get; set; }
        public List<JOBIMPDATES> JobImpDates { get; set; }

        public List<JOBIMNOTES> JobNotes { get; set; }
        
        public String Users { get; set; }

        public String Comments { get; set; }

        public DateTime Date { get; set; }

        public Int32 Success { get; set; }

        public String Message { get; set; }

        public class JOBIMPDATES
        {
            public int Id { get; set; }
            public int JobNo { get; set; }
            public String Events { get; set; }

            public DateTime EventDateTime { get; set; }

            public int DBOP { get; set; }
        }

       

        public class JOBIMNOTES
        {
            public int Id { get; set; }
            public int JobNo { get; set; }
            public String Title { get; set; }

            public String DownloadLink { get; set; }

            public String Uplodedby { get; set; }

            public DateTime Uplodeddate { get; set; }
            public int DBOP { get; set; }
        }
        public class SearchParam
        {
            public string Keyword { get; set; }
            public string Location { get; set; }

            public int Posted { get; set; }
        }

        public class CandidateProfile
        {
            public String Name { get; set; }

            public String Gender { get; set; }

            public DateTime? DOB { get; set; }

            public String Address { get; set; }

            public String Email { get; set; }

            public String Mobile { get; set; }

            public String Qualification { get; set; }

            public String Experiance { get; set; }

            public String Interests { get; set; }

            public int Success { get; set; }

            public String Message { get; set; }

            public String ImgValue { get; set; }
        }

        public class keywordSearch
        {
   

            public String Keyword { get; set; }
        }


        public class Discussion
        {
            public int ID { get; set; }

            public int ChatID { get; set; }

            public String UserName { get; set; }

            public Int32 JobNo { get; set; }

            public String Messages { get; set; }

            public DateTime MessageDateTime { get; set; }

            public Boolean MyMsg { get; set; }

            public String DisplayName { get; set; }

            public String ImgPath { get; set; }

        }

        private const String JobNum = "@JobNumber";
        private const string Keyword = "Keyword";
        private const string LocationSearch = "Location";

        private const string Posted = "Posted";
        private const String JobEvents = "@STR_EVENTS";
        private const String JobEventsDT = "@DT_EVENTSDATETIME";
        private const String InsertCondition = "@INT_INSERT";

        private const String CandidatePERSONID = "@INT_PERSONID";
        private const String CandidateName = "@STR_NAME";
        private const String CandidateGender = "@STR_GENDER";
        private const String CandidateDOB = "@DT_DOB";
        private const String CandidateAddress = "@STR_ADDRESS";
        private const String CandidateEmail = "@STR_EMAIL";
        private const String CandidateMobile = "@STR_MOBILE";
        private const String CandidateQual = "@STR_QUALIFICATION";
        private const String CandidateExp = "@STR_EXPERIANCE";
        private const String CandidateIntrst = "@STR_INTEREST";
        private const String DBOperation = "@INT_DBOPERATION";
        private const String CandidateImage = "@STR_CANDIDATEIMG";

        private const String JobTitl = "@STR_JOBTITLE";
        private const String JobDescrption = "@STR_JOBDESC";
        private const String JobPostedDate = "@DT_JOBPOSTEDDATE";
        private const String JobQualification = "@STR_QUALIFICATION";
        private const String JobApplyLink = "@STR_APPLYLINK";

        private const String Phoneno = "@phoneno";

        public static List<Job> GetJobList(SearchParam param = null)
        {

            List<Job> records = new List<Job>();

            String connstring = Connection.GetConnectionString();



            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(StoredProcedure.usp_Job_GetJobDetails, dbCon))
                {

                    dbCom.CommandType = CommandType.StoredProcedure;
                    if (param.Keyword != null)
                    {
                        dbCom.Parameters.Add(Keyword, SqlDbType.VarChar).Value = param.Keyword;

                        dbCom.Parameters.Add(LocationSearch, SqlDbType.VarChar).Value = param.Location;
                        dbCom.Parameters.Add(Posted, SqlDbType.Int).Value = param.Posted;
                    }

                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            var p = new Job()
                            {
                                JobNo = (Int32)wizReader["JOBNO"],
                                JobTitle = (String)wizReader["JOBTITLE"],
                                JobDesc = (String)wizReader["JOBDESC"],
                                PostedDate = (DateTime)wizReader["POSTEDDATE"],
                                Qualification = (String)wizReader["QUALIFICATION"],
                                Point = Convert.ToInt32(wizReader["POINT"]),
                            };

                            records.Add(p);
                        }
                    }
                }
            }

            return records;
        }

        public static Job GetJobDescription(Int32 JobNumber)
        {
            String connstring = Connection.GetConnectionString();
            Job J = null;

            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(StoredProcedure.usp_Job_GetJobDetails, dbCon))
                {

                    dbCom.CommandType = CommandType.StoredProcedure;
                    dbCom.Parameters.Add("@Jobno ", SqlDbType.VarChar).Value = JobNumber;
                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            J = new Job()
                            {
                                JobNo = (Int32)wizReader["JOBNO"],
                                JobTitle = (String)wizReader["JOBTITLE"],
                                JobDesc = (String)wizReader["JOBDESC"],
                                PostedDate = (DateTime)wizReader["POSTEDDATE"],
                                Qualification = (String)wizReader["QUALIFICATION"],
                                ApplyLink = (String)wizReader["APPLYLINK"],
                                Location = Convert.ToString(wizReader["Location"]),
                                Comments= Convert.ToString(wizReader["Comments"])
                                
                            };

                            J.JobImpDates = Job.GetEventDateList(JobNumber);
                            J.JobNotes = Job.GetJobNotesList(JobNumber);
                        }
                    }
                }

            }

            return J;
        }

        public static List<JOBIMPDATES> GetEventDateList(Int32 JobNumber)
        {
            List<JOBIMPDATES> records = new List<JOBIMPDATES>();

            String connstring = Connection.GetConnectionString();



            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(StoredProcedure.usp_JOBIMPDATES_GetEventDateTime, dbCon))
                {

                    dbCom.CommandType = CommandType.StoredProcedure;
                    dbCom.Parameters.Add(JobNum, SqlDbType.VarChar).Value = JobNumber;
                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            var K = new JOBIMPDATES()
                            {
                                Id= Convert.ToInt32(wizReader["Id"]),
                                JobNo = JobNumber,
                                Events = Convert.ToString(wizReader["EVENTS"]),
                                EventDateTime = Convert.ToDateTime(wizReader["EVENTSDATETIME"])
                            };

                            records.Add(K);
                        }
                    }
                }
            }

            return records;
        }

        public static List<JOBIMNOTES> GetJobNotesList(Int32 JobNumber)
        {
            List<JOBIMNOTES> records = new List<JOBIMNOTES>();

            String connstring = Connection.GetConnectionString();



            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(StoredProcedure.usp_JOBIMNOTES_GetJobNotes, dbCon))
                {

                    dbCom.CommandType = CommandType.StoredProcedure;
                    dbCom.Parameters.Add(JobNum, SqlDbType.VarChar).Value = JobNumber;
                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            var K = new JOBIMNOTES()
                            {
                                Id=Convert.ToInt32(wizReader["Id"]),
                                Title = Convert.ToString(wizReader["TITLE"]),
                                DownloadLink ="/Notes/" +Convert.ToString(wizReader["DOWNLOADLINK"]),
                                Uplodedby= Convert.ToString(wizReader["UPLODEDBY"]),
                                Uplodeddate=Convert.ToDateTime(wizReader["UPLODEDDATE"])
                            };

                            records.Add(K);

                        }
                    }
                }
            }

            return records;
        }

        public static String FetchJobApplyURL(Int32 JobNo)
        {

            String sql_select = String.Format("SELECT APPLYLINK FROM JOB WHERE JOBNO = {0}", JobNo);
            String connstring = Connection.GetConnectionString();
            String ApplyLinkURL = string.Empty;

            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(sql_select, dbCon))
                {

                    dbCom.CommandType = CommandType.Text;

                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            ApplyLinkURL = Convert.ToString(wizReader[0]);
                        }
                    }
                }
            }
            return ApplyLinkURL;
        }

        public static Int32 SaveJobDetails(Job JobDetails)
        {
            String connstring = Connection.GetConnectionString();

            int status = 0;
            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                Int32 JobNumber = SaveJobInfo(JobDetails);
                status = 1;
                if (JobDetails.JobNotes != null)
                {
                    if (JobDetails.JobNotes.Count > 0)
                    {

                        foreach (var item in JobDetails.JobNotes)
                        {
                            using (SqlCommand dbCom = new SqlCommand(StoredProcedure.USP_JOBIMNOTES_INSERTIMNOTES, dbCon))
                            {

                                dbCom.CommandType = CommandType.StoredProcedure;

                                try
                                {

                                    dbCom.Parameters.AddWithValue("@JobNumber", JobNumber);
                                    dbCom.Parameters.AddWithValue("@STR_TITLE", item.Title);
                                    dbCom.Parameters.AddWithValue("@DT_UPLODEDDATE", DateTime.UtcNow);
                                    dbCom.Parameters.AddWithValue("@STR_DOWNLOADLINK", item.DownloadLink);
                                    dbCom.Parameters.AddWithValue("@STR_UPLODEDBY", System.Web.HttpContext.Current.User.Identity.Name.ToString());
                                    dbCom.Parameters.AddWithValue("@INT_INSERT", item.DBOP);
                                    dbCom.Parameters.AddWithValue("Id", item.Id);
                                    dbCom.ExecuteNonQuery();
                                    status = 2;

                                }
                                catch (Exception ex)
                                {
                                    DALError.LogError("Job.SaveJobDetails-SaveImpNotes", ex);
                                }
                            }

                        }
                    }
                }
                else
                {
                    status = 2;
                }
                if (JobDetails.JobImpDates != null)
                {
                    if (JobDetails.JobImpDates.Count > 0)
                    {

                        foreach (var item in JobDetails.JobImpDates)
                        {
                            using (SqlCommand dbCom = new SqlCommand(StoredProcedure.USP_JOBEVENTDATETIME_INSERTJOBDETAILS, dbCon))
                            {
                                try

                                {

                                    dbCom.CommandType = CommandType.StoredProcedure;



                                    dbCom.Parameters.AddWithValue(JobEvents, item.Events);
                                    dbCom.Parameters.AddWithValue(JobEventsDT, item.EventDateTime);
                                    dbCom.Parameters.AddWithValue(InsertCondition, item.DBOP);
                                    dbCom.Parameters.AddWithValue(JobNum, JobNumber);
                                    dbCom.Parameters.AddWithValue("Id", item.Id);

                                    dbCom.ExecuteNonQuery();
                                    status = status + 1;
                                    if (status != 3)
                                    {
                                        status = 4;
                                    }
                                }

                                catch (Exception ex)
                                {
                                    DALError.LogError("Job.SaveJobDetails-SaveImpDates", ex);
                                }

                            }

                        }
                    }
                }
                else
                {
                    status = status + 1;
                    if (status != 3)
                    {
                        status = 4;
                    }
                }

            }

            return status;
        }

        public static CandidateProfile SaveCandidate(CandidateProfile CPOBJ)
        {
            CandidateProfile OBJ = null;


            String connstring = Connection.GetConnectionString();
            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(StoredProcedure.USP_PERSON_CANDIDATEINSERTUPDATE, dbCon))
                {

                    dbCom.CommandType = CommandType.StoredProcedure;
                    dbCom.Parameters.AddWithValue(CandidateName, CPOBJ.Name);
                    dbCom.Parameters.AddWithValue(CandidateGender, CPOBJ.Gender);
                    dbCom.Parameters.AddWithValue(CandidateDOB, CPOBJ.DOB);
                    dbCom.Parameters.AddWithValue(CandidateAddress, CPOBJ.Address);
                    dbCom.Parameters.AddWithValue(CandidateEmail, CPOBJ.Email);
                    dbCom.Parameters.AddWithValue(CandidateMobile, CPOBJ.Mobile);
                    dbCom.Parameters.AddWithValue(CandidateQual, CPOBJ.Qualification);
                    dbCom.Parameters.AddWithValue(CandidateExp, CPOBJ.Experiance);
                    dbCom.Parameters.AddWithValue(CandidateIntrst, CPOBJ.Interests);
                    dbCom.Parameters.AddWithValue(CandidateImage, CPOBJ.ImgValue);

                    dbCom.ExecuteNonQuery();


                }

            }

            return OBJ;
        }

        private static Int32 SaveJobInfo(Job JobDetails)
        {
            String connstring = Connection.GetConnectionString();
            Int32 JobNumber = 0;
            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(StoredProcedure.USP_JOB_INSERTJOBDETAILS, dbCon))
                {

                    dbCom.CommandType = CommandType.StoredProcedure;
                    dbCom.Parameters.AddWithValue(JobTitl, JobDetails.JobTitle);
                    dbCom.Parameters.AddWithValue("@i_intJOBNO", JobDetails.JobNo);
                    dbCom.Parameters.AddWithValue(JobDescrption, JobDetails.JobDesc);
                    dbCom.Parameters.AddWithValue("@Comments", JobDetails.Comments);
                    dbCom.Parameters.AddWithValue(JobPostedDate, JobDetails.PostedDate);
                    dbCom.Parameters.AddWithValue(JobQualification, JobDetails.Qualification);
                    dbCom.Parameters.AddWithValue(JobApplyLink, JobDetails.ApplyLink);
                    dbCom.Parameters.AddWithValue("@STR_Location", JobDetails.Location);


                    SqlParameter returnParameter = dbCom.Parameters.Add("@JOBNUMBER", SqlDbType.Int);
                    returnParameter.Direction = ParameterDirection.Output;


                    dbCom.ExecuteNonQuery();
                    JobNumber = Convert.ToInt32(dbCom.Parameters["@JOBNUMBER"].Value);



                }
            }
            return JobNumber;
        }

        public static CandidateProfile FetchCandidateDetails(string phoneno)
        {
            CandidateProfile OBJ = null;

            String connstring = Connection.GetConnectionString();

            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(StoredProcedure.USP_PERSON_GETPERSONDETAILS, dbCon))
                {

                    dbCom.CommandType = CommandType.StoredProcedure;
                    dbCom.Parameters.AddWithValue(Phoneno, phoneno);


                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            OBJ = new CandidateProfile()
                            {
                                Name = Convert.ToString(wizReader["NAME"]),
                                Gender = Convert.ToString(wizReader["GENDER"]),
                                DOB = Convert.ToDateTime(wizReader["DOB"]),
                                Address = Convert.ToString(wizReader["ADDRESS"]),
                                Email = Convert.ToString(wizReader["EMAIL"]),
                                Qualification = Convert.ToString(wizReader["QUALIFICATION"]),
                                Experiance = Convert.ToString(wizReader["EXPERIANCE"]),
                                Interests = Convert.ToString(wizReader["INTEREST"]),
                                ImgValue = Convert.ToString(wizReader["IMGPATH"])
                            };
                        }
                    }


                }
            }

            return OBJ;
        }


        public static List<DAL.Job.keywordSearch> FetchKeywordAutocompleteData(String Keyword)
        {
            List<DAL.Job.keywordSearch> list = new List<DAL.Job.keywordSearch>();

            String connstring = Connection.GetConnectionString();
            String sql_select = String.Format("Select keyword from (SELECT Keyword from KEYWORD union select [Subject] from [Subject] union select [DegreeName] from [Degree] ) as result where KEYWORD like '%{0}%' ", Keyword);
            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(sql_select, dbCon))
                {

                    dbCom.CommandType = CommandType.Text;


                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            var OBJ = new keywordSearch()
                            {
                               
                                Keyword = Convert.ToString(wizReader["keyword"]),
                            };

                            list.Add(OBJ);
                        }

                    }

                }
            }

            return list;
        }


        public static List<DAL.Job.keywordSearch> GetDegreeList(String Keyword)
        {
            List<DAL.Job.keywordSearch> list = new List<DAL.Job.keywordSearch>();

            String connstring = Connection.GetConnectionString();
            String sql_select = String.Format("Select DegreeName from Degree where DegreeName like '%{0}%' ", Keyword);
            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(sql_select, dbCon))
                {

                    dbCom.CommandType = CommandType.Text;


                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            var OBJ = new keywordSearch()
                            {

                                Keyword = Convert.ToString(wizReader["DegreeName"]),
                            };

                            list.Add(OBJ);
                        }

                    }

                }
            }

            return list;
        }

        public static List<String> GetJobAutocompleteValue(String Keyword)
        {
            List<String> list = new List<String>();

            String connstring = Connection.GetConnectionString();
            String sql_select = String.Format("select CONVERT(varchar(100),jobno)+' - '+JOBTITLE as JOBNUMANDTITLE from job where JOBNO like '%{0}%' or JOBTITLE like '%{0}%'", Keyword);

            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(sql_select, dbCon))
                {

                    dbCom.CommandType = CommandType.Text;


                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {

                            String JobTitle = Convert.ToString(wizReader["JOBNUMANDTITLE"]);

                            list.Add(JobTitle);
                        }

                    }

                }
            }

            return list;
        }

        public static List<Discussion> FetchDiscussion(String Jobno)
        {

            String connstring = Connection.GetConnectionString();
            
            List<Discussion> D = new List<Discussion>();

            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(StoredProcedure.USP_FETCHDISSCUSSIONTEXT, dbCon))
                {

                    dbCom.CommandType = CommandType.StoredProcedure;

                    dbCom.Parameters.AddWithValue("@JOBNO", Jobno);

                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            Discussion Chat = new Discussion();
                            Chat.ID = (Int32)wizReader["ID"];
                            Chat.ChatID = (Int32)wizReader["CHATID"];
                            Chat.UserName = (String)wizReader["USERNAME"];
                            Chat.JobNo = (Int32)wizReader["JOBNO"];
                            Chat.Messages = (String)wizReader["MESSAGES"];
                            Chat.DisplayName = Convert.ToString(wizReader["DisplayName"]);
                            Chat.ImgPath = Convert.ToString(wizReader["IMGPATH"]);
                            Chat.MessageDateTime = Convert.ToDateTime(wizReader["MSGDATETIME"]);
                            Chat.MyMsg = false;

                            if (HttpContext.Current.User.Identity != null)
                            {
                                if (Chat.UserName == System.Web.HttpContext.Current.User.Identity.Name.ToString())
                                {
                                    Chat.MyMsg = true;
                                }
                            }

                            if(Chat.ImgPath==null || Chat.ImgPath=="")
                            {
                                Chat.ImgPath = "/images/NoImage.png";
                            }
                            else
                            {
                                Chat.ImgPath = "/images/CandidateImages/" + Chat.ImgPath;
                            }

                            D.Add(Chat);
                        }
                    }
                }
            }
            return D;
        }

        public static Boolean InsertDiscussionMsg(DAL.Job.Discussion OBJ)
        {
            String connstring = Connection.GetConnectionString();
            var status = false;
            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(StoredProcedure.USP_INSERTDISSCUSSIONTEXT, dbCon))
                {

                    dbCom.CommandType = CommandType.StoredProcedure;

                    dbCom.Parameters.AddWithValue("@JobNumber", OBJ.JobNo);
                    dbCom.Parameters.AddWithValue("@USERNAME", OBJ.UserName);
                    dbCom.Parameters.AddWithValue("@MESSAGES", OBJ.Messages);

                    status = Convert.ToBoolean(dbCom.ExecuteNonQuery());


                }

            }

            return status;
        }

        public static String GetCurrentUserName(String UserName)
        {
            String connstring = Connection.GetConnectionString();
            String Query = String.Format("SELECT P.NAME FROM Person P INNER JOIN Users U ON P.PERSONID = U.PERSONID WHERE U.USERNAME='{0}'", UserName);
            String CurrentUserName = String.Empty;
            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(Query, dbCon))
                {

                    dbCom.CommandType = CommandType.Text;


                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            CurrentUserName = Convert.ToString(wizReader["NAME"]);
                        }

                    }

                }
            }

            return CurrentUserName;
        }

    }


}
