using DataAccess;
using DataAccess.DataConfigFolder;
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
    public partial class ConfigTransferDeviceAllMember : System.Web.UI.Page
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

        static User GetUser(DatabaseDataContext context, string user)
        {
            try
            {
                return context.Users.Single(x => x.UserName == user);
            }
            catch (Exception)
            {
                return new User()
                {
                    UserName = "",
                    FullName = "",
                    JobTitle = new JobTitle() { JobName = "", Order = 0 }
                };
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
                    var list = DataConfigInfo.GetDataConfig(context, DataConfigEnum.AllowTransferAllMember).Select(x => new { x.ApplyDate, User = GetUser(context, x.DataValue), UserName = x.DataValue });

                    if (String.IsNullOrWhiteSpace(keyword))
                    {
                        context.AllowBorrowDevices.OrderBy(x => x.User.JobTitle.Order);
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
                        var list2 = list.Where(x => x.UserName.ToLower().Contains(keyword)
                                                        || x.User.FullName.ToLower().Contains(keyword)).OrderBy(x => x.User.JobTitle.Order);
                        data = Converts.Serialize(new
                        {
                            Status = true,
                            Data = list2.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList().Select(x => new
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
                            TotalItem = list2.Count()
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
                    if (user == null || !UserInfo.IsAdmin(context, user))
                        throw new Exception();
                    var list = DataConfigInfo.GetDataConfig(context, DataConfigEnum.AllowTransferAllMember).Where(x => x.DataValue == username);
                    if (list.Count() > 0)
                    {
                        context.DataConfigs.DeleteAllOnSubmit(list);
                        context.SubmitChanges();
                    }
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
                    if (user == null || !UserInfo.IsAdmin(context, user))
                        throw new Exception();
                    var list = DataConfigInfo.GetDataConfig(context, DataConfigEnum.AllowTransferAllMember).Where(x => ListUser.Contains(x.DataValue));
                    context.DataConfigs.DeleteAllOnSubmit(list);
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