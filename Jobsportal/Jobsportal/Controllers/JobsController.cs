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

        [HttpGet]
        public ActionResult ListJob()
        {
            Utility.LogActivity("At List Job", "ListJob");
            return View();
        }

        [HttpGet]
        public ActionResult JobDetails()
        {
            Int32 QueryString = Convert.ToInt32(Request.QueryString["JNo"]);
            var J = Job.GetJobDescription(QueryString);
            Utility.LogActivity("At JobDetails", "JobDetails");
            return View(J);
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

        //[Authorize(Roles = "Admin,Operator")]
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

        public ActionResult Editjobdetail()
        {
            return View();
        }

        public ActionResult Job_Internal()
        {
            Utility.LogActivity("At Job_Internal", "Job_Internal");
            return View();
        }

        [HttpPost]
        public JsonResult SaveJobDetails(Job JobDetails)
        {

            int status = Job.SaveJobDetails(JobDetails);

            SendEmailToCandidate_delegate d = null;
            d = new SendEmailToCandidate_delegate(SendEmailToCandidate);

            IAsyncResult R = null;
            R = d.BeginInvoke(JobDetails.JobNo, JobDetails.JobTitle + " " + JobDetails.JobDesc + " " + JobDetails.Qualification, new AsyncCallback(TaskCompleted), null);

            return Json(new { status }, JsonRequestBehavior.AllowGet);
        }
        public void TaskCompleted(IAsyncResult R)
        {
            // Write here code to handle the completion of
            // your asynchronous method
        }
        public void SendEmailToCandidate(int jobno, string jobkeywords)
        {
            DataSet Candidate = Utility.CandidateData();

            string[] jobwords = jobkeywords.Split(' ');
            if (Candidate.Tables.Count > 0)
            {
                if (Candidate.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in Candidate.Tables[0].Rows)
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

                        if (!string.IsNullOrEmpty(mailcommonwords))
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
        public String FetchJobApplyLink(Int32 JobNo)
        {
            // String QueryString = Request.QueryString["JNo"];
            String ApplyURLLink = Job.FetchJobApplyURL(JobNo);

            return ApplyURLLink;
        }



        public ActionResult CandidateProfile()
        {
            Utility.LogActivity("At CandidateProfile", "CandidateProfile");
            return View();
        }

        public JsonResult SaveCandidateRecord(Job.CandidateProfile OBJ)
        {
            OBJ.Mobile = System.Web.HttpContext.Current.User.Identity.Name;
            Job.CandidateProfile CP = Job.SaveCandidate(OBJ);

            return Json(true);
        }



        [HttpPost]
        public JsonResult UploadFiles()
        {
            // Checking no of files injected in Request object  
            if (Request.Files.Count > 0)
            {
                try
                {
                    //  Get all files from Request object
                    string fname;
                    HttpFileCollectionBase files = Request.Files;
                    for (int i = 0; i < files.Count; i++)
                    {
                        //string path = AppDomain.CurrentDomain.BaseDirectory + "Uploads/";  
                        //string filename = Path.GetFileName(Request.Files[i].FileName);  

                        HttpPostedFileBase file = files[i];


                        // Checking for Internet Explorer  
                        if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                        {
                            string[] testfiles = file.FileName.Split(new char[] { '\\' });
                            fname = testfiles[testfiles.Length - 1];
                        }
                        else
                        {
                            fname = file.FileName;
                        }
                        fname = Request.Files.AllKeys[0].ToString();
                        // Get the complete folder path and store the file inside it.  
                        fname = Path.Combine(Server.MapPath("~/CandidateImages/"), fname);
                        file.SaveAs(fname);
                    }
                    // Returns message that successfully uploaded  
                    return Json("");
                }
                catch (Exception ex)
                {
                    return Json("File Upload Error occurred. Error details: " + ex.Message);
                }
            }
            else
            {
                return Json("No files selected.");
            }
        }


        public JsonResult FetchCandidateDetails()
        {
            string phoneno = System.Web.HttpContext.Current.User.Identity.Name;
            Job.CandidateProfile CP = Job.FetchCandidateDetails(phoneno);
            if (CP.ImgValue != null)
            {
                CP.ImgValue = "/CandidateImages/" + CP.ImgValue;
            }

            return Json(CP, JsonRequestBehavior.AllowGet);
        }

        public JsonResult FetchJobDetails(Int32 Jobno)
        {
            var J = Job.GetJobDescription(Jobno);

            return Json(J, JsonRequestBehavior.AllowGet);
        }




        public JsonResult GetKeywordAutocompleteValue(String Keyword)
        {
            List<DAL.Job.keywordSearch> list = new List<DAL.Job.keywordSearch>();
            list = DAL.Job.FetchKeywordAutocompleteData(Keyword);

            var jsonSerialiser = new JavaScriptSerializer();
            var json = jsonSerialiser.Serialize(list);

            return Json(json, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetJobAutocompleteValue(String Keyword)
        {
            List<String> list = new List<String>();
            list = DAL.Job.GetJobAutocompleteValue(Keyword);

            var jsonSerialiser = new JavaScriptSerializer();
            var json = jsonSerialiser.Serialize(list);

            return Json(json, JsonRequestBehavior.AllowGet);
        }


        [HttpGet]
        public ActionResult FetchDiscussion(String JobNumber)
        {
            List<Job.Discussion> D = new List<Job.Discussion>();
            D = DAL.Job.FetchDiscussion(JobNumber);

            return PartialView("_FetchDiscussion",D);
        }
    }

}
