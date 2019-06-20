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
        public JsonResult GetJobList()
        {
            //   var records = Job.GetJobList(HttpContext.Request.Cookies["Business"].Value);   string Prefix

            var records = Job.GetJobList();

            //var NameString = (from N in records
            //                  where (N.ProductCode.ToLower().Contains(Prefix.ToLower()) || N.Description.ToLower().Contains(Prefix.ToLower()))
            //                  select new { N.ProductCode, N.Description, N.TaxableAmount, N.ProductString, N.ProductStringWStock, N.Quantity });

            return Json(records, JsonRequestBehavior.AllowGet);
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


            return Json(new { Success = Convert.ToString(Success), Message = Convert.ToString(Message) }, JsonRequestBehavior.AllowGet);
        }

        public String FetchJobApplyLink(Int32 JobNo)
        {
            // String QueryString = Request.QueryString["JNo"];
            String ApplyURLLink = Job.FetchJobApplyURL(JobNo);

            return ApplyURLLink;
        }
    }
}