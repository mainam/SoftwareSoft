using DataAccess;
using DataAccess.DataConfigFolder;
using DataAccess.DeviceFolder;
using DataAccess.LinkFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.device.MyApprove
{
    public partial class ApproveGroupByModel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                if (!DeviceConfig.AllowApprovalDevice(context))
                {
                    LinkInfo.RedirectError(Response, ErrorType.NotAllowApprovalDevice);
                    return;
                }
            }
        }

        [WebMethod]
        public static string GetAllApproval(int type, string keyword, int currentpage, int numberinpage, string status, ApproveInfo.TypeApprove typeapprove)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    int totalitem = 0;
                    var data = ApproveInfo.GetListApproval2(context,username, type, keyword, currentpage, numberinpage, ref totalitem, ApproveInfo.TypeApprove.ApproveBorrow);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = data, TotalItem = totalitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

    }
}