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
    public partial class DialogConfirmDevices : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var id = Request.QueryString["id"];
                if (id != null)
                {

                }
            }
        }


        [WebMethod]
        public static string LoadListDevice(int id)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (username != null)
                    {
                        var listinventory = InventoryInfo.GetListDeviceInventory(context, id, username);
                        if (listinventory.Count() != 0)
                        {
                            bool HasConfirmAllDevice = true;
                            HasConfirmAllDevice = listinventory.TrueForAll(x => x.ConfirmStatus != 0);
                            var data = listinventory.Select(x => new InventoryUserDeviceInfo()
                            {
                                id = x.id,
                                DeviceName = x.Device.Model,
                                Type = x.Device.DeviceModel.CategoryDevice.Name,
                                Tag = x.Device.Tag,
                                Borrower = x.User.UserName + "/" + x.User.FullName,
                                Keeper = x.User1.UserName + "/" + x.User1.FullName,
                                BorrowDate = x.BorrowDate.HasValue ? x.BorrowDate.Value.ToString("MM/dd/yyyy") : "",
                                IMEI = x.Device.IMEI,
                                Serial = x.Device.Serial,
                                ConfirmStaus = x.ConfirmStatus,
                                Reason = x.Reason
                            });

                            return new JavaScriptSerializer().Serialize(new { Status = true, Data = data, Date = listinventory.First().Inventory.RequestDate.ToString("MM/dd/yyyy"), RequestBy = listinventory.First().Inventory.User.FullName, HasConfirm = HasConfirmAllDevice });
                        }
                    }
                }
                return new JavaScriptSerializer().Serialize(new { Status = false });

            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }


        [WebMethod]
        public static string SaveConfirm(List<InventoryUserDeviceInfo> ListSave)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (username != null)
                    {
                        if (InventoryInfo.Update(context,username, ListSave))
                            return new JavaScriptSerializer().Serialize(new { Status = true });
                        return new JavaScriptSerializer().Serialize(new { Status = false });
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