using DataAccess;
using DataAccess.DataConfigFolder;
using DataAccess.SendMailFolder;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.Admin.Mail
{
    public partial class SendMail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (!UserInfo.IsAdmin(context, username))
                    {
                        Response.Redirect("/home/error404.html");
                    }
                    else
                    {
                        var listconfigsendmailfrom = DataConfigInfo.GetDataConfig(context,DataConfigEnum.MailSystem).Select(x=>x.DataValue);
                        cbFrom.DataSource = listconfigsendmailfrom.Select(x => new { Text = x, Value = x.Split('|').Count() > 1 ? x.Split('|')[1].Trim() : x });
                        cbFrom.DataTextField = "Text";
                        cbFrom.DataValueField = "Value";
                        cbFrom.DataBind();

                        var subjectemail = DataConfigInfo.GetDataConfig(context,DataConfigEnum.subjectemail);
                        if (subjectemail.Count() > 0)
                        {
                            txtSubject.Value = subjectemail.First().DataValue;
                        }

                        var listuser = UserInfo.GetAll(context).Where(x => x.Active).Select(x => new { Text = x.FullName + "/" + x.UserName + "/" + x.JobTitle.JobName + "/" + x.Email, Value = x.Email });
                        cbListCC.DataSource = listuser;
                        cbListCC.DataTextField = "Text";
                        cbListCC.DataValueField = "Value";
                        cbListCC.DataBind();

                        cbListTo.DataSource = listuser;
                        cbListTo.DataTextField = "Text";
                        cbListTo.DataValueField = "Value";
                        cbListTo.DataBind();
                    }
                }
            }
            catch (Exception)
            {
                Response.Redirect("/home/error404.html");

            }

        }

        [WebMethod]
        public static string Send(string subject, string from, List<string> to, List<string> cc, string content)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    var user = UserInfo.GetByID(context, username);
                    if (user != null && UserInfo.IsAdmin(context, user))
                    {
                        if (to.Count() == 0 || cc == null)
                            throw new Exception();
                        DataAccess.Helper.SendMail.send(from, to, cc, subject, content);
                        LogSendMailServiceInfo.Insert(context, from, subject, to, cc, content, username, DateTime.Now);

                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    }
                    return new JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string LoadData(string keyword, int page, int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    int totalitem = 0;
                    var data = LogSendMailServiceInfo.GetAll(context, keyword, page, numberinpage, username, ref totalitem);
                    var text = new JavaScriptSerializer().Serialize(new { Status = true, TotalItem = totalitem, Data = data.Select(x => new { x.CC, x.Content, Date = x.Date.ToString(), x.From, x.ID, x.To, x.UserName, x.Subject }) });
                    return text;
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}