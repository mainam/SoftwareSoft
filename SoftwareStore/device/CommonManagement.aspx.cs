using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using DataAccess.UserFolder;

namespace SoftwareStore.device
{
    public partial class CommonManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var username = HttpContext.Current.User.Identity.Name;
                User user = null;
                if (username != null)
                    user = UserInfo.GetByID(context, username);

                if (!UserInfo.IsAdmin(context,user))
                {
                    Response.Redirect("~/home/error404.html");
                }
            }
        }
    }
}