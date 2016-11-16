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

namespace SoftwareStore.device.Confirmation
{
    public partial class MyConfirm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetListRequest(int status, string keyword, int currentpage, int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (username != null)
                    {
                        int numberitem = 0;
                        if (keyword != null) keyword = keyword.ToLower();
                        var newlist = InventoryInfo.GetInventoryRequestForUser(context,username, status, keyword, currentpage, numberinpage, ref numberitem);
                        return new JavaScriptSerializer().Serialize(new
                        {
                            Status = true,
                            Data = newlist.Select(x => new { ID = x.id, Name = x.InventoryName, RequestBy = x.RequestBy + "/" + x.User.FullName, RequestDate = x.RequestDate.ToString("MM/dd/yyyy"), DataDevice = InventoryInfo.GetDataDeviceBorrow(x, username), Status = InventoryInfo.IsFinishConfirm(x, username) }),
                            TotalItem = numberitem
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