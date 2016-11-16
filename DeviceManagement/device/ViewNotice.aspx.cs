using DataAccess;
using DataAccess.DeviceFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.device
{
    public partial class ViewNotice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var noticeid = Request.QueryString["NoticeID"];
            if (noticeid != null)
            {
                using (var context = new DatabaseDataContext())
                {
                    var notice = DeviceNoticeInfo.GetByID(context, int.Parse(noticeid));
                    if (notice != null)
                    {
                        lbTitle.InnerHtml = notice.Title;
                        lbContent.InnerHtml = HttpUtility.HtmlDecode(notice.Content);
                        lbCreatedBy.InnerHtml = notice.User.FullName;
                        lbCreatedDate.InnerHtml = notice.CreateDate.ToString();
                    }
                }
            }
        }
    }
}