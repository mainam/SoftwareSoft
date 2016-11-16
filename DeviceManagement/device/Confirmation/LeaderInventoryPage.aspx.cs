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
    public partial class LeaderInventoryPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string LoadData(int inventoryid, string keywordneedapprove, string keywordhasaccepted, string keywordhasrejected, string keywordnotconfirm)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                var data = InventoryUserDeviceInfo.GetDataLeaderInventory(inventoryid, username, keywordneedapprove, keywordhasaccepted, keywordhasrejected, keywordnotconfirm);
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
        public static string ListLeaderNeedApprove(int inventoryid, string keyword, int type)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                var dataresult = InventoryUserDeviceInfo.ListLeaderNeedApprove(inventoryid, username, keyword.ToLower(), type);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = new { Data = dataresult, TotalItem = dataresult.Count } });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string ListHasAccepted(int inventoryid, string keyword, int type)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                var dataresult = InventoryUserDeviceInfo.ListHasAccepted(inventoryid, username, keyword.ToLower(), type);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = new { Data = dataresult, TotalItem = dataresult.Count } });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string ListHasRejected(int inventoryid, string keyword, int type)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                var dataresult = InventoryUserDeviceInfo.ListHasRejected(inventoryid, username, keyword.ToLower(), type);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = new { Data = dataresult, TotalItem = dataresult.Count } });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }


        [WebMethod]
        public static string ListNotConfirm(int inventoryid, string keyword, int type)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                var dataresult = InventoryUserDeviceInfo.ListNotConfirm(inventoryid, username, keyword.ToLower(), type);
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
                if (InventoryUserDeviceInfo.LeaderConfirm(username, ListConfirm))
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