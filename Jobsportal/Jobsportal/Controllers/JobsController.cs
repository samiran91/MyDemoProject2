using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DAL;
using System.Data;
using Newtonsoft.Json;
using System.Net.Mail;
using System.Text;
using System.Web.Script.Serialization;

namespace Jobsportal.Controllers
{
    public delegate void SendEmailToCandidate_delegate(int jobno, string jobkeywords);
    public class JobsController : Controller
    {
        // GET: Jobs
        public ActionResult Index()
        {
            return View();
        }


        #region ListJob Page
        [HttpGet]
        public ActionResult ListJob()
        {
            DAL.Utility.LogActivity("At List Job","ListJob");
            return View();
        }
        public JsonResult GetJobList(int? page, int? limit, string sortBy, string direction, string searchString = null)
        {



            Job.SearchParam searchparam = SetFilter(searchString);

            var records = Job.GetJobList(searchparam);
            if (!string.IsNullOrEmpty(searchparam.Keyword))
            {
                records = records.Where(q => q.Point > 0).ToList();
            }


            var total = records.ToList().Count();
            if (page.HasValue && limit.HasValue)
            {
                int start = (page.Value - 1) * limit.Value;
                records = records.Skip(start).Take(limit.Value).ToList();
            }

            return Json(new { records, total }, JsonRequestBehavior.AllowGet);
        }
        public Job.SearchParam SetFilter(string searchstring = null)
        {
            Job.SearchParam ret = new Job.SearchParam();
            if (searchstring != null)
            {
                string[] searchparams = searchstring.Split('|');
                ret.Keyword = Convert.ToString(searchparams[0]);
                ret.Posted = Convert.ToInt32(searchparams[1]);
                ret.Location = Convert.ToString(searchparams[2]);
            }
            return ret;
        }
        public JsonResult GetKeywordAutocompleteValue(String Keyword)
        {
            List<DAL.Job.keywordSearch> list = new List<DAL.Job.keywordSearch>();
            list = DAL.Job.FetchKeywordAutocompleteData(Keyword);

            var jsonSerialiser = new JavaScriptSerializer();
            var json = jsonSerialiser.Serialize(list);

            return Json(json, JsonRequestBehavior.AllowGet);
        }




        #endregion

        #region JobDetails Page
        [HttpGet]
        public ActionResult JobDetails()
        {
            Int32 QueryString = Convert.ToInt32(Request.QueryString["JNo"]);
            var J = Job.GetJobDescription(QueryString);
            DAL.Utility.LogActivity("At JobDetails", "JobDetails");
            return View(J);
        }


        public String FetchJobApplyLink(Int32 JobNo)
        {
            // String QueryString = Request.QueryString["JNo"];
            String ApplyURLLink = Job.FetchJobApplyURL(JobNo);

            return ApplyURLLink;
        }

        [HttpGet]
        public ActionResult FetchDiscussion(String JobNumber)
        {
            List<Job.Discussion> D = new List<Job.Discussion>();
            D = DAL.Job.FetchDiscussion(JobNumber);

            return PartialView("_FetchDiscussion", D);
        }

        [HttpPost]
        public Boolean InsertDiscussionMsg(DAL.Job.Discussion OBJ)
        {
            var status= DAL.Job.InsertDiscussionMsg(OBJ);
            return status;
        }


        #endregion
        #region List Job Admin Page
        [Authorize(Roles = "ADMIN")]
        public ActionResult ListJob_Admin()
        {
            DAL.Utility.LogActivity("At Job_Internal", "Job_Internal");
            return View();
        }
        [Authorize(Roles = "ADMIN")]
        public JsonResult GetJobAutocompleteValue(String Keyword)
        {
            List<String> list = new List<String>();
            list = DAL.Job.GetJobAutocompleteValue(Keyword);

            var jsonSerialiser = new JavaScriptSerializer();
            var json = jsonSerialiser.Serialize(list);

            return Json(json, JsonRequestBehavior.AllowGet);
        }

        #endregion
        #region Edit Job Details Admin Page
        [Authorize(Roles = "ADMIN")]
        public ActionResult EditJobDetail_Admin()
        {
            return View();
        }
        [Authorize(Roles = "ADMIN")]
        public JsonResult FetchJobDetails(Int32 Jobno)
        {
            var J = Job.GetJobDescription(Jobno);

            return Json(J, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [Authorize(Roles = "ADMIN")]
        public JsonResult SaveJobDetails(Job JobDetails)
        {
        
            int status= Job.SaveJobDetails(JobDetails);

            SendEmailToCandidate_delegate d = null;
            d = new SendEmailToCandidate_delegate(SendEmailToCandidate);

            IAsyncResult R = null;
            R = d.BeginInvoke(JobDetails.JobNo, JobDetails.JobTitle + " " + JobDetails.JobDesc + " " + JobDetails.Qualification, new AsyncCallback(TaskCompleted), null);
            
            return Json(new { status }, JsonRequestBehavior.AllowGet);
        }

        [Authorize(Roles = "ADMIN")]
        public void TaskCompleted(IAsyncResult R)
        {
            // Write here code to handle the completion of
            // your asynchronous method
        }
        [Authorize(Roles = "ADMIN")]
        public void SendEmailToCandidate(int jobno,string jobkeywords)
        {
            DataSet Candidate = DAL.Utility.CandidateData();

            string[] jobwords = jobkeywords.Split(' ');
            if(Candidate.Tables.Count>0)
            {
                if(Candidate.Tables[0].Rows.Count>0)
                {
                    foreach(DataRow dr in Candidate.Tables[0].Rows)
                    {
                        string PerKeyword = dr["PerKeyword"].ToString();
                        string[] perwords = PerKeyword.Split(' ');
                        string mailcommonwords = string.Empty;
                        string Email = dr["Email"].ToString();
                        var commonwords = jobwords.Intersect(perwords);
                        foreach (string word in commonwords)
                        {
                            mailcommonwords = mailcommonwords + "," + word;
                        }

                        if(!string.IsNullOrEmpty(mailcommonwords))
                        {
                            EmailServer emailconfigdata = EmailServer.GetEmailConfiguration();
                            SmtpClient client = new SmtpClient();
                            client.Port = Convert.ToInt32(emailconfigdata.Port);
                            client.Host = emailconfigdata.Host;
                            client.EnableSsl = emailconfigdata.SSL;
                            client.Timeout = 10000;
                            client.DeliveryMethod = SmtpDeliveryMethod.Network;
                            client.UseDefaultCredentials = false;
                            client.Credentials = new System.Net.NetworkCredential(emailconfigdata.Email, emailconfigdata.Password);

                            // string mailbody = "A New job has been posted.  You can apply the job using below link" + Environment.NewLine + System.Web.HttpContext.Current.Request.Url.Host + "/jobs/ JobDetails ? JNo = " + jobno + Environment.NewLine + "You are receiving mail because your profile contains these words " +"<b>"+ mailcommonwords+"</b>"+Environment.NewLine+ "Regards,"+ Environment.NewLine+"Drashta Infotech Team";
                            string mailbody = "A New job has been posted.  You can apply the job using below link" + Environment.NewLine + "http://jobhelperstage.drashtainfotech.com/" + "/jobs/ JobDetails ? JNo = " + jobno + Environment.NewLine + "You are receiving mail because your profile contains these words " + "<b>" + mailcommonwords + "</b>" + Environment.NewLine + "Regards," + Environment.NewLine + "Drashta Infotech Team";
                            MailMessage mm = new MailMessage(emailconfigdata.Email, Email, "Notification from  Drashta Infotech Job Helper portal ", mailbody);
                           
                            mm.BodyEncoding = UTF8Encoding.UTF8;
                            mm.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;

                            try
                            {

                                client.Send(mm);
                            }
                            catch (Exception ex)
                            {
                                DALError.LogError("Invoice.ForwardEmail", ex);


                            }
                        }

                    }
                }
            }
        }
        #endregion























    }

}
