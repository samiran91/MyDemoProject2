using DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Net.Mail;
using System.IO;
using System.Text;
namespace Jobsportal.Controllers
{
    public class LoginController : Controller
    {

        // GET: Login
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult LoginRegistration()
        {
            DAL.Utility.LogActivity("At LoginRegistration", "LoginRegistration");
            return View();
        }
        [HttpPost]
        public JsonResult SignIn(Users userdata)
        {
            string role = Users.TrySignIn(userdata.Mobile, userdata.Password);
            if (!role.Contains("Invalid"))
            {
                userdata.Roles = role;

                FormsAuthentication.SetAuthCookie(userdata.Mobile, false);

                var authTicket = new FormsAuthenticationTicket(1, userdata.Mobile, DateTime.Now, DateTime.Now.AddMinutes(20), false, userdata.Roles);
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


       
        public ActionResult SignOut()
        {


            FormsAuthentication.SignOut();

            return RedirectToAction("LoginRegistration");


        }

        [HttpPost]
        public JsonResult CandidateSignUp(Users USROBJ)
        {
            Users U = Users.CandidateSignUp(USROBJ);
            if (U.Success == 1)
            {
                SendWelcomeEmail(USROBJ.Email, USROBJ.Displayname);
                SignIn(USROBJ);
            }

            return Json(new { Success = Convert.ToString(U.Success), Message = Convert.ToString(U.Message) }, JsonRequestBehavior.AllowGet);

            
        }


       
        [HttpGet]
        public ActionResult ResetPassword()
        {
            var QueryStringVal = Request.QueryString["uid"].ToString();
            Boolean Status = Users.IsPasswordResetLinkIsvalid(QueryStringVal);
            if (!Status == true)
            {
                ViewBag.Message = "Link Expired";
            }

            return View();
        }
        public String GetResetPassword(String ResetPasswordvalue)
        {
            String Msg = Users.GetResetPassword(ResetPasswordvalue);
            return Msg;
        }

        

        [HttpPost]
        public Boolean ChangeUserPassword(String GUID, String PasswordValue)
        {
            Boolean Status = Users.ChangeUserPassword(GUID, PasswordValue);

            return Status;
        }


        [HttpGet]
        public ActionResult FooterTemplate()
        {
            return PartialView("_FooterTemplate");
        }

        private void SendWelcomeEmail(string ToEmail, string UserName)
        {


            String EmailTemplatepath = Convert.ToString(Server.MapPath("~/html/Welcome.html"));
            String EmailTemplate = String.Empty;

            EmailTemplate = Jobsportal.Common.ReadHtmlFile(EmailTemplatepath);
            EmailTemplate = EmailTemplate.Replace("@@UserName@@", UserName);
            String MSubject = "Welcome to Drashta Infotech";

            EmailServer emailconfigdata = EmailServer.GetEmailConfiguration();
            SmtpClient client = new SmtpClient();
            client.Port = Convert.ToInt32(emailconfigdata.Port);
            client.Host = emailconfigdata.Host;
            client.EnableSsl = emailconfigdata.SSL;
            client.Timeout = 10000;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            client.Credentials = new System.Net.NetworkCredential(emailconfigdata.Email, emailconfigdata.Password);

            MailMessage mm = new MailMessage(emailconfigdata.Email, ToEmail, MSubject, EmailTemplate);

            mm.BodyEncoding = UTF8Encoding.UTF8;
            mm.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
            mm.Subject = MSubject;
            mm.Body = EmailTemplate;
            mm.IsBodyHtml = true;

            try
            {

                client.Send(mm);
            }
            catch (Exception ex)
            {
                DALError.LogError("Users.SendPasswordResetEmail", ex);


            }

        }
    }
}