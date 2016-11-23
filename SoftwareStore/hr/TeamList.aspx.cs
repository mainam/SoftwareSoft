using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using DataAccess.TeamFolder;
using DataAccess.UserFolder;

namespace SoftwareStore.hr
{

    public partial class TeamList : System.Web.UI.Page
    {

        public string json;

        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                Dictionary<string, object> result = new Dictionary<string, object>();

                string username = HttpContext.Current.User.Identity.Name;
                User user = UserInfo.GetByID(context, username);
                int? permission = user.PermissionId;
                Boolean canEdit = false;
                Boolean support = false;

                result.Add("teams", TeamInfo.getTeamHierarchy(context));

                json = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(result);
            }
        }
    }
}