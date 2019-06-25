using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using DAL;

namespace Jobsportal.Controllers
{
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
            return View();
        }

        [HttpGet]
        public ActionResult JobDetails()
        {
            Int32 QueryString = Convert.ToInt32(Request.QueryString["JNo"]);
            var J = Job.GetJobDescription(QueryString);
            return View(J);
        }
        public Job.SearchParam SetFilter(string searchstring=null)
            {
            Job.SearchParam ret = new Job.SearchParam();
            if(searchstring!=null)
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
                records = records.Where(q => q.Point>0).ToList();
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
            return View();
        }
        [HttpPost]
        public JsonResult SaveJobDetails(Job JobDetails)
        {
            String Success = string.Empty;
            String Message = string.Empty;
            Int32 j = Job.SaveJobDetails(JobDetails);

            return Json(new { j }, JsonRequestBehavior.AllowGet);
        }

        public String FetchJobApplyLink(Int32 JobNo)
        {
            // String QueryString = Request.QueryString["JNo"];
            String ApplyURLLink = Job.FetchJobApplyURL(JobNo);

            return ApplyURLLink;
        }

        

        public ActionResult CandidateProfile()
        {
            return View();
        }

        public JsonResult InsertCandidateRecord(Job.CandidateProfile OBJ)
        {
            Job.CandidateProfile CP = Job.InsertCandidateRecord(OBJ);

            return Json(new { Success = Convert.ToString(CP.Success), Message = Convert.ToString(CP.Message) }, JsonRequestBehavior.AllowGet);
        }
    }
}