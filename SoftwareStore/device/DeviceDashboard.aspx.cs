using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using System.Web.Script.Serialization;
using System.Web.Services;
using DataAccess.DeviceFolder;

namespace SoftwareStore.device
{
    public partial class DeviceDashboard : System.Web.UI.Page
    {
        private void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (var context = new DatabaseDataContext())
                {
                    var listdevice = DeviceInfo.ListDeviceHasBorrow(context).GroupBy(x => x.Borrower).OrderByDescending(x => x.Count()).Select(x => new { User = x.First().User3, Count = x.Count() });
                    repTopBorrow.DataSource = listdevice.Take(9);
                    repTopBorrow.DataBind();
                    mesTopBorrow.Visible = listdevice.Count() == 0;

                    var listdevice2 = DeviceInfo.ListDeviceReturnToday(context);
                    RepReturnInDate.DataSource = listdevice2;
                    RepReturnInDate.DataBind();
                    mesReturnToday.Visible = listdevice2.Count == 0;
                }
            }
        }


        [WebMethod]
        public static string DeleteNotice(int IDNotice)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (DeviceNoticeInfo.Delete(context,username, IDNotice))
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
        public static string LoadDataNotice(string keyword, int currentpage, int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    int numberitem = 0;
                    if (keyword != null) keyword = keyword.ToLower();
                    var listdevice = DeviceNoticeInfo.GetAll(context,keyword, currentpage, numberinpage, ref numberitem);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listdevice.Select(x => new { x.ID, x.Title, x.User.UserName, x.User.FullName, Content = HttpUtility.HtmlDecode(x.Content), CreateDate = x.CreateDate.ToString(), AlowEdit = username == x.CreateBy }), TotalItem = numberitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string LoadStatistic()
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    return DeviceInfo.GetJSONStatistcDevice(context);
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}