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

namespace SoftwareStore.device
{
    public partial class Request : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetMyRequest(string keyword, int type, int currentpage, int numberinpage, string status)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    int totalitem = 0;
                    List<int> AllowCancel = new List<int>();
                    List<int> AllowRemove = new List<int>();

                    List<DataApprove> myList = ApproveInfo.GetListRequest(context,username, type, keyword.ToLower(), currentpage, numberinpage, status, ref totalitem, ref AllowCancel, ref AllowRemove, ApproveInfo.TypeApprove.ApproveBorrow);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = myList, TotalItem = totalitem, AllowCancel = AllowCancel, AllowRemove = AllowRemove });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string Cancel(List<int> arrid)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (ApproveInfo.CancelApproval(context,arrid, username, ApproveInfo.TypeApprove.ApproveBorrow))
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
                    if (ApproveInfo.DeleteApprove(context,arrid, username, ApproveInfo.TypeApprove.ApproveBorrow))
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