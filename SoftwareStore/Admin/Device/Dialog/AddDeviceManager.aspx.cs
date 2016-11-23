using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DataAccess;
using DataAccess.UtilFolder;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace SoftwareStore.Admin.Device.Dialog
{
    public partial class AddDeviceManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var listuser = context.Users.Where(x => x.Active && x.DeviceManager == null).Select(x => new { FullName = x.FullName + " (" + x.UserName + " " + x.JobTitle.JobName + ")", x.UserName });
                cbListMember.DataSource = listuser;
                cbListMember.DataTextField = "FullName";
                cbListMember.DataValueField = "UserName";
                cbListMember.DataBind();
            }
        }

        [WebMethod]
        public static String AddNewDeviceManager(List<string> listuser)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var listmanager = context.DeviceManagers.Select(x => x.UserName);
                    var listnew = listuser.Except(listmanager);
                    context.DeviceManagers.InsertAllOnSubmit(listnew.Select(x => new DeviceManager() { UserName = x, ApplyDate = DateTime.Now }));
                    context.SubmitChanges();
                    return Converts.Serialize(new { Status = true });
                }
            }
            catch (Exception)
            {
                return Converts.Serialize(new { Status = false });
            }
        }
    }
}