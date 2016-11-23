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

namespace SoftwareStore.device.Common
{
    public partial class ModelManagement : System.Web.UI.Page
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
                else
                {
                    cbCategory.DataSource = CategoryDeviceInfo.GetAll(context);
                    cbCategory.DataTextField = "Name";
                    cbCategory.DataValueField = "ID";
                    cbCategory.DataBind();
                }
            }
        }
        [WebMethod]
        public static string LoadData(string keyword, int numberinpage, int currentpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int totalitem = 0;
                    var listtake = DeviceModelInfo.GetDataModel(context,keyword.ToLower(), currentpage, numberinpage, ref totalitem);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listtake, TotalItem = totalitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string Delete(string modelname)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    //check permission;
                    if (UserInfo.IsAdmin(context, username) && DeviceModelInfo.Delete(context,modelname))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    return new JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string Save(string oldmodelname, string newmodelname, string company, int category)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    //check permission;
                    if (UserInfo.IsAdmin(context,username) && DeviceModelInfo.Save(context,oldmodelname, newmodelname, company, category))
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