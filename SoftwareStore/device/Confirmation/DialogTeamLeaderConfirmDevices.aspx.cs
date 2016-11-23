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
    public partial class DialogTeamLeaderConfirmDevices : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
                        var listinventory = InventoryInfo.GetListDeviceInventoryByTeam(context,id, username);

                        var listuserinventory = listinventory.GroupBy(x => x.Borrower);

                        if (listuserinventory.Count() != 0)
                        {
                            var listresult = new List<object>();
                            foreach (var item in listuserinventory)
                            {
                                var data = item.Select(x => new InventoryUserDeviceInfo()
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
                                    Reason = x.Reason,
                                    LeaderReason = x.LeaderReasonReject,
                                    LeaderConfirmStatus = x.LeaderConfirmStatus
                                });
                                var user = item.First().User;
                                listresult.Add(new { username = user.UserName, fullname = user.FullName, TotalDevice = item.Count(), HasConfirmAllDevice = item.Count(x => x.ConfirmStatus == 0) == 0, DataInventory = data });
                            }

                            return new JavaScriptSerializer().Serialize(new { Status = true, Data = listresult, Date = listinventory.First().Inventory.RequestDate.ToString("MM/dd/yyyy"), RequestBy = listinventory.First().Inventory.User.FullName });
                        }
                    }
                    return new JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string AcceptConfirm(int dataid)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (InventoryInfo.AcceptConfirm(context,dataid, username))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    return new JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        public static string RejectConfirm(int dataid, string reason)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (InventoryInfo.RejectConfirm(context,dataid, reason, username))
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