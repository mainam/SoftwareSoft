using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.Script.Serialization;
using DataAccess.UserFolder;
using DataAccess.UtilFolder;
using DataAccess.Db.User.UserDb;

namespace SoftwareStore
{
    public partial class Login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new UserDbDataContext())
            {
                if (Utils.LocalHost == null)
                    Utils.LocalHost = "http://" + Request.Url.Host + ":" + Request.Url.Port;

                //divMessageError.Visible = false;
                string text = Request.QueryString["Action"];
                if (text != null)
                {
                    switch (text.ToLower())
                    {
                        case "logout":
                            FormsAuthentication.SignOut();
                            return;
                        default:
                            break;
                    }
                }

                var username = HttpContext.Current.User.Identity.Name;
                DataAccess.Db.User.UserDb.tbUser user = UserInfo._GetByID(context, username);
                if (user != null)
                {
                    Response.Redirect("~/Default.aspx");
                }
            }
        }
        [System.Web.Services.WebMethod]
        public static string LoginAccount(string username, string pass)
        {
            using (var context = new UserDbDataContext())
            {
                DataAccess.Db.User.UserDb.tbUser user;
                if ((user = UserInfo._GetByIDPW(context, username, pass)) != null)
                {
                    UserInfo.SetCookies(username, HttpContext.Current.Response);
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                }
                else
                {
                    return new JavaScriptSerializer().Serialize(new { Status = false, Message = "User name or password is not correct!" });
                }
            }
        }


        //protected void Page_Load(object sender, EventArgs e)
        //{
        //    divMessageError.Visible = false;
        //    string text = Request.QueryString["Action"];
        //    if (text != null)
        //    {
        //        switch (text.ToLower())
        //        {
        //            case "logout":
        //                FormsAuthentication.SignOut();
        //                txtType.Value = "logout";
        //                return;
        //            default:
        //                break;
        //        }
        //    }

        //    var username = HttpContext.Current.User.Identity.Name;
        //    User user = null;
        //    if (username != null)
        //    {
        //        user = UserInfo.GetByID(username);
        //        if (user != null)
        //        {
        //            Response.Redirect("~/Default.aspx");
        //        }
        //        else
        //        {
        //            if (this.Request.QueryString.Count != 0)
        //            {
        //                string query = Request.QueryString["Action"];
        //                if (query.ToLower() == "loginsingle")
        //                    btnLoginMySingle_Click(null, null);
        //            }
        //            else
        //                try
        //                {
        //                    var browse = Request.Browser.Browser;
        //                    if (browse.ToLower().Contains("ie") || browse.ToLower().Contains("internet"))
        //                    {
        //                        string temp = Request.Form["totaldatalogin"];
        //                        if (temp != null)
        //                        {
        //                            var dic = SSO.GetSSOInfo(temp);
        //                            try
        //                            {
        //                                var loginfo = dic[SSO.EnumSSO.EP_LOGINID.ToString()];
        //                                if (loginfo != null)
        //                                {
        //                                    var user1 = UserInfo.GetByID(loginfo);

        //                                    if (user1 != null)
        //                                    {
        //                                        Log log = new Log()
        //                                        {
        //                                            UserName = user1.UserName,
        //                                            Time = DateTime.Now,
        //                                            IP = Request.UserHostAddress,
        //                                            Status = "Success"
        //                                        };
        //                                        LogInfo.Insert(log);
        //                                        UserInfo.SetCookies(user1.UserName, HttpContext.Current.Response);
        //                                        Response.Redirect("~/Default.aspx");
        //                                    }
        //                                }
        //                            }
        //                            catch (Exception)
        //                            {

        //                            }
        //                        }
        //                    }

        //                }
        //                catch (Exception)
        //                {
        //                    Response.Redirect(string.Format("~/Login.aspx?"));
        //                }
        //        }
        //    }
        //}


        //public void btnLoginMySingle_Click(object sender, EventArgs e)
        //{
        //    try
        //    {
        //        var browse = Request.Browser.Browser;
        //        if (browse.ToLower().Contains("ie") || browse.ToLower().Contains("internet"))
        //        {
        //            string text = Request.Form["totaldatalogin"];
        //            if (text != null || text.Trim() != "")
        //            {
        //                try
        //                {
        //                    var dic = SSO.GetSSOInfo(text);
        //                    if (dic.Count == 0)
        //                    {
        //                        txtMessageError.Text = "Please login mySingle and try again";
        //                        divMessageError.Visible = true;
        //                    }
        //                    var loginfo = dic[SSO.EnumSSO.EP_LOGINID.ToString()];
        //                    if (loginfo == null)
        //                    {
        //                        txtMessageError.Text = "Please login mySingle and try again";
        //                        divMessageError.Visible = true;
        //                    }
        //                    else
        //                    {
        //                        var user = UserInfo.GetByID(loginfo);
        //                        if (user != null)
        //                        {
        //                            Log log = new Log()
        //                            {
        //                                UserName = user.UserName.Trim(),
        //                                Time = DateTime.Now,
        //                                IP = Request.UserHostAddress,
        //                                Status = "Success"
        //                            };
        //                            LogInfo.Insert(log);
        //                            UserInfo.SetCookies(user.UserName, HttpContext.Current.Response);
        //                            // X.Msg.Alert("Alert", "Please login mySingle and try again").Show();
        //                            //FormsAuthentication.RedirectFromLoginPage(user.UserName, true);
        //                            string url = Request.QueryString["Url"];
        //                            if (url != null)
        //                            {
        //                                url = HttpUtility.UrlDecode(url);
        //                                Response.Redirect(url);
        //                            }
        //                            else
        //                                Response.Redirect("~/Default.aspx");
        //                        }
        //                    }
        //                }
        //                catch (Exception ex)
        //                {
        //                }
        //            }
        //            else
        //            {
        //                txtMessageError.Text = "Please login mySingle and try again";
        //                divMessageError.Visible = true;
        //            }
        //        }
        //        else
        //        {
        //            txtMessageError.Text = "Use IE browser to login with mySingle";
        //            divMessageError.Visible = true;
        //        }
        //    }
        //    catch (Exception)
        //    {
        //        txtMessageError.Text = "Please login mySingle and try again";
        //        divMessageError.Visible = true;
        //    }
        //}


        //protected void btnLogin_Click(object sender, EventArgs e)
        //{
        //    User user;
        //    if ((user = UserInfo.GetByIDPW(txtUserName.Text.ToString(), txtPassword.Text.ToString(), true)) != null)
        //    {
        //        UserInfo.SetCookies(txtUserName.Text, HttpContext.Current.Response);
        //        Log log = new Log()
        //        {
        //            UserName = txtUserName.Text.ToString().Trim(),
        //            Time = DateTime.Now,
        //            IP = Request.UserHostAddress,
        //            Status = "Success"

        //        };
        //        LogInfo.Insert(log);

        //        string url = Request.QueryString["Url"];
        //        if (url != null)
        //        {
        //            url = HttpUtility.UrlDecode(url);
        //            Response.Redirect(url);
        //        }
        //        else
        //            Response.Redirect("~/Default.aspx");
        //    }
        //    else
        //    {

        //        Log log = new Log()
        //        {
        //            UserName = txtUserName.Text.ToString().Trim(),
        //            Time = DateTime.Now,
        //            IP = Request.UserHostAddress,
        //            Status = "Fail"

        //        };
        //        LogInfo.Insert(log);
        //        txtMessageError.Text = "UserName or Password is incorrect";
        //        divMessageError.Visible = true;
        //    }
        //}
    }
}