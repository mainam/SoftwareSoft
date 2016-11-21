using DataAccess.DataConfigFolder;
using DataAccess.Db;
using DataAccess.Db.Db;
using DataAccess.DeviceFolder;
using DataAccess.Helper;
using DataAccess.TeamFolder;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Security;
using System.Web.Services;

namespace DataAccess.UserFolder
{

    public class UserInfo
    {

        public static tbUser _GetByIDPW(dbUserDataContext context, object id, string password)
        {
            try
            {
                var pasmd5 = Utils.Encryption(password);
                var user = _GetByID(context, id);
                if(!user.Active)
                    return null;
                return user.Password.Equals(pasmd5) ? user : null;
            }
            catch (Exception)
            {
                return null;
            }
        }
        public static tbUser _GetByID(dbUserDataContext context, object id)
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

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// quen mat khau
        /// </summary>
        /// <param name="username"></param>
        /// <param name="host"></param>
        /// <returns></returns>
        public static bool ForgorPassword(DatabaseDataContext context, string username)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var user = context.Users.Single(x => x.UserName == username);
                    var date = DateTime.Now;
                    var token = date.ToString("ddMMyyyyhhmmss") + CreateResetCode(username, date);
                    if (user.ResetPassword == null)
                    {
                        var reset = new ResetPassword()
                        {
                            TimeExpiration = date.AddMinutes(10),
                            UserName = username,
                            Token = token
                        };
                        context.ResetPasswords.InsertOnSubmit(reset);
                    }
                    else
                    {
                        var reset = context.ResetPasswords.Single(x => x.UserName == username);
                        reset.TimeExpiration = date.AddMinutes(10);
                        reset.Token = token;
                    }
                    context.SubmitChanges();
                    string link = string.Format("<a target='target' href='{0}/ResetPassword.aspx?username={1}&token={2}'></b>CLICK TO HERE</b></a>", Utils.LocalHost, user.UserName, token);
                    string text = string.Format("Dear {0},<br><br>If you have forgotten your password please {1} to create a new password. The link will be died in 10 minutes.", user.FullName, link);
                    SendMail.send(new List<string>() { user.Email }, "[SELSVMC] Reset Password", HttpUtility.HtmlEncode(text));
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// reset password
        /// </summary>
        /// <param name="username"></param>
        /// <param name="token"></param>
        /// <param name="newpassword"></param>
        /// <param name="host"></param>
        /// <returns></returns>
        public static bool ResetPassword(DatabaseDataContext context, string username, string token, string newpassword)
        {
            try
            {
                if (string.IsNullOrEmpty(token))
                    return false;
                //using (var context = new DatabaseDataContext())
                {
                    var user = context.ResetPasswords.Single(x => x.UserName == username);
                    if (user.Token == token && user.TimeExpiration > DateTime.Now)
                    {
                        user.Token = "";
                        user.User.Password = Utils.Encryption(newpassword);
                        context.SubmitChanges();
                        string link = string.Format("<a target='target' href='{0}/Login.aspx'><b>CLICK HERE TO LOGIN </b></a> <i>(only use <b>IE9+, Chrome, FireFox</b>)</i>", Utils.LocalHost);
                        string text = string.Format("Dear {0},<br><br>You have reset password successfull. <br> Your login information into the system as follows: <br>UserName: {1}<br>Password: {2}<br><br> Please login to system using information above.. <br>{3}", user.User.FullName, username, newpassword, link);
                        SendMail.send(new List<string>() { user.User.Email }, "[SELSVMC] New password login to system", HttpUtility.HtmlEncode(text));
                        return true;
                    }
                    return false;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }


        public static bool SavePersonalDetail(User user, string username)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    //if else admin
                    if (user.UserName != username)
                    {
                        if (!UserInfo.IsAdmin(context, username))
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

        public static List<User> GetAllUser(DatabaseDataContext context, string keyword, int numberinpage, int currentpage, ref int totaluser, int jobtitle, int possition, int permission, int stclevel, int teamid, string gender, bool? active)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var users = context.Users.OrderBy(x => x.JobTitle.Order).ThenBy(x => x.TeamID).ThenBy(x => x.Team.Leader == x.UserName).ThenByDescending(x => x.Birthday).ToList();
                var listresult = new List<User>();
                var team = new Team();
                var listteam = new List<Team>();
                if (teamid != 0)
                    team = context.Teams.SingleOrDefault(x => x.TeamID == teamid);
                if (team == null)
                    throw new Exception();
                else
                    listteam = TeamInfo.GetTeamInTree(context, team.TeamID);

                foreach (var item in users)
                {
                    if (active == null || (active.Value == item.Active))
                        if ((jobtitle == 0 || item.JobTitleID == jobtitle)
                            && (teamid == 0 || TeamInfo.InTree(listteam, item.TeamID))
                            && (gender == "" || (item.Gender == gender)))
                        {
                            switch (possition)
                            {
                                case 0:
                                    break;
                                case 1:
                                    if (item.Team.LevelTeam != null && item.Team.LevelTeam == 1 && item.Team.Leader == item.UserName)
                                        break;
                                    else
                                        continue;
                                case 2:
                                    if (item.Team.LevelTeam != null && item.Team.LevelTeam == 2 && item.Team.Leader == item.UserName)
                                        break;
                                    else
                                        continue;
                                case 3:
                                    if (item.Team.Leader == item.UserName)
                                        break;
                                    else
                                        continue;

                                case 4:
                                    if (item.Team.Leader != item.UserName)
                                        break;
                                    else
                                        continue;
                                default:
                                    break;
                            }

                            switch (stclevel)
                            {
                                case 0: break;
                                case 1: if (item.STCLevel == 1)
                                        break;
                                    continue;
                                case 2: if (item.STCLevel == 2)
                                        break;
                                    continue;
                                case 3: if (item.STCLevel == 3)
                                        break;
                                    continue;
                                case 4: if (item.STCLevel == 4)
                                        break;
                                    continue;
                                case 5: if (item.STCLevel == 5)
                                        break;
                                    continue;
                                default:
                                    break;
                            }

                            switch (permission)
                            {
                                case 0: break;
                                default: if (item.Permission != null && item.PermissionId == permission)
                                        break;
                                    continue;
                            }

                            if (IsMatch(keyword, item))
                                listresult.Add(item);

                        }
                }
                totaluser = listresult.Count();
                return listresult.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();//,x.FullName,x.TeamID,TeamName = x.Team.TeamName, x.JobDescription,x.JobTitle.JobName, x.Email,x.PhoneNumber,x.GEN,x.Gender,x.Permission.name,Birthday=x.Birthday.ToShortDateString(),}userDetailFromUser(context, x)).ToList();
            }
            catch
            {
                return new List<User>();
            }
        }

        public static object StatisticQuantity(DatabaseDataContext context)
        {
            //var context = new DatabaseDataContext();
            var temp = context.Teams.SingleOrDefault(x => x.TeamID == 88);
            var listteam = new List<Team>();
            if (temp != null)
                listteam = TeamInfo.GetTeamInTree(temp);
            var listuser = context.Users.Where(y => !listteam.Contains(y.Team) && y.Active).OrderByDescending(x => x.DateJoiningSEL.Year);
            var listreturn = listuser.GroupBy(x => x.DateJoiningSEL.Year).Select(x => new { Type = x.First().DateJoiningSEL.Year, Quantity = x.Count() }).ToList();
            return listreturn;
        }

        public static object StatisticMajor(DatabaseDataContext context)
        {
            //var context = new DatabaseDataContext();
            var listReturn = context.Majors.Select(x => new { Type = x.Name, Quantity = x.UserEducations.Where(y => y.User.Active).Count() }).ToList();
            return listReturn;
        }

        public static object StatisticAge(DatabaseDataContext context)
        {
            //var context = new DatabaseDataContext();
            var temp = context.Teams.SingleOrDefault(x => x.TeamID == 54);



            if (temp != null)
            {
                var allUsers = TeamInfo.GetAllUserInTreeTeam(temp).Where(x => x.Active).ToList();

                List<object> listReturn = new List<object>();

                var Quantity20 = allUsers.Where(x => DateTime.Now.Year - x.Birthday.Year > 20 && DateTime.Now.Year - x.Birthday.Year <= 25).ToList().Count;
                object ob1 = new { Type = "20 - 25", Quantity = Quantity20 };
                listReturn.Add(ob1);

                var Quantity25 = allUsers.Where(x => DateTime.Now.Year - x.Birthday.Year > 25 && DateTime.Now.Year - x.Birthday.Year <= 30).ToList().Count;
                object ob2 = new { Type = "25 - 30", Quantity = Quantity25 };
                listReturn.Add(ob2);

                var Quantity30 = allUsers.Where(x => DateTime.Now.Year - x.Birthday.Year > 30 && DateTime.Now.Year - x.Birthday.Year <= 35).ToList().Count;

                object ob3 = new { Type = "30 - 35", Quantity = Quantity30 };
                listReturn.Add(ob3);

                object ob4 = new { Type = ">35", Quantity = allUsers.Count - (Quantity20 + Quantity25 + Quantity30) };
                listReturn.Add(ob4);


                return listReturn;
            }
            else
                return new List<object>();
        }

        public static object StatisticEducation(DatabaseDataContext context)
        {
            //using (var context = new DatabaseDataContext())
            {

                var temp = context.Teams.SingleOrDefault(x => x.TeamID == 54);

                if (temp != null)
                {
                    var allUsers = TeamInfo.GetAllUserInTreeTeam(temp).Where(x => x.Active).Select(x => x.UserName).ToList();
                    var listReturn = context.EducationLevels.Select(x => new { Type = x.Level, Quantity = x.UserEducations.Where(y => y.User.Active && allUsers.Contains(y.User.UserName)).Count() }).ToList();
                    var total = listReturn.Sum(x => x.Quantity);

                    if (allUsers.Count != total)
                    {
                        listReturn.Add(new { Type = "Other", Quantity = allUsers.Count - total });
                    }

                    return listReturn;
                }
                else
                    return new List<object>();
            }
        }

        public static object StatisticSTCLevel(DatabaseDataContext context)
        {
            //using (var context = new DatabaseDataContext())
            {
                var listuser = TeamInfo.GetAllUserInTreeTeam(context, 63).Where(x => x.Active);
                //var level1 = listuser.Count(x => x.STCScore >= 950);
                //var level2 = listuser.Count(x => x.STCScore >= 850 && x.STCScore < 950);
                //var level3 = listuser.Count(x => x.STCScore >= 700 && x.STCScore < 849);
                //var level4 = listuser.Count(x => x.STCScore >= 500 && x.STCScore < 700);
                //var level5 = listuser.Count(x => x.STCScore < 500);
                var level1 = listuser.Count(x => x.STCLevel == 1);
                var level2 = listuser.Count(x => x.STCLevel == 2);
                var level3 = listuser.Count(x => x.STCLevel == 3);
                var level4 = listuser.Count(x => x.STCLevel == 4);
                var level5 = listuser.Count(x => x.STCLevel == 5);

                var listreturn = new List<Object>();
                listreturn.Add(new { Type = "Level1", Quantity = level1 });
                listreturn.Add(new { Type = "Level2", Quantity = level2 });
                listreturn.Add(new { Type = "Level3", Quantity = level3 });
                listreturn.Add(new { Type = "Level4", Quantity = level4 });
                listreturn.Add(new { Type = "FAIL", Quantity = level5 });
                return listreturn;
            }
        }


        public static object StatisticTOEIC(DatabaseDataContext context)
        {
            //using (var context = new DatabaseDataContext())
            {
                var temp = context.Teams.SingleOrDefault(x => x.TeamID == 88);
                var listteam = new List<Team>();
                if (temp != null)
                    listteam = TeamInfo.GetTeamInTree(temp);

                var listTOEIC = context.Users.Where(x => x.Active && !listteam.Contains(x.Team));


                List<object> listReturn = new List<object>();
                object ob1 = new { Type = "<500", Quantity = listTOEIC.Where(x => x.ToeicScore < 500).ToList().Count };
                listReturn.Add(ob1);

                object ob2 = new { Type = "500 - 600", Quantity = listTOEIC.Where(x => x.ToeicScore >= 500 && x.ToeicScore < 600).ToList().Count };
                listReturn.Add(ob2);

                object ob3 = new { Type = "600 - 700", Quantity = listTOEIC.Where(x => x.ToeicScore >= 600 && x.ToeicScore < 700).ToList().Count };
                listReturn.Add(ob3);

                object ob4 = new { Type = ">700", Quantity = listTOEIC.Where(x => x.ToeicScore >= 700).ToList().Count };
                listReturn.Add(ob4);


                return listReturn;
            }
        }



        public static object GetUserProfile(DatabaseDataContext context, string username)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var user = context.Users.Single(x => x.UserName == username);
                var listeducation = user.UserEducations.Select(x => new
                {
                    x.ID,
                    x.EducationLevel,
                    Education = x.EducationLevel1.Level,
                    Enteredat = x.Enteredat.ToString("MM/dd/yyyy"),
                    Graduated = x.Graduated.ToString("MM/dd/yyyy"),
                    x.OtherUniversity,
                    x.UniversityID,
                    University = x.UniversityID != 1 ? x.University.Name : x.OtherUniversity,
                    x.OtherMajor,
                    x.MajorID,
                    Major = x.MajorID != 1 ? x.Major.Name : x.OtherMajor
                });
                var listlanguage = user.UserLanguages.Select(x => new
                {
                    x.Languageid,
                    Language = x.Languageid == 1 ? x.OtherLanguage : x.DataLanguage.Name,
                    x.ID,
                    x.Native,
                    x.OtherLanguage,
                    x.ScoreWrite,
                    x.ScoreSpeak,
                    x.ScoreRead,
                    x.ScoreOverall
                });

                var listcertification = user.UserCertifications.Select(x => new
                {
                    x.DataCertificationID,
                    Certification = x.DataCertificationID == 1 ? x.OtherDataCertification : x.DataCertification.Name,
                    x.ID,
                    IssueDate = x.IssueDate.ToString("MM/dd/yyyy"),
                    x.IssuedBy,
                    x.LicenseNo,
                    Expiration = x.Expiration == null ? "" : x.Expiration.Value.ToString("MM/dd/yyyy"),
                    x.Grade,
                    x.OtherDataCertification
                });

                var listaward = user.AwardRewards.Where(x => x.Type == 1).Select(x => new
                {
                    x.ID,
                    x.Name,
                    x.Content,
                    IssueDate = x.IssueDate.ToString("MM/dd/yyyy"),
                    x.UserName,
                    x.Type,
                    x.AwardBy
                });
                var listreward = user.AwardRewards.Where(x => x.Type == 2).Select(x => new
                {
                    x.ID,
                    x.Name,
                    x.Content,
                    IssueDate = x.IssueDate.ToString("MM/dd/yyyy"),
                    x.UserName,
                    x.Type,
                    x.AwardBy

                });
                return new { Education = listeducation, Language = listlanguage, Certification = listcertification, Award = listaward, Reward = listreward };
            }
            catch (Exception)
            {
                return new { Education = new List<string>() };
            }
        }

        //public static bool OnlyPesonallist(User user)
        //{
        //    var team = user.Team;
        //    if (team != null)
        //        return team.TeamParent == null;
        //    return false;
        //}

        //public static bool OnlyTodolist(User user)
        //{
        //    var team = user.Team;
        //    if (team != null)
        //    {
        //        var teamchil = TeamInfo.GetTeamByParent(team);
        //        if (teamchil.Count > 0)
        //            return false;
        //        else
        //        {
        //            if (team.User != null)
        //            {
        //                if (team.Leader != user.UserName)
        //                    return true;
        //                return false;
        //            }
        //            else
        //                return true;
        //        }
        //    }
        //    return true;
        //}

      

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// Kiểm tra 1 user có phải là admin không
        /// </summary>
        /// <param name="usename"></param>
        /// <returns></returns>
        public static bool IsAdmin(DatabaseDataContext context, string usename)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var user = context.Users.Single(x => x.UserName == usename);
                    return IsAdmin(context, user);
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


        /// <summary>
        /// ngoc.nam 04.04.2015
        /// Xóa 1 user
        /// </summary>
        /// <param name="mySingle"></param>
        /// <param name="currentuser"></param>
        /// <returns></returns>
        public static bool DeleteUser(DatabaseDataContext context, string mySingle, string currentuser)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var useradmin = context.Users.Single(x => x.UserName == currentuser);
                    if (IsAdmin(context, useradmin))
                    {
                        var user = context.Users.Single(x => x.UserName == mySingle);
                        context.InventoryUserDevices.DeleteAllOnSubmit(user.InventoryUserDevices);
                        var listdevice = context.Devices;
                        foreach (var item in listdevice)
                        {
                            if (item.Borrower == mySingle)
                            {
                                item.BorrowDate = null;
                                item.Borrower = null;
                                item.ReturnDate = null;
                            }
                            if (item.Receiver == mySingle)
                            {
                                item.Receiver = null;
                            }
                            if (item.Keeper == mySingle)
                                item.Keeper = null;
                        }
                        context.Inventories.DeleteAllOnSubmit(user.Inventories);
                        context.Approves.DeleteAllOnSubmit(user.Approves);
                        context.Approves.DeleteAllOnSubmit(user.Approves1);
                        context.Approves.DeleteAllOnSubmit(user.Approves2);

                        context.Users.DeleteOnSubmit(context.Users.Single(x => x.UserName == mySingle));
                        context.SubmitChanges();
                        return true;
                    }
                    return false;
                }
            }
            catch (Exception)
            {

                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// active 1 member
        /// </summary>
        /// <param name="username"></param>
        /// <param name="currentuser"></param>
        /// <param name="active"></param>
        /// <returns></returns>
        public static bool ActiveMember(DatabaseDataContext context, string username, string currentuser, bool active)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var useradmin = context.Users.Single(x => x.UserName == currentuser);
                    if (IsAdmin(context, useradmin))
                    {
                        var user = context.Users.Single(x => x.UserName == username);
                        user.Active = active;
                        context.SubmitChanges();
                        return true;
                    }
                    return false;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// gan 1 người làm leader
        /// </summary>
        /// <param name="username"></param>
        /// <param name="currentuser"></param>
        /// <returns></returns>
        public static bool SetLeader(DatabaseDataContext context, string username, string currentuser)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var useradmin = context.Users.Single(x => x.UserName == currentuser);
                    if (IsAdmin(context, useradmin))
                    {
                        var user = context.Users.Single(x => x.UserName == username);
                        if (!user.Active)
                            return false;
                        user.Team.Leader = user.UserName;
                        context.SubmitChanges();
                        return true;
                    }
                    return false;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }


        /// <summary>
        /// ngoc.nam 04.04.2015
        /// kiểm tra user có phải là leader không
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public static bool IsLeader(User user)
        {
            try
            {
                return user.Team.Leader.Equals(user.UserName) && user.Active;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// kiểm tra user có phải là leader không
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public static bool IsLeader(DatabaseDataContext context, string username)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var user = GetByID(context, username);
                    return user.Team.Leader.Equals(user.UserName);
                }
            }
            catch (Exception)
            {
                return false;
            }
        }


        public static bool AllowBorrowDevice(DatabaseDataContext context, User user)
        {
            var isAdmin = UserInfo.IsAdmin(context, user);
            var allowteamleader = DeviceConfig.AllowTeamLeaderBorrowDevice(context);
            if (isAdmin)
                return true;

            if (IsLeader(user) && allowteamleader)
                return true;

            if (user.AllowBorrowDevice != null)
                return true;

            return false;
        }
    }
}
