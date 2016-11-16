using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess.DeviceFolder;
using DataAccess;
using DataAccess.UserFolder;
namespace SoftwareStore.device.Common
{
    public partial class CabinetManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var username = HttpContext.Current.User.Identity.Name;
                User user = null;
                if (username != null)
                    user = UserInfo.GetByID(context, username);

                if (!UserInfo.IsAdmin(context,user))
                {
                    Response.Redirect("~/home/error404.html");
                }
            }
        }
        [WebMethod]
        public static string LoadData(string keyword, int numberinpage, int currentpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int totalitem = 0;
                    var listtake = CabinetInfo.GetDataCabinet(context, keyword.ToLower(), currentpage, numberinpage, ref totalitem);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listtake, TotalItem = totalitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string Delete(int id)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (UserInfo.IsAdmin(context, username) && CabinetInfo.Delete(context,id))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    return new JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string Save(int id, string name, string location, bool status)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (UserInfo.IsAdmin(context,username) && CabinetInfo.Save(context,id, name, location, status))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    return new JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}