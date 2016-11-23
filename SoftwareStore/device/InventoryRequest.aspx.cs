using DataAccess;
using DataAccess.DeviceFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.Script.Serialization;
using System.Web.UI.WebControls;
using System.Data;
using DataAccess.DeviceFolder.InventoryFolder;

namespace SoftwareStore.device
{
    public partial class InventoryRequest : System.Web.UI.Page
    {

        public static string json;

        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var username = HttpContext.Current.User.Identity.Name;
                if (username != null)
                {
                    Dictionary<string, Object> result = new Dictionary<string, object>();

                    result.Add("models", DeviceModelInfo.getAllModelNames(context,username));

                    json = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(result);
                }
            }
        }


        [WebMethod]
        public static string LoadData(string keyword, int currentpage, int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int numberitem = 0;
                    if (keyword != null) keyword = keyword.ToLower();
                    var username = HttpContext.Current.User.Identity.Name;
                    var listinventory = InventoryInfo.GetListRequest(context,username, keyword.ToLower(), currentpage, numberinpage, ref numberitem);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listinventory, TotalItem = numberitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }



        [WebMethod]
        public static string CreateNewRequest(string InventoryName, string RequestDate, List<string> models)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var date = Convert.ToDateTime(RequestDate);
                    var username = HttpContext.Current.User.Identity.Name;
                    if (InventoryInfo.AddNewInventory(context,username, date, InventoryName, models))
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
        public static string LoadStatistic()
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {

                    var username = HttpContext.Current.User.Identity.Name;
                    int numberitem = 0;
                    var listRequest = InventoryInfo.GetListRequest(context,username, "", 1, 5, ref numberitem).OrderBy(x => x.RequestDate);
                    var ticksValue = listRequest.Select(x => x.InventoryName).ToList();
                    var NotBorrow = listRequest.Select(x => x.NotBorrow).ToList();
                    var Loss = listRequest.Select(x => x.Loss).ToList();
                    var Broken = listRequest.Select(x => x.Broken).ToList();
                    var Good = listRequest.Select(x => x.Good).ToList();
                    return new JavaScriptSerializer().Serialize(new { Status = true, ticksValue = ticksValue, NotBorrow = NotBorrow, Loss = Loss, Broken = Broken, Good = Good });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }

        }

        [WebMethod]
        public static string DeleteInventory(int inventoryid)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (InventoryInfo.Delete(context,inventoryid, username))
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