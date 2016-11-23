using DataAccess;
using DataAccess.DeviceFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.device.AjaxProcess
{
    public partial class ListDevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var type = Request.QueryString["Type"];
                switch (type)
                {
                    case "getdeviceselected":
                        var arrid = HttpContext.Current.Session["IDBorrow"] as List<int>;
                        var listdevice = DeviceInfo.GetByID(context,arrid);
                        content.InnerHtml = new JavaScriptSerializer().Serialize(listdevice);
                        break;
                    default:
                        content.InnerHtml = "[]";
                        break;
                }
            }
        }
    }
}