using DataAccess;
using DataAccess.DataConfigFolder;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.Admin.Device.Dialog
{
    public partial class AddUserAllowTransferAllMember : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var list = DataConfigInfo.GetDataConfig(context, DataConfigEnum.AllowTransferAllMember).Select(x => x.DataValue);

                var listuser = context.Users.Where(x => x.Active && !list.Contains(x.UserName)).Select(x => new { FullName = x.FullName + " (" + x.UserName + " " + x.JobTitle.JobName + ")", x.UserName });
                cbListMember.DataSource = listuser;
                cbListMember.DataTextField = "FullName";
                cbListMember.DataValueField = "UserName";
                cbListMember.DataBind();
            }

        }

        [WebMethod]
        public static String AddNewMemberAllowTransferAllMember(List<string> listuser)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var listold = DataConfigInfo.GetDataConfig(context, DataConfigEnum.AllowTransferAllMember).Select(x => x.DataValue);
                    var listnew = listuser.Except(listold);
                    context.DataConfigs.InsertAllOnSubmit(listnew.Select(x => new DataConfig() { DataKey = DataConfigEnum.AllowTransferAllMember.ToString(), ApplyDate = DateTime.Now, DataValue = x }));
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