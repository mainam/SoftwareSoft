using DataAccess.DeviceFolder;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
namespace SoftwareStore.device.Management
{
    public partial class SetUserBorrowMultiDevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                txtBorrower.DataSource = UserInfo.GetAll(context).Select(x => new { UserName = x.UserName, FullName = x.UserName + "/" + x.FullName });
                txtBorrower.DataValueField = "UserName";
                txtBorrower.DataTextField = "FullName";
                txtBorrower.DataBind();

                txtBorrowDate.Value = DateTime.Now.ToString("MM/dd/yyyy");
            }
        }


        [WebMethod]
        public static string Update(List<int> ListIDDevice, string username, string date)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var manager = HttpContext.Current.User.Identity.Name;
                    if (DeviceInfo.SetBorrowDevice(context,ListIDDevice, manager, username, date))
                        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true });
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