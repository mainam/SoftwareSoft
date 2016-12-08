using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using System.Web.Script.Serialization;
using System.Web.Services;
using DataAccess.HRFolder;
using DataAccess.UserFolder;

namespace SoftwareStore.hr
{
    public partial class UserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var currentuser = HttpContext.Current.User.Identity.Name;
                var username = Request.QueryString["user"];
                if (username != null)
                {
                    if (currentuser != username)
                    {
                        if (!UserInfo.IsAdmin(currentuser))
                            Response.Redirect("~/#hr/userprofile.aspx?user=" + currentuser);
                    }
                }
            }
        }

        [WebMethod]
        public static string SavePersonalDetail(User user)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                if (UserInfo.SavePersonalDetail(user, username))
                {
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                }
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string SaveEducation(UserEducation usereducation)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                if (EducationInfo.SaveEducation(username, usereducation))
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string SaveLanguage(UserLanguage userlanguage)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                if (UserLanguageInfo.SaveLanguage(username, userlanguage))
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string SaveCertification(UserCertification usercertification)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                if (UserCertificationInfo.SaveCertification(username, usercertification))
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string SaveAwardReward(AwardReward userawardreward)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                if (UserAwardRewardInfo.SaveAwardReward(username, userawardreward))
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string LoadDataPage(string currentuser)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {


                    var username = HttpContext.Current.User.Identity.Name;
                    if (currentuser == null)
                        currentuser = username;
                    var dataresult = UserInfo.GetUserProfile(context, currentuser);
                    var text = new JavaScriptSerializer().Serialize(new { Status = true, Data = dataresult, AllowEdit = (currentuser == null || currentuser == username || UserInfo.IsAdmin(username)) });
                    return text;
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string LoadListEducation(string username)
        {
            try
            {
                if (username == null)
                    username = HttpContext.Current.User.Identity.Name;
                var dataresult = EducationInfo.GetUserEducation(username);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = dataresult });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string LoadListLanguage(string username)
        {
            try
            {
                if (username == null)
                    username = HttpContext.Current.User.Identity.Name;
                var dataresult = UserLanguageInfo.GetUserLanguage(username);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = dataresult });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string LoadListCertification(string username)
        {
            try
            {
                if (username == null)
                    username = HttpContext.Current.User.Identity.Name;
                var dataresult = UserCertificationInfo.GetUserCertification(username);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = dataresult });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }


        [WebMethod]
        public static string LoadListAward(string username)
        {
            try
            {
                if (username == null)
                    username = HttpContext.Current.User.Identity.Name;
                var dataresult = UserAwardRewardInfo.GetUserAward(username);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = dataresult });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string LoadListReward(string username)
        {
            try
            {
                if (username == null)
                    username = HttpContext.Current.User.Identity.Name;
                var dataresult = UserAwardRewardInfo.GetUserReward(username);
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = dataresult });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string DelEducation(string username, int id)
        {
            try
            {
                var currentusename = HttpContext.Current.User.Identity.Name;
                if (username == null)
                    username = currentusename;
                if (EducationInfo.DelEducation(currentusename, username, id))
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string DelLanguage(string username, int id)
        {
            try
            {
                var currentusename = HttpContext.Current.User.Identity.Name;
                if (username == null)
                    username = currentusename;
                if (UserLanguageInfo.DelLanguage(currentusename, username, id))
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string DelCertification(string username, int id)
        {
            try
            {
                var currentusename = HttpContext.Current.User.Identity.Name;
                if (username == null)
                    username = currentusename;
                if (UserCertificationInfo.DelCertification(currentusename, username, id))
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string DelAwardReward(string username, int id)
        {
            try
            {
                var currentusename = HttpContext.Current.User.Identity.Name;
                if (username == null)
                    username = currentusename;
                if (UserAwardRewardInfo.DelAwardReward(currentusename, username, id))
                    return new JavaScriptSerializer().Serialize(new { Status = true });
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}