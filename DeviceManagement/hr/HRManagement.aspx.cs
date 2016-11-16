using DataAccess;
using DataAccess.TeamFolder;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.hr
{
    public partial class HRManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var listjobtitle = JobTitleInfo.GetAll();
                listjobtitle.Insert(0, new JobTitle() { JobTitleID = 0, JobName = "==ALL==" });
                cbSelectJobTitle.DataSource = listjobtitle;
                cbSelectJobTitle.DataTextField = "JobName";
                cbSelectJobTitle.DataValueField = "JobTitleID";
                cbSelectJobTitle.DataBind();

                var part = TeamInfo.GetAllTeamType(context,TeamLever.Part);
                var listeam = new List<object>();
                foreach (var item in part)
                {
                    var listteam2 = TeamInfo.GetTeamInTree(item).FindAll(x => x.TeamID != item.TeamID && UserInfo.GetByTeam(x).Count() > 0);
                    var temp2 = listteam2.Select(x => new { x.TeamName, x.TeamID });
                    listeam.Add(new { PartID = item.TeamID, ListTeam = temp2 });
                }

                dataTeam.Value = new JavaScriptSerializer().Serialize(listeam);

                part.Insert(0, new Team() { TeamID = 0, TeamName = "===ALL===" });
                cbSelectPart.DataTextField = "TeamName";
                cbSelectPart.DataValueField = "TeamID";
                cbSelectPart.DataSource = part;
                cbSelectPart.DataBind();

                //var listpossion = PermissionIDInfo.getAll();
                //listpossion.Insert(0, new Permission() { id = 0, name = "==ALL==" });
                //cbSelectPossition.DataSource = listpossion;
                //cbSelectPossition.DataTextField = "name";
                //cbSelectPossition.DataValueField = "id";
                //cbSelectPossition.DataBind();

                var listteam = TeamInfo.GetAll(context).Where(x => x.TeamName.Trim() != "").ToList();
                listteam.Insert(0, new Team() { TeamID = 0, TeamName = "==ALL==" });
                cbTeam.DataSource = listteam;
                cbTeam.DataTextField = "TeamName";
                cbTeam.DataValueField = "TeamID";
                cbTeam.DataBind();
            }
        }

        //[WebMethod]
        //public static string GetAllUser(string keyword, int numberinpage, int currentpage, int JobTitleID, int STCLevel, int PossitionID, int TeamID, string Gender)
        //{
        //    try
        //    {
        //        int totaluser = 0;
        //        var dataresult = UserInfo.GetAllUser(keyword.ToLower(), numberinpage, currentpage, ref totaluser, JobTitleID, PossitionID, 0, STCLevel, TeamID, Gender, true);

        //        var dataReturn = new List<object>();
        //        foreach (var item in dataresult)
        //        {
        //            var group = TeamInfo.GetTeamType(item, TeamLever.Group);
        //            var part = TeamInfo.GetTeamType(item, TeamLever.Part);
        //            dataReturn.Add(new
        //            {
        //                item.FullName,
        //                item.JobTitle.JobName,
        //                GroupName = group != null ? group.TeamName : "",
        //                PartName = part != null ? part.TeamName : "",
        //                TeamName = (item.Team == part || item.Team == group) ? "" : item.Team.TeamName,

        //                item.UserName,
        //                item.Gender,
        //                Birthday = item.Birthday.ToShortDateString(),
        //                Avatar = UserInfo.GetAvatar(item),
        //                item.STCScore,
        //                item.ToeicScore,
        //                DateJoiningSEL = item.DateJoiningSEL.ToShortDateString(),
        //                item.JobDescription,
        //                item.PhoneNumber,
        //                item.GEN,
        //                Position = (group != null && group.Leader == item.UserName) ? "Group Leader" : (part != null && part.Leader == item.UserName) ? "Part Leader" : (item.Team != null && item.Team.Leader == item.UserName) ? "Team Leader" : "Member",
        //            });
        //            //var dataReturn = dataresult.Select(x => new { x.FullName, x.JobTitle.JobName, x.Team.TeamName, x.UserName, x.Gender, Birthday = x.Birthday.ToShortDateString(), Avatar = UserInfo.GetAvatar(x), x.STCScore, x.ToeicScore, DateJoiningSEL = x.DateJoiningSEL.ToShortDateString(), x.JobDescription, x.PhoneNumber, x.GEN, Position = x.Permission.name }).ToList();
        //        }
        //        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true, Data = dataReturn, TotalUser = totaluser });
        //    }
        //    catch (Exception)
        //    {
        //        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
        //    }
        //}



        [WebMethod]
        public static string GetAllUser(string keyword, int numberinpage, int currentpage, int JobTitleID, int PossitionID, int Permission, int STCLevel, int TeamID, string Gender, int Active)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {


                    int totaluser = 0;
                    bool? active = null;
                    if (Active == 1) active = true;
                    if (Active == 2) active = false;
                    var dataresult = UserInfo.GetAllUser(context, keyword.ToLower(), numberinpage, currentpage, ref totaluser, JobTitleID, PossitionID, Permission, STCLevel, TeamID, Gender, active);
                    //var dataReturn = dataresult.Select(x => new { x.FullName, x.JobTitle.JobName, x.Team.TeamName, x.UserName, x.Gender, Birthday = x.Birthday.ToShortDateString(), Avatar = UserInfo.GetAvatar(x), x.STCScore, x.ToeicScore, DateJoiningSEL = x.DateJoiningSEL.ToShortDateString(), x.JobDescription, x.PhoneNumber, x.GEN, Position = x.Permission.name, }).ToList();

                    var dataReturn = new List<object>();
                    foreach (var item in dataresult)
                    {
                        var group = TeamInfo.GetTeamType(item, TeamLever.Group);
                        var part = TeamInfo.GetTeamType(item, TeamLever.Part);
                        dataReturn.Add(new
                        {
                            item.FullName,
                            item.JobTitle.JobName,
                            GroupName = group != null ? group.TeamName : "",
                            PartName = part != null ? part.TeamName : "",
                            TeamName = (item.Team == part || item.Team == group) ? "" : item.Team.TeamName,

                            item.UserName,
                            item.Gender,
                            Birthday = item.Birthday.ToShortDateString(),
                            Avatar = UserInfo.GetAvatar(item),
                            item.STCLevel,
                            item.ToeicScore,
                            DateJoiningSEL = item.DateJoiningSEL.ToShortDateString(),
                            item.JobDescription,
                            item.PhoneNumber,
                            item.GEN,
                            Position = (group != null && group.Leader == item.UserName) ? "Group Leader" : (part != null && part.Leader == item.UserName) ? "Part Leader" : (item.Team != null && item.Team.Leader == item.UserName) ? "Team Leader" : "Member",
                            Permission = item.Permission != null ? item.Permission.name : "",
                            Leader = item.Team.Leader == null ? "" : item.Team.Leader,
                            item.Active

                        });
                        //var dataReturn = dataresult.Select(x => new { x.FullName, x.JobTitle.JobName, x.Team.TeamName, x.UserName, x.Gender, Birthday = x.Birthday.ToShortDateString(), Avatar = UserInfo.GetAvatar(x), x.STCScore, x.ToeicScore, DateJoiningSEL = x.DateJoiningSEL.ToShortDateString(), x.JobDescription, x.PhoneNumber, x.GEN, Position = x.Permission.name }).ToList();
                    }
                    //        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true, Data = dataReturn, TotalUser = totaluser });


                    var text = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true, Data = dataReturn, TotalUser = totaluser });
                    return text;
                }
            }
            catch (Exception)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string SetLeader(string username)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var currentuser = HttpContext.Current.User.Identity.Name;
                    if (UserInfo.SetLeader(context, username, currentuser))
                    {
                        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true });
                    }
                    else
                    {
                        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
                    }
                }
            }
            catch (Exception)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string ActiveMember(string username, bool active)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var currentuser = HttpContext.Current.User.Identity.Name;
                    if (UserInfo.ActiveMember(context, username, currentuser, active))
                    {
                        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true });
                    }
                    else
                    {
                        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
                    }
                }
            }
            catch (Exception)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string DeleteUser(string mySingle)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var currentuser = HttpContext.Current.User.Identity.Name;
                    if (UserInfo.DeleteUser(context, mySingle, currentuser))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    return new JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}