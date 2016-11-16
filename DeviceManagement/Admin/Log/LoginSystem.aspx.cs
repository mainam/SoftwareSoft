using DataAccess;
using DataAccess.LogFolder;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.Admin.Log
{
    public partial class LoginSystem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var username = HttpContext.Current.User.Identity.Name;
                if (!UserInfo.IsAdmin(context,username))
                {
                    Response.Redirect("/home/error404.html");
                }
                else
                {
                }
            }
        }


        [WebMethod]
        public static string LoadData(string keyword, int page, int numberinpage)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                int totalitem = 0;
                var data = LogInfo.GetAll(username, keyword, page, numberinpage, ref totalitem);
                return new JavaScriptSerializer().Serialize(new { Status = true, TotalItem = totalitem, Data = data.Select(x => new { x.Id, x.IP, Time = x.Time.ToString(), x.UserName, x.Status }) });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string Delete(List<int> ListID)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                if (LogInfo.Delete(ListID, username))
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}