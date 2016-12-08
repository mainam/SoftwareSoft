using DataAccess;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.hr.Controls
{
    public partial class ctAward : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var _username = Request.QueryString["user"];
                var username = HttpContext.Current.User.Identity.Name;
                User user = null;
                if (_username != null)
                {
                    if (username != _username)
                    {
                        if (!UserInfo.IsAdmin(username))
                            btnAdd.Visible = false;
                    }
                    user = UserInfo.GetByID(context, _username);
                    if (user == null)
                        throw new Exception();
                }
                else
                {
                    user = UserInfo.GetByID(context, username);
                    if (user == null)
                        throw new Exception();
                }
            }
        }
    }
}