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



        private const String DBOp = "@i_DBOP";
        private const String JobNum = "@JobNumber";
        private const string Keyword = "Keyword";
        private const string Location = "Location";

        private const string Posted = "Posted";
        private const String JobEvents = "@STR_EVENTS";
        private const String JobEventsDT = "@DT_EVENTSDATETIME";
        private const String InsertCondition = "@INT_INSERT";
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
        }
        public class SearchParam
        {
            public string Keyword { get; set; }
            public string Location { get; set; }

            public int Posted { get; set; }
        }
        public static List<Job> GetJobList(SearchParam param=null)
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
                                Point= Convert.ToInt32(wizReader["POINT"]),
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
                                ApplyLink= (String)wizReader["APPLYLINK"],
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
                                JobNo=JobNumber,
                                Events = Convert.ToString(wizReader["EVENTS"]),
                                EventDateTime =Convert.ToDateTime(wizReader["EVENTSDATETIME"]),
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

        public static Job SaveJobDetails(Job JobDetails)
        {
            String connstring = Connection.GetConnectionString();
            Job JOBJ = new Job();
            Job J = null;

            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();
                foreach (var item in JobDetails.JobImpDates)
                {
                    using (SqlCommand dbCom = new SqlCommand(StoredProcedure.USP_JOBEVENTDATETIME_INSERTJOBDETAILS, dbCon))
                    {

                        dbCom.CommandType = CommandType.StoredProcedure;
                        // dbCom.Parameters.AddWithValue(InsertCondition, 0);

                        try
                        {

                            dbCom.Parameters.AddWithValue(JobEvents, item.Events);
                            dbCom.Parameters.AddWithValue(JobEventsDT, item.EventDateTime);
                            dbCom.Parameters.AddWithValue(InsertCondition, 0);
                            dbCom.Parameters.AddWithValue(JobNum, JobDetails.JobNo);


                            dbCom.ExecuteNonQuery();



                        }
                        catch (Exception e)
                        {

                        }
                    }

                    
                }

            }

            return J;
        }
    }

   
}
