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
    public partial class DeviceManagement : System.Web.UI.Page
    {
        private void Page_Load(object sender, EventArgs e)
        {
            var txtSearch = HttpContext.Current.Session["txtSearch"];
            HttpContext.Current.Session["txtSearch"] = "";
            //if (txtSearch != null)
            //    inputSearch.Value = txtSearch.ToString();
            List<string> a = new List<string>();
            var data = a.FirstOrDefault();
        }


        public static string ListCategoryDevice()
        {
            using (var context = new DatabaseDataContext())
            {
                var listcate = CategoryDeviceInfo.GetAll(context).Select(x => new { ID = x.ID, Name = x.Name });
                return new JavaScriptSerializer().Serialize(listcate);
            }
        }

        public static string ListStatusDevice()
        {
            using (var context = new DatabaseDataContext())
            {
                var listcate = StatusDeviceInfo.GetAll(context).Select(x => new { ID = x.ID, Name = x.Name });
                return new JavaScriptSerializer().Serialize(listcate);
            }
        }


        [WebMethod]
        public static string LoadData(int type, int status, string keyword, int currentpage, int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    string username = HttpContext.Current.User.Identity.Name;
                    int numberitem = 0;
                    if (keyword != null) keyword = keyword.ToLower();
                    var listdevice = DeviceInfo.GetAllDeviceManagement(context,username, type, status, keyword, currentpage, numberinpage, ref numberitem);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listdevice, TotalItem = numberitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }


        [WebMethod]
        public static string LoadStatistic()
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    return DeviceInfo.GetJSONStatistcDevice(context,username);
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

            [WebMethod]
            public static string deleteDevice(int id)
            {
                try
                {
                    using (var context = new DatabaseDataContext())
                    {
                        var username = HttpContext.Current.User.Identity.Name;
                        if (DeviceInfo.DeleteDevice(context,id, username))
                        {
                            return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true });
                        }
                        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
                    }
                }
                catch (Exception)
                {
                    return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
                }
            }

    }
}