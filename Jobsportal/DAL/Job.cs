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
            public int JobNo { get; set; }
            public String Events { get; set; }

            public DateTime EventDateTime { get; set; }
        }

        public class JOBIMNOTES
        {
            public int JobNo { get; set; }
            public String Title { get; set; }

            public String DownloadLink { get; set; }

            public String Uplodedby { get; set; }

            public DateTime Uplodeddate { get; set; }
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
            public int ID { get; set; }

            public String Keyword { get; set; }
        }

        private const String DBOp = "@i_DBOP";
        private const String JobNum = "@JobNumber";
        private const string Keyword = "Keyword";
        private const string Location = "Location";

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
                    dbCom.Parameters.Add(DBOp, SqlDbType.VarChar).Value = 0;
                    if (param.Keyword != null)
                    {
                        dbCom.Parameters.Add(Keyword, SqlDbType.VarChar).Value = param.Keyword;

                        dbCom.Parameters.Add(Location, SqlDbType.VarChar).Value = param.Location;
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
                    dbCom.Parameters.Add(DBOp, SqlDbType.VarChar).Value = JobNumber;
                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            J = new Job()
                            {
                                JobNo = (Int32)wizReader["JOBNO"],
                                JobTitle = (String)wizReader["JOBTITLE"],
                                JobDesc = HttpUtility.HtmlDecode((String)wizReader["JOBDESC"]),
                                PostedDate = (DateTime)wizReader["POSTEDDATE"],
                                Qualification = (String)wizReader["QUALIFICATION"],
                                ApplyLink = (String)wizReader["APPLYLINK"],
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
                                JobNo = JobNumber,
                                Events = Convert.ToString(wizReader["EVENTS"]),
                                EventDateTime = Convert.ToDateTime(wizReader["EVENTSDATETIME"]),
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
                                Title = Convert.ToString(wizReader["TITLE"]),
                                DownloadLink = Convert.ToString(wizReader["DOWNLOADLINK"]),
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

            Int32 RowAffected = 0;

            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                Int32 JobNumber = SaveJobInfo(JobDetails);
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
                                    dbCom.Parameters.AddWithValue("@DT_UPLODEDDATE", item.Uplodeddate);
                                    dbCom.Parameters.AddWithValue("@STR_DOWNLOADLINK", item.DownloadLink);
                                    dbCom.Parameters.AddWithValue("@STR_UPLODEDBY", item.Uplodedby);
                                    dbCom.Parameters.AddWithValue("@INT_INSERT", 0);

                                    //var temp= dbCom.ExecuteNonQuery();
                                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                                    {
                                        while (wizReader.Read())
                                        {
                                            var Success = (Int32)wizReader["SUCCESS"];
                                            var Message = (String)wizReader["MESSAGE"];
                                        }
                                    }

                                }
                                catch (Exception e)
                                {

                                }
                            }

                        }
                    }
                }
                if (JobDetails.JobImpDates != null)
                {
                    if (JobDetails.JobImpDates.Count > 0)
                    {

                        foreach (var item in JobDetails.JobImpDates)
                        {
                            using (SqlCommand dbCom = new SqlCommand(StoredProcedure.USP_JOBEVENTDATETIME_INSERTJOBDETAILS, dbCon))
                            {

                                dbCom.CommandType = CommandType.StoredProcedure;

                                try
                                {

                                    dbCom.Parameters.AddWithValue(JobEvents, item.Events);
                                    dbCom.Parameters.AddWithValue(JobEventsDT, item.EventDateTime);
                                    dbCom.Parameters.AddWithValue(InsertCondition, 0);
                                    dbCom.Parameters.AddWithValue(JobNum, JobNumber);

                                    RowAffected = dbCom.ExecuteNonQuery();
                                }
                                catch (Exception e)
                                {

                                }
                            }

                        }
                    }
                }

            }

            return RowAffected;
        }

        public static CandidateProfile InsertCandidateRecord(CandidateProfile CPOBJ)
        {
            CandidateProfile OBJ = null;

          //  String ImgPath = "~/CandidateImages/" + CPOBJ.ImgValue;

            String connstring = Connection.GetConnectionString();
            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(StoredProcedure.USP_PERSON_CANDIDATEINSERTUPDATE, dbCon))
                {

                    dbCom.CommandType = CommandType.StoredProcedure;
                    //dbCom.Parameters.AddWithValue(CandidatePERSONID, 000);
                    dbCom.Parameters.AddWithValue(CandidateName, CPOBJ.Name);
                    dbCom.Parameters.AddWithValue(CandidateGender, CPOBJ.Gender);
                    dbCom.Parameters.AddWithValue(CandidateDOB, CPOBJ.DOB);
                    dbCom.Parameters.AddWithValue(CandidateAddress, CPOBJ.Address);
                    dbCom.Parameters.AddWithValue(CandidateEmail, CPOBJ.Email);
                    dbCom.Parameters.AddWithValue(CandidateMobile, CPOBJ.Mobile);
                    dbCom.Parameters.AddWithValue(CandidateQual, CPOBJ.Qualification);
                    dbCom.Parameters.AddWithValue(CandidateExp, CPOBJ.Experiance);
                    dbCom.Parameters.AddWithValue(CandidateIntrst, CPOBJ.Interests);
                    dbCom.Parameters.AddWithValue(DBOperation, 0);
                    dbCom.Parameters.AddWithValue(CandidateImage, CPOBJ.ImgValue);

                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            OBJ = new CandidateProfile()
                            {
                                Success = (Int32)wizReader["Success"],
                                Message = (String)wizReader["Message"]
                            };
                        }
                    }
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
                    dbCom.Parameters.AddWithValue(JobDescrption, HttpUtility.HtmlDecode(JobDetails.JobDesc));
                    dbCom.Parameters.AddWithValue(JobPostedDate, JobDetails.PostedDate);
                    dbCom.Parameters.AddWithValue(JobQualification, JobDetails.Qualification);
                    dbCom.Parameters.AddWithValue(JobApplyLink, JobDetails.ApplyLink);

                    try
                    {
                        using (SqlDataReader wizReader = dbCom.ExecuteReader())
                        {
                            while (wizReader.Read())
                            {
                                JobNumber = Convert.ToInt32(wizReader[0]);
                            }
                        }
                    }
                    catch (Exception e)
                    {
                        
                    }

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

                    try
                    {
                        using (SqlDataReader wizReader = dbCom.ExecuteReader())
                        {
                            while (wizReader.Read())
                            {
                                OBJ = new CandidateProfile()
                                {
                                    Name = Convert.ToString(wizReader["NAME"]),
                                    Gender = Convert.ToString(wizReader["GENDER"]),
                                    DOB =Convert.ToDateTime(wizReader["DOB"]),
                                    Address = Convert.ToString(wizReader["ADDRESS"]),
                                    Email = Convert.ToString(wizReader["EMAIL"]),
                                    Mobile = Convert.ToString(wizReader["MOBILE"]),
                                    Qualification = Convert.ToString(wizReader["QUALIFICATION"]),
                                    Experiance = Convert.ToString(wizReader["EXPERIANCE"]),
                                    Interests = Convert.ToString(wizReader["INTEREST"]),
                                    ImgValue = Convert.ToString(wizReader["IMGPATH"])
                                };
                            }
                        }
                    }
                    catch (Exception e)
                    {

                    }

                }
            }

            return OBJ;
        }


        public static List<DAL.Job.keywordSearch> FetchKeywordAutocompleteData(String Keyword)
        {
            List<DAL.Job.keywordSearch> list = new List<DAL.Job.keywordSearch>();
            
            String connstring = Connection.GetConnectionString();
            String sql_select = String.Format("SELECT ID,KEYOWRD from KEYWORD where KEYOWRD like '%{0}%' ", Keyword);
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
                                ID = Convert.ToInt32(wizReader["ID"]),
                                Keyword = Convert.ToString(wizReader["KEYOWRD"]),
                            };

                            list.Add(OBJ);
                        }

                    }

                }
            }

            return list;
        }

    }


}
