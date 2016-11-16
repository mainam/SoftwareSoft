using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class Global
    {
        public static int DEFAULT_TEAM_ID = 54;

        public enum ProjectStatus
        {
            Ongoing,
            Upcoming,
            Completed,
            Drop
        }

        public enum ProjectCategory
        {
            SDK,
            Mobile,
            Camera,
            Unknown
        }

        public enum ProjectGrade
        {
            B,
            BL,
            D
        }

        public enum IssueStatus
        {
            Open,
            Resolved,
            Closed
        }

        public enum IssueType
        {
            apitest,
            mobilecare,
            convergentest,
            networksimulationtest,
            operatortest,
            servertest,
            applicationtest,
            fieldtest,
            performancetest,
            smctest,
            stresstest,
            manufacturingtest,
            requirementtest,
            swtest,
            usabilitytest,
            menutreetest,
            exploratorytest,
            automationtest,
            mmtest,
            monitoringtest,
            uitest,
            compatibilitytest,
            otherchecklist,
            wpqxcertify,
            codereview,
            ecim,
            sampleapp
        }

        public static Dictionary<IssueType, string> ISSUE_TYPE_NAME = new Dictionary<IssueType, string>()
        {
            {IssueType.apitest, "API"},
            {IssueType.mobilecare, "Mobile Care"},
            {IssueType.convergentest, "Convergence"},
            {IssueType.networksimulationtest, "Network Simulation"},
            {IssueType.operatortest, "Operator"},
            {IssueType.servertest, "Server"},
            {IssueType.applicationtest, "Application"},
            {IssueType.fieldtest, "Field Test"},
            {IssueType.performancetest, "Performance"},
            {IssueType.smctest, "SMC"},
            {IssueType.stresstest, "Stress Test"},
            {IssueType.manufacturingtest, "Manufacturing"},
            {IssueType.requirementtest, "Requirement"},
            {IssueType.swtest, "Software"},
            {IssueType.usabilitytest, "Usability"},
            {IssueType.menutreetest, "Menu Tree"},
            {IssueType.exploratorytest, "Exploratory"},
            {IssueType.automationtest, "Automation"},
            {IssueType.mmtest, "MM Test"}, 
            {IssueType.monitoringtest, "Monitoring Test"},
            {IssueType.uitest, "UI"},
            {IssueType.compatibilitytest, "Compatibility"},
            {IssueType.otherchecklist, "Other Check List"},
            {IssueType.wpqxcertify, "WPQ Certify"},
            {IssueType.codereview, "Code Review"},
            {IssueType.ecim, "Ecim"},
            {IssueType.sampleapp, "Sample App"}
        };

        public static List<IssueType> ENGINEERING_ISSUE_TYPES = new List<IssueType>()
        {
            IssueType.apitest,
            IssueType.performancetest,
            IssueType.automationtest,
            IssueType.codereview,
            IssueType.stresstest,
            IssueType.convergentest
        };

        public static string SERVER_URL = "http://localhost:52667/";
    }
}
