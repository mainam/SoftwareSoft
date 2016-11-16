using DataAccess;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.hr
{
    public partial class HRStatistic : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public static string StatisticQuantity()
        {
            using (var context = new DatabaseDataContext())
            {
                var result = UserInfo.StatisticQuantity(context);
                var text = new JavaScriptSerializer().Serialize(result);
                return text;
            }
        }

        public static string StatisticMajor()
        {
            using (var context = new DatabaseDataContext())
            {


                var result = UserInfo.StatisticMajor(context);
                var text = new JavaScriptSerializer().Serialize(result);
                return text;
            }
        }


        public static string StatisticAge()
        {
            using (var context = new DatabaseDataContext())
            {


                var result = UserInfo.StatisticAge(context);
                var text = new JavaScriptSerializer().Serialize(result);
                return text;
            }
        }

        public static string StatisticEducation()
        {
            using (var context = new DatabaseDataContext())
            {
                var result = UserInfo.StatisticEducation(context);
                var text = new JavaScriptSerializer().Serialize(result);

                return text;
            }
        }

        public static string StatisticTOEIC()
        {
            using (var context = new DatabaseDataContext())
            {


                var result = UserInfo.StatisticTOEIC(context);
                var text = new JavaScriptSerializer().Serialize(result);
                return text;
            }
        }
        public static string StatisticSTCLevel()
        {
            using (var context = new DatabaseDataContext())
            {
                var result = UserInfo.StatisticSTCLevel(context);
                var text = new JavaScriptSerializer().Serialize(result);
                return text;
            }
        }

    }

}