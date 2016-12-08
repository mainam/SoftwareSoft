using System;

namespace SoftwareStore
{
    //public partial class Default1 : System.Web.UI.Page
    //{
    //    protected void Page_Load(object sender, EventArgs e)
    //    {
    //        using (var context = new DatabaseDataContext())
    //        {
    //            if (Utils.LocalHost == null)
    //                Utils.LocalHost = "http://" + Request.Url.Host + ":" + Request.Url.Port;

    //            if (!IsPostBack)
    //            {
    //                var username = HttpContext.Current.User.Identity.Name;
    //                User user = null;
    //                if (username != null)
    //                    user = UserInfo.GetByID(context,username);

    //                if (user == null)
    //                {
    //                    Response.Redirect(string.Format("~/Login.aspx?Url={0}", Request.Url));
    //                }
    //                else
    //                {
    //                    var isAdmin = UserInfo.IsAdmin(context,user);

    //                    if (!UserInfo.AllowBorrowDevice(context,user))
    //                    {
    //                        menuBorrowDevice.Visible = false;
    //                        menuListDevice.Visible = false;
    //                        menuInventory.Visible = false;
    //                    }
    //                    else
    //                    {
    //                        menuListDevice2.Visible = false;
    //                    }

    //                    liAdminWebsite.Visible = isAdmin;
    //                    liDeviceManagement.Visible = liInventoryResolve.Visible = (isAdmin || user.UserName == "kim.yen");
    //                    lbUserName.Text = string.Format("{0}", user.FullName);
    //                    lbUserName.ToolTip = string.Format("SingleID: {0}", user.UserName);
    //                    imgAvatar.ImageUrl = UserInfo.GetAvatar(user);
    //                }
    //            }
    //        }
    //    }
    //}
}