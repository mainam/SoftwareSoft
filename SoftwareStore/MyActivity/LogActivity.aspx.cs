using DataAccess.LogFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.MyActivity
{
    public partial class LogActivity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string LoadData(string keyword, int page, int numberinpage)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                int totalitem = 0;
                var data = LogInfo.GetByUser(username, keyword, page, numberinpage, ref totalitem);
                return new JavaScriptSerializer().Serialize(new { Status = true, TotalItem = totalitem, Data = data.Select(x => new { x.Id, x.IP, Time = x.Time.ToString(), x.UserName, x.Status }) });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

    }
}