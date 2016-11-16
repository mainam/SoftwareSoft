using DataAccess.NotificationFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.AJAXProcess
{
    public partial class Notification : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetNotification()
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                var listnotification = NotificationInfo.GetByUserName(username);
                int total = listnotification.Count();

                return new JavaScriptSerializer().Serialize(new
                {
                    Count = total,
                    Status = true,
                    Data = listnotification.Select(x => new { x.Content, Date = x.Date.ToString("dd/MM/yyyy hh:mm:ss tt"), x.Link, x.ID })
                });

            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}