using DataAccess;
using DataAccess.DeviceFolder.InventoryFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.device
{
    public partial class ConfirmDevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string LoadData(int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (username != null)
                    {
                        var data = InventoryInfo.GetInventoryRequest(context, username, numberinpage);
                        return new JavaScriptSerializer().Serialize(new
                        {
                            Status = true,
                            Data = data
                        });
                    }
                    return new JavaScriptSerializer().Serialize(new { Status = false, Data = "[]" });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false, Data = "[]" });
            }
        }
    }
}