using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using DataAccess.DeviceFolder;
using System.Web.Script.Serialization;
using DataAccess.UserFolder;

namespace SoftwareStore.device
{
    public partial class ListAllDevice : System.Web.UI.Page
    {
        private void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var username = HttpContext.Current.User.Identity.Name;
                User user = null;
                if (username != null)
                    user = UserInfo.GetByID(context, username);

                if (user == null)
                {
                    Response.Redirect(string.Format("~/Login.aspx?"));
                }

                var txtSearch = HttpContext.Current.Session["txtSearch"];
                HttpContext.Current.Session["txtSearch"] = "";
                if (txtSearch != null)
                    inputSearch.Value = txtSearch.ToString();
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
                    var _listignore = HttpContext.Current.Session["IDBorrow"];
                    var listignore = new List<int>();


                    var username = HttpContext.Current.User.Identity.Name;

                    var listdevice = DeviceInfo.GetAllDeviceAllowBorrow(context,username, type, status, keyword, currentpage, numberinpage, ref numberitem, listignore);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listdevice, TotalItem = numberitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }


        public string GetTypeOnLoad()
        {
            try
            {
                var arrid = HttpContext.Current.Session["type"];
                HttpContext.Current.Session["type"] = "";
                var jsonSerialiser = new JavaScriptSerializer();
                return jsonSerialiser.Serialize(arrid);
            }
            catch (Exception)
            {
                return "";
            }

        }

    }
}