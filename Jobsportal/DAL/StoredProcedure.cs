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

        public const String usp_JOBIMNOTES_GetJobNotes = "usp_JOBIMNOTES_GetJobNotes";

        public const String USP_JOBEVENTDATETIME_INSERTJOBDETAILS = "USP_JOBEVENTDATETIME_INSERTJOBDETAILS";

        public const String USP_PERSON_CANDIDATEINSERTUPDATE = "USP_PERSON_CANDIDATEINSERTUPDATE";

        public const String USP_JOB_INSERTJOBDETAILS = "USP_JOB_INSERTJOBDETAILS";

        public const String USP_SIGNUP = "USP_SIGNUP";

        public const String USP_PERSON_GETPERSONDETAILS = "USP_PERSON_GETPERSONDETAILS";

        public const String USP_JOBIMNOTES_INSERTIMNOTES = "USP_JOBIMNOTES_INSERTIMNOTES";

        public const String USP_RESETPASSWPRD = "USP_RESETPASSWPRD";

    }
}