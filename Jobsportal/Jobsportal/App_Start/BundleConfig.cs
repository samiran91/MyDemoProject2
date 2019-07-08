using System.Web;
using System.Web.Optimization;
using System;
namespace Jobsportal
{
    public class BundleConfig
    {
        // For more information on bundling, visit https://go.microsoft.com/fwlink/?LinkId=301862
        public static void RegisterBundles(BundleCollection bundles)
        {

            BundleTable.EnableOptimizations = true;
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*"));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at https://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new ScriptBundle("~/bundles/bootstrap").Include(
                      "~/Scripts/bootstrap.js",
                      "~/Scripts/respond.js"));

            bundles.Add(new StyleBundle("~/Content/css").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/site.css"));

            bundles.Add(new ScriptBundle("~/bundles/Layout").Include(
                    "~/Scripts/jquery-3.3.1.min.js",
                    "~/Scripts/bootstrap.js",
                    "~/Scripts/jquery-ui.js",
                    "~/Scripts/utility.js",
                    "~/Scripts/grid/grid.js",
                    "~/Scripts/jquery-confirm.js",
                    "~/ Scripts/respond.js",
                    "~/Scripts/lodash.underscore.js",
                    "~/Scripts/jqueryui-multisearch.js"



                    ));
            bundles.Add(new StyleBundle("~/Content/Layout").Include(
                      "~/Content/bootstrap.css",
                      "~/Content/jquery-ui.css",
                      "~/Content/Site.css",
                      "~/Content/grid/grid.css",
                      "~/Content/jquery-confirm.css",
                      "~/Content/summernote.css"
                      

                      ));
            bundles.Add(new ScriptBundle("~/bundles/JobList").Include(
                   "~/Scripts/JobList/JobList.js"
                  
                   ));

            bundles.Add(new ScriptBundle("~/bundles/JobDetalis").Include(
                  "~/Scripts/JobDetails/JobDetalis.js"

                  ));


            bundles.Add(new ScriptBundle("~/bundles/JobInternal").Include(
                  "~/Scripts/JobList/Job_internal.js"

                  ));
            bundles.Add(new StyleBundle("~/Content/JobList").Include(
                      "~/Content/JobsPortalStyleSheets/JobsPortal.css"

                      ));

            bundles.Add(new ScriptBundle("~/bundles/CandidateProfile").Include(
                 "~/Scripts/CandidateProfile/CandidateProfile.js"

                 ));
            bundles.Add(new StyleBundle("~/Content/CandidateProfile").Include(
                      "~/Content/CandidateProfile/CandidateProfile.css"

                      ));
            bundles.Add(new ScriptBundle("~/bundles/EditJob").Include(
                "/Scripts/EditJobDetail/EditJobDetail.js"
                ));
            bundles.Add(new ScriptBundle("~/bundles/UserReg").Include(
              "~/Scripts/UserRegistration/UserRegistration.js"

              ));
            bundles.Add(new StyleBundle("~/Content/EditJob").Include(
                      "~/Content/EditJobDetail/EditJobDetail.css"

                      ));
        }
    }
}
