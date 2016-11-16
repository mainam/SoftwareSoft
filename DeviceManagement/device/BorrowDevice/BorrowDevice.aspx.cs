using DataAccess;
using DataAccess.DataConfigFolder;
using DataAccess.DeviceFolder;
using DataAccess.LinkFolder;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.device.BorrowDevice
{
    public partial class BorrowDevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                if (!DeviceConfig.AllowBorrowDevice(context))
                {
                    LinkInfo.RedirectError(Response, ErrorType.NotAllowBorrowDevice);
                    return;
                }

                var username = HttpContext.Current.User.Identity.Name;
                User user = null;
                if (username != null)
                    user = UserInfo.GetByID(context, username);

                if (user == null || !UserInfo.AllowBorrowDevice(context, user))
                    LinkInfo.RedirectError(Response, ErrorType.NotAcceptUserBorrowDevice);
            }
        }

        public string GetAllDevices()
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var _listignore = HttpContext.Current.Session["IDBorrow"];
                    var listignore = new List<int>();
                    try
                    {
                        if (_listignore != null)
                            listignore = _listignore as List<int>;
                    }
                    catch (Exception)
                    {
                    }
                    var username = HttpContext.Current.User.Identity.Name;
                    List<DataDevice> listAllDevice = DeviceInfo.GetAllDeviceAllowBorrow(context, username, listignore);
                    var jsonSerialiser = new JavaScriptSerializer();
                    return jsonSerialiser.Serialize(listAllDevice);
                }
            }
            catch (Exception)
            {
                return "";
            }

        }

        [WebMethod]
        public static void PostId(List<int> arrid)
        {
            try
            {
                var temp = HttpContext.Current.Session["IDBorrow"];
                List<int> temp1 = temp as List<int>;
                if (temp != null)
                    foreach (int x in temp1)
                    {
                        if (!arrid.Contains(x))
                            arrid.Add(x);
                    }
                HttpContext.Current.Session["IDBorrow"] = arrid;
            }
            catch (Exception)
            {
            }
        }
    }
}