using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public class EmailServer
    {
        public string Host { get; set; }
        public string Port { get; set; }
        public bool SSL { get; set; }
        public string Email { get; set; }
        public string Password { get; set; }
        public static EmailServer GetEmailConfiguration()
        {

            EmailServer emailconfig = new EmailServer();



            string sp = "sp_GetEmailConfig";

            string connstring = Connection.GetConnectionString();



            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();
                

                using (SqlCommand dbCom = new SqlCommand(sp, dbCon))
                {
                    dbCom.CommandType = CommandType.StoredProcedure;

                    using (SqlDataReader wizReader = dbCom.ExecuteReader())
                    {
                        while (wizReader.Read())
                        {
                            
                            {
                                emailconfig.Host = (string)wizReader["Host"];
                                emailconfig.Port = (string)wizReader["Port"];
                                emailconfig.SSL = (bool)wizReader["SSL"];
                                emailconfig.Email = (string)wizReader["Email"];
                                emailconfig.Password = (string)wizReader["Password"];
                                



                            };
                            
                           
                        }
                    }
                }
            }

            return emailconfig;
        }
        public static bool Save(EmailServer EmailData)
        {
            string sp = "sp_EmailServer_Save";

            string connstring = Connection.GetConnectionString();

            using (SqlConnection dbCon = new SqlConnection(connstring))
            {
                dbCon.Open();

                using (SqlCommand dbCom = new SqlCommand(sp, dbCon))
                {
                    dbCom.CommandType = CommandType.StoredProcedure;
                    dbCom.Parameters.Add("@HOST", SqlDbType.VarChar).Value = EmailData.Host;
                    dbCom.Parameters.Add("@PORT", SqlDbType.VarChar).Value = EmailData.Port;

                    dbCom.Parameters.Add("@SSL", SqlDbType.Bit).Value = EmailData.SSL;

                    dbCom.Parameters.Add("@Email", SqlDbType.VarChar).Value = EmailData.Email;
                    dbCom.Parameters.Add("@Password", SqlDbType.VarChar).Value = EmailData.Password;
                    

                    dbCom.ExecuteNonQuery();

                }
            }


            return true;
        }
    }
}
