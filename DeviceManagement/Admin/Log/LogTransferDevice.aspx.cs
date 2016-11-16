using DataAccess.LogFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.Admin.Log
{
    public partial class LogTransferDevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string LoadData(string keyword, int page, int numberinpage)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                int totalitem = 0;
                var data = LogTransferDeviceInfo.GetAll(username, keyword, page, numberinpage, ref totalitem);
                return new JavaScriptSerializer().Serialize(new { Status = true, TotalItem = totalitem, Data = data.Select(x => new { x.ID, x.IDDevice, Time = x.TransferDate.ToString(), x.IMEI, x.Keeper, x.Borrower, x.Manager, x.Model, x.Serial, x.StatusDevice, x.Tag, x.Type }) });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string Delete(List<int> ListID)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                if (LogTransferDeviceInfo.Delete(ListID, username))
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}