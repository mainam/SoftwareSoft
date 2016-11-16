using DataAccess;
using DataAccess.TeamFolder;
using DataAccess.UserFolder;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.Admin.Device
{
    public partial class ConfigAllowBorrowDevice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        static string GetTeamLevel(User user, TeamLever teamlever)
        {
            try
            {
                return TeamInfo.GetTeamType(user, teamlever).TeamName;

            }
            catch (Exception)
            {
                return "";
            }

        }

        [WebMethod]
        public static String LoadData(string keyword, int numberinpage, int currentpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    string data = "";
                    if (String.IsNullOrWhiteSpace(keyword))
                    {
                        var list = context.AllowBorrowDevices.OrderBy(x => x.User.JobTitle.Order);
                        data = Converts.Serialize(new
                        {
                            Status = true,
                            Data = list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList().Select(x => new
                            {
                                ApplyDate = x.ApplyDate.ToString("dd/MM/yyyy"),
                                x.UserName,
                                x.User.FullName,
                                x.User.Active,
                                IsTeamLeader = UserInfo.IsLeader(x.User),
                                x.User.JobTitle.JobName,
                                Group = GetTeamLevel(x.User, TeamLever.Group),
                                Part = GetTeamLevel(x.User, TeamLever.Part)
                            }),
                            TotalItem = list.Count()
                        });
                    }
                    else
                    {
                        keyword = keyword.ToLower().Trim();
                        var list = context.AllowBorrowDevices.Where(x => x.UserName.ToLower().Contains(keyword)
                                                        || x.User.FullName.ToLower().Contains(keyword)).OrderBy(x => x.User.JobTitle.Order);
                        data = Converts.Serialize(new
                        {
                            Status = true,
                            Data = list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList().Select(x => new
                            {
                                ApplyDate = x.ApplyDate.ToString("dd/MM/yyyy"),
                                x.UserName,
                                x.User.FullName,
                                x.User.Active,
                                IsTeamLeader = UserInfo.IsLeader(x.User),
                                x.User.JobTitle.JobName,
                                Group = GetTeamLevel(x.User, TeamLever.Group),
                                Part = GetTeamLevel(x.User, TeamLever.Part)

                            }),
                            TotalItem = list.Count()
                        });
                    }
                    return data;
                }
            }
            catch (Exception e)
            {
                return Converts.Serialize(new { Status = false });
            }

        }

        [WebMethod]
        public static String Delete(string username)
        {
            try
            {
                if (String.IsNullOrWhiteSpace(username))
                    throw new Exception();
                using (var context = new DatabaseDataContext())
                {
                    var _user = HttpContext.Current.User.Identity.Name;
                    var user = context.Users.SingleOrDefault(x => x.UserName == _user);
                    if (user == null || !UserInfo.IsAdmin(context,user))
                        throw new Exception();
                    var list = context.AllowBorrowDevices.Where(x => x.UserName == username);
                    context.AllowBorrowDevices.DeleteAllOnSubmit(list);
                    context.SubmitChanges();
                    return Converts.Serialize(new { Status = true });
                }
            }
            catch (Exception)
            {
                return Converts.Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static String DeleteMultipleUser(List<String> ListUser)
        {
            try
            {
                if (ListUser == null || ListUser.Count == 0)
                    throw new Exception();
                using (var context = new DatabaseDataContext())
                {
                    var _user = HttpContext.Current.User.Identity.Name;
                    var user = context.Users.SingleOrDefault(x => x.UserName == _user);
                    if (user == null || !UserInfo.IsAdmin(context,user))
                        throw new Exception();
                    var list = context.AllowBorrowDevices.Where(x => ListUser.Contains(x.UserName));
                    context.AllowBorrowDevices.DeleteAllOnSubmit(list);
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