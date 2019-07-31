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
            if (Request.QueryString["uid"] != null)
            {
                var QueryStringVal = Request.QueryString["uid"].ToString();

                if (QueryStringVal != null || QueryStringVal != "")
                {
                    Boolean Status = Users.IsPasswordResetLinkIsvalid(QueryStringVal);
                    if (!Status == true)
                    {
                        ViewBag.Message = "Link Expired";
                    }
                }
            }
            
            

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
                SendWelcomeEmail(USROBJ.Email, USROBJ.Username);
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
            String Msg = String.Empty;
            ResetPassword resetPassword = Users.GetResetPassword(ResetPasswordvalue);
            Msg = resetPassword.Message;
            if (resetPassword.Message.Contains("Sucessfull"))
            {
               var issent=SendPasswordResetEmail(resetPassword.Email, resetPassword.Username, resetPassword.UniqueId);
                if(issent)
                {
                    Msg = "An email with instructions to reset your password is sent to  " + resetPassword.Email ;
                }
                else
                {
                    Msg = "Due to internal error a email with instructions  failed to send to  " + resetPassword.Email;
                }
            }
            return Msg;
        }

        private static bool SendPasswordResetEmail(string ToEmail, string UserName, string UniqueId)
        {
            bool issent = false;
            String EmailTemplatepath = Convert.ToString(System.Web.HttpContext.Current.Server.MapPath("~/html/ForgetPasswordEmailHtmlFile.html"));
            String EmailTemplate = String.Empty;
            String ResetLink = System.Web.HttpContext.Current.Request.Url.Host + "/Login/LoginRegistration?uid=" + UniqueId;

            EmailTemplate = Jobsportal.Common.ReadHtmlFile(EmailTemplatepath);
            EmailTemplate = EmailTemplate.Replace("@@UserName@@", UserName);
            EmailTemplate = EmailTemplate.Replace("@@ResetLink@@", ResetLink);
            String MSubject = "Reset Password";

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
                issent = true;
            }
            catch (Exception ex)
            {
                DALError.LogError("Login.SendPasswordResetEmail", ex);


            }
            return issent;

        }



       

        [HttpPost]
        public Boolean ChangeUserPasswordViaReset(String GUID, String PasswordValue)
        {
            Boolean Status = Users.ChangeUserPasswordViaReset(GUID, PasswordValue);

            return Status;
        }
        [Authorize(Roles = "ADMIN,CANDIDATE")]
        [HttpPost]
        public Boolean ModifyPassword(string OldPassword, string NewPassword)
        {
            string UserName = System.Web.HttpContext.Current.User.Identity.Name;
            Boolean Status = Users.ModifyPassword(UserName, OldPassword,NewPassword);

            return Status;
        }

        //[HttpGet]
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
                DALError.LogError("Login.SendWelcomeEmail", ex);


            }

        }
    }
}