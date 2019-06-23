using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class Users
    {
        public string Username { get; set; }
        public string Password { get; set; }

        public string Roles { get; set; }

        public string Displayname { get; set; }

        public String Mobile { get; set; }

        public String Email { get; set; }

        public String Message { get; set; }

        public Int32 Success { get; set; }


        private const String UserName = "@STR_NAME";
        private const String UserMobile = "@STR_MOBILE";
        private const String UserEmail = "@STR_EMAIL";
        private const String UserPassword = "@STR_PASSWORD";

        public static string TrySignIn(string username, string password)
        {
            string sp = "sp_TrySignIn";
            string Role = "Invalid";
            if (!(string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password)))
            {
                string connstring = Connection.GetConnectionString();

                //string sq_stmt = string.Format("Select Roles from Users where username='{0}' and password='{1}' and IsActive=1", username, password);
                using (SqlConnection dbCon = new SqlConnection(connstring))
                {
                    dbCon.Open();

                    using (SqlCommand dbCom = new SqlCommand(sp, dbCon))
                    {
                        dbCom.CommandType = CommandType.StoredProcedure;
                        dbCom.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
                        dbCom.Parameters.Add("@password", SqlDbType.VarChar).Value = password;
                        using (SqlDataReader wizReader = dbCom.ExecuteReader())
                        {


                            while (wizReader.Read())
                            {
                                Role = (string)wizReader["Roles"];
                            }





                        }
                    }
                }
            }

            return Role;
        }


        public static Users GetUserDetail(string username)
        {
            string sp = "sp_GetUserDetail";
            string connstring = Connection.GetConnectionString();
            var p = new Users();
            //string sq_stmt = string.Format("Select * from Users where username='{0}'", username);
            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(sp, dbCon))
                {
                    dbCom.CommandType = CommandType.StoredProcedure;
                    dbCom.Parameters.Add("@username", SqlDbType.VarChar).Value = username;

                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {

                            {
                                p.Username = (string)wizReader["Username"];

                                p.Displayname = (string)wizReader["Displayname"];
                                p.Roles = (string)wizReader["Roles"];

                            };


                        }
                    }
                }
            }

            return p;
        }

        public static Users CandidateSignUp(Users USROBJ)
        {
            Users Usr = null;
            String connstring = Connection.GetConnectionString();
            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(StoredProcedure.USP_SIGNUP, dbCon))
                {

                    dbCom.CommandType = CommandType.StoredProcedure;
                    dbCom.Parameters.AddWithValue(UserName, USROBJ.Username);
                    dbCom.Parameters.AddWithValue(UserMobile, USROBJ.Mobile);
                    dbCom.Parameters.AddWithValue(UserEmail, USROBJ.Email);
                    dbCom.Parameters.AddWithValue(UserPassword, USROBJ.Password);

                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            Usr = new Users()
                            {
                                Success = (Int32)wizReader["Success"],
                                Message = (String)wizReader["Message"]
                            };
                        }
                    }
                }

            }
            return Usr;
        }

    }
}
