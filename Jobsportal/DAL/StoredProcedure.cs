using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace DAL
{
    public class StoredProcedure
    {
        public const String sp_LogError = "sp_LogError";

        public const String usp_Job_GetJobDetails = "usp_Job_GetJobDetails";

        public const String usp_JOBIMPDATES_GetEventDateTime = "usp_JOBIMPDATES_GetEventDateTime";

        public const string usp_JOBIMNOTES_GetJobNotes = "usp_JOBIMNOTES_GetJobNotes";
    }
}