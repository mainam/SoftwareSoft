using DataAccess;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = Request.QueryString["username"];
                    var token = Request.QueryString["token"];
                    if (UserInfo.ResetPassword(context,username, token, "abc13579"))
                    {
                        lbResponse.InnerText = "Reset password successful. New password has send to your email.";
                    }
                    else
                    {
                        lbResponse.InnerText = "Tokenkey or user not exist. Please check again";
                    }
                }
            }
            catch (Exception)
            {
                lbResponse.InnerText = "This link has removed.";
            }
        }
    }
}