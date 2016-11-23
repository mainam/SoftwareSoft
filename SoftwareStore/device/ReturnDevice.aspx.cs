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
    public partial class ReturnDevice : System.Web.UI.Page
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
        public static string LoadData(int type, int status, string keyword, string keyword2, int currentpage, int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int numberitem = 0;
                    if (keyword != null) keyword = keyword.ToLower();
                    if (keyword2 != null) keyword2 = keyword2.ToLower();
                    string username = HttpContext.Current.User.Identity.Name;
                    var listdevice = DeviceInfo.GetListDeviceNeedReturn(context, username, type, status, keyword, keyword2, currentpage, numberinpage, ref numberitem);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listdevice, TotalItem = numberitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string LoadDataByIMEI(string ListIMEI)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int numberitem = 0;
                    string username = HttpContext.Current.User.Identity.Name;
                    var listdevice = DeviceInfo.GetListDeviceNeedReturn(context,username, ListIMEI);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listdevice, TotalItem = listdevice.Count });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }



        [WebMethod]
        public static string GetAllDevicesBorrowing(string username)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var listdevice = DeviceInfo.GetListDeviceBorrowing(context,username);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listdevice });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }

        }

        [WebMethod]
        public static string Return(List<int> arrid)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (DeviceInfo.ReturnDevice(context,arrid, username))
                    {
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    }
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