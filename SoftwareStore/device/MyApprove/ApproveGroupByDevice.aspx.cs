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
    public partial class ApproveGroupByDevice : System.Web.UI.Page
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
                    List<DataApprove> listAllDevice = ApproveInfo.GetListApproval(context, username, type, keyword.ToLower(), currentpage, numberinpage, status, ref totalitem, ApproveInfo.TypeApprove.ApproveBorrow);
                    var allowapproval = new List<int>();
                    var allowremove = new List<int>();
                    ApproveInfo.GetActionApproval(context, username, listAllDevice, ref allowapproval, ref allowremove, ApproveInfo.TypeApprove.ApproveBorrow);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listAllDevice, TotalItem = totalitem, AllowRemove = allowremove, AllowApproval = allowapproval });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }


        [WebMethod]
        public static string Approval(int[] arrid)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (ApproveInfo.Approve(context, arrid, username, ApproveInfo.TypeApprove.ApproveBorrow))
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
        public static string Reject(int[] arrid)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (ApproveInfo.Reject(context, arrid, username, ApproveInfo.TypeApprove.ApproveBorrow))
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
        public static string Delete(List<int> arrid)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (ApproveInfo.DeleteApprove(context, arrid, username, ApproveInfo.TypeApprove.ApproveBorrow))
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