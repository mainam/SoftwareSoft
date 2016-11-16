using DataAccess;
using DataAccess.DeviceFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.device
{
    public partial class DeviceInTeam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string GetTypeOnLoad()
        {
            try
            {
                var arrid = HttpContext.Current.Session["type"];
                HttpContext.Current.Session["type"] = "";
                var jsonSerialiser = new JavaScriptSerializer();
                return jsonSerialiser.Serialize(arrid);
            }
            catch (Exception)
            {
                return "";
            }

        }
        [WebMethod]
        public static string LoadData(int type, int status, string keyword, int currentpage, int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int numberitem = 0;
                    if (keyword != null) keyword = keyword.ToLower();
                    var username = HttpContext.Current.User.Identity.Name;
                    var listdevice = DeviceInfo.GetListDeviceInTeam(context,username, type, status, keyword, currentpage, numberinpage, ref numberitem);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listdevice, TotalItem = numberitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}