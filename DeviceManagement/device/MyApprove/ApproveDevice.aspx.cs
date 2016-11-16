using DataAccess;
using DataAccess.DataConfigFolder;
using DataAccess.DeviceFolder;
using DataAccess.LinkFolder;
using DataAccess.UtilFolder;
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
    public partial class ApproveDevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {

                    if (!DeviceConfig.AllowApprovalDevice(context))
                    {
                        LinkInfo.RedirectError(Response, ErrorType.NotAllowApprovalDevice);
                        return;
                    }
                    var modelid = Request.QueryString["ModelID"];

                    var deviceid = Request.QueryString["DeviceID"];
                    if (modelid != null)
                    {
                        var username = HttpContext.Current.User.Identity.Name;
                        var list = ApproveInfo.GetInformationSameModel(context, username, modelid, Converts.ToInt(deviceid, 0));
                        chSelectTag.DataSource = list;
                        chSelectTag.DataValueField = "IDDevice";
                        chSelectTag.DataTextField = "Tag";
                        chSelectTag.DataBind();
                        chSelectTag.Value = deviceid;
                    }
                }
            }
            catch (Exception)
            {

            }
        }


        [WebMethod]
        public static string Approve(int IDApprove, int IDDevice, int NewIDDevice)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (ApproveInfo.Approve(context, IDApprove, IDDevice, NewIDDevice, username))
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