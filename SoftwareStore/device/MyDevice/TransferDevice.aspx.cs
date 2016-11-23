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

namespace SoftwareStore.device.MyDevice
{
    public partial class TransferDevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                if (!DeviceConfig.AllowTransferDevice(context))
                {
                    LinkInfo.RedirectDialogError(Response, ErrorType.NotAllowUserTransferDevice);
                    return;
                }

                var username = HttpContext.Current.User.Identity.Name;
                var user = UserInfo.GetByID(context, username);
                if (user != null)
                {
                    var team = user.Team;
                    //if (team.TeamID == 64)
                    //    if (team.Team1 != null)
                    //        team = team.Team1;

                    var isallowtransferallmember = DataConfigInfo.HasRecord(context, DataConfigEnum.AllowTransferAllMember, user.UserName);
                    if (!isallowtransferallmember)
                        txtUser.DataSource = UserInfo.GetAllByTeam(context, team.TeamID).Where(x => x.UserName != username).Select(x => new { UserName = x.UserName, FullName = x.UserName + "/" + x.FullName + "/" + x.JobTitle.JobName });
                    else
                    {
                        var list = new List<User>();
                        var data = context.Teams.Where(x => x.TeamParent == null);
                        foreach (var item in data)
                        {
                            list.AddRange(UserInfo.GetAllByTeam(context, item.TeamID));
                        }
                        //.SelectMany(x => UserInfo.GetAllByTeam(context, team.TeamID));
                        var data2 = list.Where(x => x.UserName != username).Select(x => new { UserName = x.UserName, FullName = x.UserName + "/" + x.FullName + "/" + x.JobTitle.JobName });
                        txtUser.DataSource = data2;
                    }
                    txtUser.DataValueField = "UserName";
                    txtUser.DataTextField = "FullName";
                    txtUser.DataBind();
                }
                txtTransferDate.Value = DateTime.Now.ToString("MM/dd/yyyy");
            }
        }
        [WebMethod]
        public static string Transfer(int DeviceID, string TransferDate, string UserName)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var keeper = HttpContext.Current.User.Identity.Name;
                    if (DeviceInfo.TransferDevice(context, DeviceID, keeper, UserName, Convert.ToDateTime(TransferDate)))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    else
                        return new JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string TransferMultiple(List<int> ListDeviceID, string TransferDate, string UserName)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var keeper = HttpContext.Current.User.Identity.Name;
                    if (DeviceInfo.TransferDevice(context, ListDeviceID, keeper, UserName, Convert.ToDateTime(TransferDate)))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    else
                        return new JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string CancelTransfer(int DeviceID)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var keeper = HttpContext.Current.User.Identity.Name;
                    if (DeviceInfo.CancelTransferDevice(context, DeviceID, keeper))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    else
                        return new JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string RetrieveDevice(int DeviceID)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var borrower = HttpContext.Current.User.Identity.Name;
                    if (DeviceInfo.RetrieveDevice(context, DeviceID, borrower))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    else
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