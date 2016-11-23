using DataAccess;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.account
{
    public partial class dialogChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string ChangePassword(string currentpassword, string newpassword)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (username == "")
                        return new JavaScriptSerializer().Serialize(new { Status = false, Cause = "Please login to system to change password" });
                    string Cause = "";
                    if (UserInfo.ChangePassword(context, username, currentpassword, newpassword, ref Cause))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    else
                        return new JavaScriptSerializer().Serialize(new { Status = false, Cause = Cause });
                }
            }
            catch (Exception)
            {

                return new JavaScriptSerializer().Serialize(new { Status = false, Cause = "Sorry an unexpected error occurred . please reload the page and try again" });
            }
        }
    }
}