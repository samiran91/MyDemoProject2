using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Web;
namespace DAL
{
    public class Utility
    {

        public static void LogActivity(String message,string PageName)
        {
            try
            {
               
                  if(HttpContext.Current.Session["sessionid"]==null)
                {
                    HttpContext.Current.Session["sessionid"] = HttpContext.Current.Session.SessionID + DateTime.Now.Ticks.ToString();
                }
                        String connstring = Connection.GetConnectionString();
                string session = string.Empty;
                     using (SqlConnection conn = new SqlConnection(connstring))
                        {
                            conn.Open();
                            String query = "INSERT INTO dbo.ActivityLog (Timestamp, Session, IP, Browser, Device, Message,PageName) VALUES (@Timestamp, @Session, @IP, @Browser, @Device, @Message,@PageName)";
                            using (SqlCommand cmd = new SqlCommand(query, conn))
                            {
                                cmd.CommandType = CommandType.Text;
                                cmd.Parameters.AddWithValue("@Timestamp", DateTime.UtcNow);
                                cmd.Parameters.AddWithValue("@Session", HttpContext.Current.Session["sessionid"]);
                                cmd.Parameters.AddWithValue("@IP", HttpContext.Current.Request.UserHostAddress);
                                cmd.Parameters.AddWithValue("@Browser", HttpContext.Current.Request.Browser.Browser);
                                cmd.Parameters.AddWithValue("@Device", HttpContext.Current.Request.Browser.Platform);
                                cmd.Parameters.AddWithValue("@Message", message);
                               cmd.Parameters.AddWithValue("@PageName", PageName);
                                cmd.ExecuteNonQuery();
                            } 
                            conn.Close();

                        } 
                    
               
            }

            catch(Exception ex)
            {
                //To do
            }
    }

        public static DataSet CandidateData()
        {

            String sql_select = String.Format("Select ISNULL(QUALIFICATION,'') +' '+ISNULL(EXPERIANCE,'') +' '+ISNULL(INTEREST,'') as PerKeyword, EMAIL from PERSON");
            String connstring = Connection.GetConnectionString();
            DataSet ds = new DataSet();


            SqlDataAdapter adpt = new SqlDataAdapter(sql_select, connstring);
            adpt.Fill(ds);
            return ds;
        }
    }
}
