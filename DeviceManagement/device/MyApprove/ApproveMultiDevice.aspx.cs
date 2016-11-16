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

namespace SoftwareStore.device.MyApprove
{
    public partial class ApproveMultiDevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var modelid = Request.QueryString["ModelID"];

                    if (modelid != null)
                    {
                        modelid = HttpUtility.HtmlDecode(modelid);
                        var username = HttpContext.Current.User.Identity.Name;
                        var list = ApproveInfo.GetInformationSameModel(context,username, modelid, 0);
                        chSelectTag.DataSource = list;
                        chSelectTag.DataValueField = "IDDevice";
                        chSelectTag.DataTextField = "Tag";
                        chSelectTag.DataBind();
                    }
                }
            }
            catch (Exception)
            {

            }
        }

        [WebMethod]
        public static string Approve(string username, string model, int countdevice, List<int> listselected)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var approver = HttpContext.Current.User.Identity.Name;
                    if (ApproveInfo.Approve(context,approver, username, model, countdevice, listselected))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    else
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