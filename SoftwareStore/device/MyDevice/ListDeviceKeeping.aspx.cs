using DataAccess;
using DataAccess.DeviceFolder;
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
    public partial class ListDeviceKeeping : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var username = HttpContext.Current.User.Identity.Name;
                var user = UserInfo.GetByID(context, username);
                if (user != null)
                {
                    var team = user.Team;
                    if (team.TeamID == 64)
                        if (team.Team1 != null)
                            team = team.Team1;
                    //txtUser.DataSource = UserInfo.GetAllByTeam(team.TeamID).Where(x => x.UserName != username).Select(x => new { UserName = x.UserName, FullName = x.UserName + "/" + x.FullName });
                    //txtUser.DataValueField = "UserName";
                    //txtUser.DataTextField = "FullName";
                    //txtUser.DataBind();
                }
            }
        }


        [WebMethod]
        public static string LoadData(int type, int status, string keyword, int currentpage, int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int numberitem = 0;
                    if (keyword != null) keyword = keyword.ToLower();
                    string username = HttpContext.Current.User.Identity.Name;
                    var listdevice = DeviceInfo.GetListDeviceKeeping(context,username, type, status, keyword, currentpage, numberinpage, ref numberitem);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listdevice, TotalItem = numberitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}