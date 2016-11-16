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

namespace SoftwareStore.device
{
    public partial class InventoryConfirm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string InventoryID()
        {
            try
            {
                return Request.QueryString["InventoryID"];
            }
            catch (Exception)
            {
                return "";
            }
        }

        [WebMethod]
        public static string LoadData(int inventoryid, int type, int status, string keyword, int currentpage, int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int numberitem = 0;
                    if (keyword != null) keyword = keyword.ToLower();
                    var listinventory = InventoryInfo.GetListDeviceInventory(context,inventoryid, keyword.ToLower(), type, status, currentpage, numberinpage, ref numberitem);
                    var dataresult = listinventory.Select(x => new
                    {
                        id = x.id,
                        Model = x.Device.Model,
                        Type = x.Device.DeviceModel.CategoryDevice.Name,
                        Tag = x.Device.Tag,
                        Serial = x.Device.Serial,
                        IMEI = x.Device.IMEI,
                        Manager = x.Device.Manager + "/" + x.Device.User.FullName,
                        Borrower = x.Borrower + "/" + x.User.FullName,
                        BorrowDate = x.BorrowDate.HasValue ? x.BorrowDate.Value.ToString("MM/dd/yyyy") : "",
                        Status = InventoryInfo.GetStatus(x),
                        Reason = x.Reason

                    });
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = dataresult, TotalItem = numberitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string GetAllInventoryConfirm(int inventoryid)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var listinventory = InventoryInfo.GetListDeviceInventory(context,inventoryid);
                    var dataresult = listinventory.Select(x => new
                    {
                        id = x.id,
                        Model = x.Device.Model,
                        Type = x.Device.DeviceModel.CategoryDevice.Name,
                        Tag = x.Device.Tag,
                        Serial = x.Device.Serial,
                        IMEI = x.Device.IMEI,
                        Manager = x.Device.Manager + "/" + x.Device.User.FullName,
                        Borrower = x.Borrower + "/" + x.User1.FullName,
                        BorrowDate = x.BorrowDate.HasValue ? x.BorrowDate.Value.ToString("MM/dd/yyyy") : "",
                        Status = InventoryInfo.GetStatus(x),
                        Reason = x.Reason

                    });
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = dataresult });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}