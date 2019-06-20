using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL
{
   public class Connection
    {
       public static string GetConnectionString()
       {
          return  System.Configuration.ConfigurationManager.ConnectionStrings["DBConnection"].ToString();

       }
    }
}
