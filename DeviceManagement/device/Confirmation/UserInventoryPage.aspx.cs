using DataAccess;
using DataAccess.DeviceFolder.InventoryFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.device.Confirmation
{
    public partial class UserInventoryPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string LoadData(int inventoryid, string keywordneedconfirm, string keywordhasconfirmed, string keywordlistaccept, string keywordlistreject)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;

                var data = InventoryUserDeviceInfo.GetDataUserInventory(inventoryid, username, keywordneedconfirm, keywordhasconfirmed, keywordlistaccept, keywordlistreject);
                if (data != null)
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = data });
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string ListUserNeedConfirm(int inventoryid, string keyword, int type)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                var dataresult = InventoryUserDeviceInfo.ListUserNeedConfirm(inventoryid, username, keyword.ToLower(), type);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = new { Data = dataresult, TotalItem = dataresult.Count } });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string ListHasConfirmed(int inventoryid, string keyword, int type)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                var dataresult = InventoryUserDeviceInfo.ListHasConfirmed(inventoryid, username, keyword.ToLower(), type);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = new { Data = dataresult, TotalItem = dataresult.Count } });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string ListLeaderAccept(int inventoryid, string keyword, int type)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                var dataresult = InventoryUserDeviceInfo.ListLeaderAccept(inventoryid, username, keyword.ToLower(), type);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = new { Data = dataresult, TotalItem = dataresult.Count } });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }


        [WebMethod]
        public static string ListLeaderReject(int inventoryid, string keyword, int type)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                var dataresult = InventoryUserDeviceInfo.ListLeaderReject(inventoryid, username, keyword.ToLower(), type);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = new { Data = dataresult, TotalItem = dataresult.Count } });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string Submit(List<InventoryUserDeviceInfo> ListConfirm)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                if (InventoryUserDeviceInfo.UserConfirm(username, ListConfirm))
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