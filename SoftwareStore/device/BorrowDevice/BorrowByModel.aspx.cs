using DataAccess;
using DataAccess.DataConfigFolder;
using DataAccess.DeviceFolder;
using DataAccess.LinkFolder;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.device.BorrowDevice
{
    public partial class BorrowByModel : System.Web.UI.Page
    {
        private void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                if (!DeviceConfig.AllowBorrowDevice(context))
                {
                    LinkInfo.RedirectError(Response, ErrorType.NotAllowBorrowDevice);
                    return;
                }

                var username = HttpContext.Current.User.Identity.Name;
                User user = null;
                if (username != null)
                    user = UserInfo.GetByID(context, username);

                if (user == null)
                {
                    Response.Redirect(string.Format("~/Login.aspx?"));
                }
                else
                {
                    if (!UserInfo.AllowBorrowDevice(context,user))
                        LinkInfo.RedirectError(Response, ErrorType.NotAcceptUserBorrowDevice);
                }


                txtStartDate.Value = DateTime.Now.ToString("MM/dd/yyyy");
                txtEndDate.Value = DateTime.Now.ToString("MM/dd/yyyy");
            }
        }

        [WebMethod]
        public static string GetListModelAvailable(string keyword, int currentpage, int numberinpage, int type)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int totalitem = 0;
                    var username = HttpContext.Current.User.Identity.Name;
                    var listmodel = DeviceInfo.GetListDataModelDevice(context, ref totalitem, keyword, numberinpage, currentpage, type, username);

                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listmodel, TotalItem = totalitem });
                }
            }
            catch (Exception)
            {

                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }


        [WebMethod]
        public static string Borrow(string StartDate, string Reason, string EndDate, int NumberDevice, string ModelID, string Manager)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int index = 0;
                    if ((index = Manager.IndexOf("/")) != -1)
                        Manager = Manager.Substring(0, index);
                    var username = HttpContext.Current.User.Identity.Name;
                    if (ApproveInfo.AddNewApproval(context,NumberDevice, ModelID, Manager, username, Convert.ToDateTime(StartDate), Convert.ToDateTime(EndDate), Reason, ApproveInfo.TypeApprove.ApproveBorrow))
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