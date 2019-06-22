using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
  public  class Users
    {
        public string Username { get; set; }
        public string Password { get; set; }

        public string Roles { get; set; }

        public string Displayname { get; set; }
       


      public static string TrySignIn(string username,string password)
        {
            string sp = "sp_TrySignIn";
          string Role="Invalid";
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
                             p. Username = (string)wizReader["Username"];
                             
                             p. Displayname = (string)wizReader["Displayname"];
                             p.Roles = (string)wizReader["Roles"];
                             
                          };

                          
                      }
                  }
              }
          }

          return p;
      }
    }
}
