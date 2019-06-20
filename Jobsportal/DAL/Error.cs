using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
    public class DALError
    {
        public static void LogError(string source,Exception ex)
        {
           string connstring = Connection.GetConnectionString();

           using (SqlConnection dbCon = new SqlConnection(connstring))
           {
               dbCon.Open();

               using (SqlCommand dbCom = new SqlCommand(StoredProcedure.sp_LogError, dbCon))
               {
                   dbCom.CommandType = CommandType.StoredProcedure;
                   dbCom.Parameters.Add("@Server", SqlDbType.VarChar).Value = System.Net.Dns.GetHostName();
                   dbCom.Parameters.Add("@Source", SqlDbType.VarChar).Value = source;
                   dbCom.Parameters.Add("@Message", SqlDbType.VarChar).Value = ex.Message;
                   dbCom.Parameters.Add("@StackTrace", SqlDbType.VarChar).Value = ex.StackTrace;
                 

                   try
                   {
                   
                       dbCom.ExecuteNonQuery();
                   }
                   catch(Exception exp)//Error handler itself failing,most cause database not reachable
                   {
                       System.IO.File.AppendAllText(System.Web.HttpContext.Current.Server.MapPath("~\\ErrorLog.txt"),DateTime.UtcNow.ToString()+exp.ToString());
                   }
                

               }
           }
            
                        
        }
    }
}
