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

        
        //[Authorize(Roles = "Admin,Operator")]
        public JsonResult GetJobList(int? page, int? limit, string sortBy, string direction, string searchString = null)
        {
            

            var records = Job.GetJobList();

            //var NameString = (from N in records
            //                  where (N.ProductCode.ToLower().Contains(Prefix.ToLower()) || N.Description.ToLower().Contains(Prefix.ToLower()))
            //                  select new { N.ProductCode, N.Description, N.TaxableAmount, N.ProductString, N.ProductStringWStock, N.Quantity });
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

        [HttpPost]
        public JsonResult SaveJobDetails(Job JobDetails)
        {
            String Success = string.Empty;
            String Message = string.Empty;
            Job j = Job.SaveJobDetails(JobDetails);

            return Json(new { Success = Convert.ToString(Success), Message = Convert.ToString(Message) }, JsonRequestBehavior.AllowGet);
        }

        public String FetchJobApplyLink(Int32 JobNo)
        {
            // String QueryString = Request.QueryString["JNo"];
            String ApplyURLLink = Job.FetchJobApplyURL(JobNo);

            return ApplyURLLink;
        }

        public ActionResult LoginRegistration()
        {
            return View();
        }
    }
}