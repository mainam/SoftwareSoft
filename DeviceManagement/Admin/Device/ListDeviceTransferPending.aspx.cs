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

namespace SoftwareStore.Admin.Device
{
    public partial class ListDeviceTransferPending : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
                    string username = HttpContext.Current.User.Identity.Name;
                    var listdevice = DeviceInfo.GetListDeviceTransferPending(context, username, type, status, keyword, currentpage, numberinpage, ref numberitem);
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