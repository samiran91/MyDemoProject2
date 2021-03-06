﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.IO;
using DAL;
namespace Jobsportal
{
    public static class Common
    {
        public static String ReadHtmlFile(String htmlFilePath)
        {
            StringBuilder store = new StringBuilder();

            try
            {
                using (StreamReader htmlReader = new StreamReader(htmlFilePath))
                {
                    String line;
                    while ((line = htmlReader.ReadLine()) != null)
                    {
                        store.Append(line);
                    }
                }
            }
            catch (Exception ex) {
                DALError.LogError("Common.ReadHtmlFile", ex);
            }

            return store.ToString();
        }
    }
}