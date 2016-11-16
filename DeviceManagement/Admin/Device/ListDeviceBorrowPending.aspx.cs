using DataAccess;
using DataAccess.DeviceFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.Admin.Device
{
    public partial class ListDeviceBorrowPending : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string LoadData(int type, string status, string keyword, int currentpage, int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int totalitem = 0;
                    List<DataApprove> listAllDevice = ApproveInfo.GetListApproval(context, null, type, keyword.ToLower(), currentpage, numberinpage, status, ref totalitem, ApproveInfo.TypeApprove.ApproveBorrow);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listAllDevice, TotalItem = totalitem});
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}