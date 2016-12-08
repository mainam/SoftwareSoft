using DataAccess.Db.User.UserDb;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Security;

namespace DataAccess.UserFolder
{

    public class UserInfo
    {

        public static Db.User.UserDb.tbUser _GetByIDPW(UserDbDataContext context, object id, string password)
        {
            try
            {
                var pasmd5 = Utils.Encryption(password);
                var user = _GetByID(context, id);
                if (!user.Active)
                    return null;
                return user.Password.Equals(pasmd5) ? user : null;
            }
            catch (Exception)
            {
                return null;
            }
        }

        public static tbUser GetById(string id)
        {
            using (var context = new UserDbDataContext())
            {
                return context.tbUsers.SingleOrDefault(x => x.UserName.Equals(id));
            }
        }

        public static object getAll(String userName, int type, int currentpage, int numberinpage, string keyword, ref int totalItem)
        {
            using (var context = new UserDbDataContext())
            {
                var currentUser = context.tbUsers.SingleOrDefault(x => x.UserName.Equals(userName));
                if (currentUser == null || currentUser.TypeUser != 1)
                    throw new Exception("Bạn không có quyền thực hiện tao tác này");
                var list = context.tbUsers.Where(x => type == 0 || x.TypeUser == type).ToList();
                if (!String.IsNullOrWhiteSpace(keyword))
                {
                    keyword = keyword.ToLower().Trim();
                    list = list.Where(x => x.FullName.ToLower().Contains(keyword)).ToList();
                }
                totalItem = list.Count();
                return list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).Select(x => new { x.UserName, x.FullName, x.Email, x.Active, x.Money, x.TypeUser, x.Phone });
            }
        }

        public static tbUser ActiveMember(string userName, string id)
        {
            using (var context = new UserDbDataContext())
            {
                var currentUser = context.tbUsers.SingleOrDefault(x => x.UserName.Equals(userName));
                if (currentUser == null || currentUser.TypeUser != 1 || !currentUser.Active)
                    throw new Exception("Bạn không có quyền thực hiện tao tác này");
                var user = context.tbUsers.SingleOrDefault(x => x.UserName.Equals(id));
                if (user == null)
                    throw new Exception("Tài khoản này không tồn tại");
                user.Active = !user.Active;
                context.SubmitChanges();
                return user;
            }
        }

        public static Db.User.UserDb.tbUser _GetByID(UserDbDataContext context, object id)
        {
            try
            {
                return context.tbUsers.Single(x => x.UserName.Equals(id.ToString()));
            }
            catch (Exception)
            {
                return null;
            }
        }

        public static object DeteteUser(string name, List<String> arrid)
        {
            using (var context = new UserDbDataContext())
            {
                var user = context.tbUsers.FirstOrDefault(x => x.UserName.Equals(name));
                if (user == null || user.TypeUser != 1 || !user.Active)
                    throw new Exception("Bạn không có quyền thực hiện chức năng này");


                foreach (String id in arrid)
                {
                    if (id.Equals(name))
                        throw new Exception("Bạn không thể tự xóa chính tài khoản của bạn");

                    var _user = context.tbUsers.SingleOrDefault(x => x.UserName == id);
                    if (_user != null)
                    {
                        if (_user.UserName == "admin")
                            throw new Exception("Không thể xóa tài khoản này");
                        context.tbUsers.DeleteOnSubmit(_user);
                    }
                    else
                    {
                        throw new Exception("Tài khoản không tồn tại. Vui lòng refresh lại trang");
                    }
                }
                context.SubmitChanges();
                return true;
            }

        }

        public static void CreateNew(String name, bool isedit, int type, string username, string fullname, string password, string email, string phonenumber, bool active)
        {
            using (var context = new UserDbDataContext())
            {
                var user = context.tbUsers.FirstOrDefault(x => x.UserName.Equals(name));
                if (user == null || user.TypeUser != 1 || !user.Active)
                    throw new Exception("Bạn không có quyền thực hiện chức năng này");
                if (!isedit)
                {
                    context.tbUsers.InsertOnSubmit(new tbUser()
                    {
                        Active = active,
                        Email = email,
                        FullName = fullname,
                        LastLogin = DateTime.Now,
                        Money = 0,
                        Password = Utils.Encryption(password),
                        Phone = phonenumber,
                        TypeUser = type,
                        UserName = username
                    });
                    context.SubmitChanges();
                }
                else
                {
                    user = context.tbUsers.SingleOrDefault(x => x.UserName.Equals(username));
                    if (user == null)
                        throw new Exception("Tài khoản chỉnh sửa không tồn tại");
                    user.Email = email;
                    user.Active = active;
                    if (password != "")
                        user.Password = Utils.Encryption(password);
                    user.Phone = phonenumber;
                    user.TypeUser = type;
                    user.FullName = fullname;
                    context.SubmitChanges();
                }
            }
        }

        public static List<User> GetAll(DatabaseDataContext context)
        {
            try
            {
                return context.Users.ToList();
            }
            catch (Exception)
            {
                return new List<User>();
            }
        }
        //public static User GetByID(DatabaseDataContext context, object id)
        //{
        //    try
        //    {
        //        var context = new DatabaseDataContext();
        //        return context.Users.Single(x => x.UserName.Equals(id.ToString()));
        //    }
        //    catch (Exception)
        //    {
        //        return null;
        //    }
        //}

        public static User GetByID(DatabaseDataContext context, object id)
        {
            try
            {
                return context.Users.Single(x => x.UserName.Equals(id.ToString()));
            }
            catch (Exception)
            {
                return null;
            }
        }
        public static User GetByID(DatabaseDataContext context, object id, bool active)
        {
            try
            {
                var user = GetByID(context, id);
                if (active == user.Active)
                    return user;
                return null;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public static User GetByIDPW(DatabaseDataContext context, object id, string password, bool active)
        {
            try
            {
                var pasmd5 = Utils.Encryption(password);
                var user = GetByID(context, id, active);
                return user.Password.Equals(pasmd5) ? user : null;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public static bool Update(DatabaseDataContext context, User user)
        {
            try
            {
                //using (DatabaseDataContext context = new DatabaseDataContext())
                {
                    var usertemp = context.Users.Single(x => x.UserName.Equals(user.UserName));
                    usertemp.TeamID = user.TeamID;
                    usertemp.Active = user.Active;
                    usertemp.Avatar = user.Avatar;
                    usertemp.Email = user.Email;
                    usertemp.FullName = user.FullName;
                    usertemp.Active = user.Active;
                    usertemp.Gender = user.Gender;
                    usertemp.JobDescription = user.JobDescription;
                    usertemp.JobTitleID = user.JobTitleID;
                    usertemp.Password = user.Password;
                    usertemp.PhoneNumber = user.PhoneNumber;
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
        public static void SetCookies(string username, HttpResponse Response)
        {
            try
            {
                FormsAuthenticationTicket authTicket = new FormsAuthenticationTicket(username, true, 120);
                string encryptedTicket = FormsAuthentication.Encrypt(authTicket);
                HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket);
                cookie.Expires = authTicket.Expiration;
                Response.Cookies.Set(cookie);

            }
            catch (Exception)
            {

            }
        }

        public static List<User> GetByTeam(DatabaseDataContext context, int teamid)
        {
            try
            {
                return context.Users.Where(x => x.TeamID == teamid).ToList();
            }
            catch (Exception)
            {
                return new List<User>();
            }
        }

        //public static List<User> GetByTeam(int teamid)
        //{
        //    try
        //    {
        //        var context = new DatabaseDataContext();
        //        return context.Users.Where(x => x.TeamID == teamid).ToList();
        //    }
        //    catch (Exception)
        //    {
        //        return new List<User>();
        //    }
        //}

        public static List<User> GetByTeam(Team team)
        {
            try
            {
                return team.Users.Where(x => x.Active).ToList();
            }
            catch (Exception)
            {
                return new List<User>();
            }
        }

        public static List<User> GetAllByTeam(DatabaseDataContext context, int teamid)
        {
            try
            {
                var list = new List<User>();
                //var context = new DatabaseDataContext();
                var team = context.Teams.Single(x => x.TeamID == teamid);
                list = team.Users.Where(x => x.Active).ToList();
                foreach (var item in team.Teams)
                {
                    list.AddRange(GetAllByTeam(item));
                }
                return list;
            }
            catch (Exception)
            {
                return new List<User>();
            }
        }

        public static List<User> GetAllByTeam(Team team)
        {
            try
            {
                var list = new List<User>();
                list = team.Users.Where(x => x.Active).ToList();
                foreach (var item in team.Teams)
                    list.AddRange(GetAllByTeam(item));
                return list;
            }
            catch (Exception)
            {
                return new List<User>();
            }
        }


        public static List<User> Search(DatabaseDataContext context, string keyword)
        {
            try
            {
                keyword = keyword.ToLower().Trim();
                //var context = new DatabaseDataContext();
                return context.Users.Where(x => x.UserName.ToLower().Contains(keyword) || x.FullName.ToLower().Contains(keyword)).ToList();
            }
            catch (Exception)
            {
                return new List<User>();
            }
        }


        public static Dictionary<string, string> getAllUsersDictionary(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var result = context.Users.ToDictionary(u => u.UserName, u => u.FullName);
                return result;
            }
            catch
            {
                return null;
            }
        }

        public static int setFavorite(DatabaseDataContext context, string userId, int favoriteProjectId)
        {
            try
            {
                //var context = new DatabaseDataContext();
                User user = context.Users.Single(u => u.UserName.Equals(userId));

                if (user.FavoriteProject == favoriteProjectId)
                {
                    user.FavoriteProject = null;
                }
                else
                {
                    user.FavoriteProject = favoriteProjectId;
                }

                context.SubmitChanges();
                return user.FavoriteProject ?? -2;
            }
            catch
            {
                return -1;
            }
        }

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// thay doi avatar
        /// </summary>
        /// <param name="username"></param>
        /// <param name="newavatar"></param>
        /// <returns></returns>
        public static bool ChangeAvatar(DatabaseDataContext context, string username, string newavatar)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var user = context.Users.Single(x => x.UserName == username);
                    user.Avatar = newavatar;
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }


        /// <summary>
        /// ngoc.nam 04.04.2015
        /// get avatar cuar user
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public static string GetAvatar(User user)
        {
            try
            {
                if (File.Exists(HttpContext.Current.Server.MapPath(user.Avatar)))
                    return user.Avatar;
                return "~/images/man-icon.png";
            }
            catch (Exception)
            {
                return "~/images/man-icon.png";
            }
        }

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// change password for user
        /// </summary>
        /// <param name="username"></param>
        /// <param name="currentpassword"></param>
        /// <param name="newpassword"></param>
        /// <param name="cause"></param>
        /// <returns></returns>
        public static bool ChangePassword(DatabaseDataContext context, string username, string currentpassword, string newpassword, ref string cause)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var users = context.Users.Where(x => x.UserName == username);
                    if (users.Count() == 0)
                    {
                        cause = "Please login to system to change password";
                        return false;
                    }
                    else
                    {
                        var curencrypt = Utils.Encryption(currentpassword);
                        var newencrypt = Utils.Encryption(newpassword);
                        if (curencrypt == users.First().Password)
                        {
                            users.First().Password = newencrypt;
                            context.SubmitChanges();
                            return true;
                        }
                        else
                        {
                            cause = "Current password is not correct";
                            return false;
                        }
                    }
                }
            }
            catch (Exception)
            {
                cause = "Sorry an unexpected error occurred . please reload the page and try again";
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// create resetcode khi quen mat khau
        /// </summary>
        /// <param name="username"></param>
        /// <param name="date"></param>
        /// <returns></returns>
        public static string CreateResetCode(string username, DateTime date)
        {
            string valid = date.ToString("ddMMyyyyhhmmss") + "abcdefghijklmnopXYZ12dkjf" + username + "alsdkfpdfhfgritytwxyzABCDEFGHIudcnfkgjdfgsla4567890qrstuvJKLMNOPQRSTUVW";
            StringBuilder res = new StringBuilder();
            Random rnd = new Random();
            var length = 45 + username.Length + 12;
            while (0 < length--)
            {
                res.Append(valid[rnd.Next(valid.Length)]);
            }
            return res.ToString();
        }

        ///// <summary>
        ///// ngoc.nam 04.04.2015
        ///// quen mat khau
        ///// </summary>
        ///// <param name="username"></param>
        ///// <param name="host"></param>
        ///// <returns></returns>
        //public static bool ForgorPassword(DatabaseDataContext context, string username)
        //{
        //    try
        //    {
        //        //using (var context = new DatabaseDataContext())
        //        {
        //            var user = context.Users.Single(x => x.UserName == username);
        //            var date = DateTime.Now;
        //            var token = date.ToString("ddMMyyyyhhmmss") + CreateResetCode(username, date);
        //            if (user.ResetPassword == null)
        //            {
        //                var reset = new ResetPassword()
        //                {
        //                    TimeExpiration = date.AddMinutes(10),
        //                    UserName = username,
        //                    Token = token
        //                };
        //                context.ResetPasswords.InsertOnSubmit(reset);
        //            }
        //            else
        //            {
        //                var reset = context.ResetPasswords.Single(x => x.UserName == username);
        //                reset.TimeExpiration = date.AddMinutes(10);
        //                reset.Token = token;
        //            }
        //            context.SubmitChanges();
        //            string link = string.Format("<a target='target' href='{0}/ResetPassword.aspx?username={1}&token={2}'></b>CLICK TO HERE</b></a>", Utils.LocalHost, user.UserName, token);
        //            string text = string.Format("Dear {0},<br><br>If you have forgotten your password please {1} to create a new password. The link will be died in 10 minutes.", user.FullName, link);
        //            SendMail.send(new List<string>() { user.Email }, "[SELSVMC] Reset Password", HttpUtility.HtmlEncode(text));
        //        }
        //        return true;
        //    }
        //    catch (Exception)
        //    {
        //        return false;
        //    }
        //}

        ///// <summary>
        ///// ngoc.nam 04.04.2015
        ///// reset password
        ///// </summary>
        ///// <param name="username"></param>
        ///// <param name="token"></param>
        ///// <param name="newpassword"></param>
        ///// <param name="host"></param>
        ///// <returns></returns>
        //public static bool ResetPassword(DatabaseDataContext context, string username, string token, string newpassword)
        //{
        //    try
        //    {
        //        if (string.IsNullOrEmpty(token))
        //            return false;
        //        //using (var context = new DatabaseDataContext())
        //        {
        //            var user = context.ResetPasswords.Single(x => x.UserName == username);
        //            if (user.Token == token && user.TimeExpiration > DateTime.Now)
        //            {
        //                user.Token = "";
        //                user.User.Password = Utils.Encryption(newpassword);
        //                context.SubmitChanges();
        //                string link = string.Format("<a target='target' href='{0}/Login.aspx'><b>CLICK HERE TO LOGIN </b></a> <i>(only use <b>IE9+, Chrome, FireFox</b>)</i>", Utils.LocalHost);
        //                string text = string.Format("Dear {0},<br><br>You have reset password successfull. <br> Your login information into the system as follows: <br>UserName: {1}<br>Password: {2}<br><br> Please login to system using information above.. <br>{3}", user.User.FullName, username, newpassword, link);
        //                SendMail.send(new List<string>() { user.User.Email }, "[SELSVMC] New password login to system", HttpUtility.HtmlEncode(text));
        //                return true;
        //            }
        //            return false;
        //        }
        //    }
        //    catch (Exception)
        //    {
        //        return false;
        //    }
        //}


        public static bool SavePersonalDetail(User user, string username)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    //if else admin
                    if (user.UserName != username)
                    {
                        if (!UserInfo.IsAdmin(username))
                            return false;
                    }
                    var user2 = context.Users.Single(x => x.UserName == user.UserName);
                    user2.FullName = user.FullName;
                    user2.GEN = user.GEN;
                    user2.Birthday = user.Birthday;
                    user2.Gender = user.Gender;
                    user2.PhoneNumber = user.PhoneNumber;
                    user2.JobTitleID = user.JobTitleID;
                    user2.TeamID = user.TeamID;
                    user2.Address = user.Address;
                    user2.JobDescription = user.JobDescription;
                    user2.ToeicScore = user.ToeicScore;
                    user2.STCLevel = user.STCLevel;
                    user2.DateJoiningSEL = user.DateJoiningSEL;
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }


        static bool IsMatch(string keyword, User user)
        {
            if (user.UserName.ToLower().Contains(keyword) || user.FullName.ToLower().Contains(keyword) || user.GEN.ToLower().Contains(keyword) || user.JobTitle.JobName.ToLower().Contains(keyword) || user.Gender.ToLower().Contains(keyword) || user.Birthday.ToShortDateString().ToLower().Contains(keyword) || user.Team.TeamName.ToLower().Contains(keyword) || user.DateJoiningSEL.ToShortDateString().ToLower().Contains(keyword))
                return true;
            return false;
        }


        /// <summary>
        /// ngoc.nam 04.04.2015
        /// Kiểm tra 1 user có phải là admin không
        /// </summary>
        /// <param name="usename"></param>
        /// <returns></returns>
        public static bool IsAdmin(string usename)
        {
            try
            {
                using (var context = new UserDbDataContext())
                {
                    var user = context.tbUsers.Single(x => x.UserName == usename);
                    return user.TypeUser == 1 || user.TypeUser == 2;
                }

            }
            catch (Exception)
            {
                return false;
            }
        }
        /// <summary>
        /// ngoc.nam 04.04.2015
        /// Kiểm tra 1 user có phải là admin không
        /// </summary>
        /// <param name="usename"></param>
        /// <returns></returns>
        public static bool IsAdmin(DatabaseDataContext context, User user)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var admin = context.Permissions.Single(x => x.name.ToLower() == "admin");
                if (user.PermissionId == admin.id && user.Active)
                    return true;
                else
                    return false;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
