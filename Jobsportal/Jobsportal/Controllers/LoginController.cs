using DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;

namespace Jobsportal.Controllers
{
    public class LoginController : Controller
    {

        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult SignIn(Users userdata)
        {
            string role = Users.TrySignIn(userdata.Username, userdata.Password);
            if (!role.Contains("Invalid"))
            {
                userdata.Roles = role;

                FormsAuthentication.SetAuthCookie(userdata.Username, false);

                var authTicket = new FormsAuthenticationTicket(1, userdata.Username, DateTime.Now, DateTime.Now.AddMinutes(20), false, userdata.Roles);
                string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                var authCookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                HttpContext.Response.Cookies.Add(authCookie);

                return Json(true);
            }
            else
            {
                return Json(false);
            }

        }


        [HttpGet]
        public ActionResult LoginRegistration()
        {
            return View();
        }
        public ActionResult SignOut()
        {


            FormsAuthentication.SignOut();

            return RedirectToAction("Index");


        }

        [HttpPost]
        public JsonResult CandidateSignUp(Users USROBJ)
        {
            Users U = Users.CandidateSignUp(USROBJ);

            return Json(new { Success = Convert.ToString(U.Success), Message = Convert.ToString(U.Message) }, JsonRequestBehavior.AllowGet);
        }


        [HttpGet]
        public ActionResult FooterTemplate()
        {
            return PartialView("_FooterTemplate");
        }

    }
}