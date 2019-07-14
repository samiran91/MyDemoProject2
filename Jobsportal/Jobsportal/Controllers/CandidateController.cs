using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;
using DAL;


namespace Jobsportal.Controllers
{
    
    public class CandidateController : Controller
    {
        // GET: Candidate

        public ActionResult Index()
        {
            return View();
        }
        [Authorize(Roles = "ADMIN,CANDIDATE")]
        public ActionResult CandidateProfile()
        {
           DAL.Utility.LogActivity("At CandidateProfile", "CandidateProfile");
            return View();
        }
        [Authorize(Roles = "ADMIN,CANDIDATE")]
        public JsonResult FetchCandidateDetails()
        {
            string phoneno = System.Web.HttpContext.Current.User.Identity.Name;
            Job.CandidateProfile CP = Job.FetchCandidateDetails(phoneno);
            if (CP.ImgValue != null)
            {
                CP.ImgValue = "/Images/CandidateImages/" + CP.ImgValue;
            }

            return Json(CP, JsonRequestBehavior.AllowGet);
        }
        [Authorize(Roles = "ADMIN,CANDIDATE")]
        public JsonResult SaveCandidateRecord(Job.CandidateProfile OBJ)
        {
            OBJ.Mobile = System.Web.HttpContext.Current.User.Identity.Name;
            Job.CandidateProfile CP = Job.SaveCandidate(OBJ);

            return Json(true);
        }
        [Authorize(Roles = "ADMIN,CANDIDATE")]
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
                        fname = Path.Combine(Server.MapPath("~/Images/CandidateImages/"), fname);
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

        

    }
}