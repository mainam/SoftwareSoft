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
    public partial class Member : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var partid = Request.QueryString["PartID"];
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    if (partid != null)
                    {
                        var listjobtitle = JobTitleInfo.GetAll().OrderBy(x => x.Order).ToList();
                        listjobtitle.Insert(0, new JobTitle() { JobTitleID = 0, JobName = "===ALL===" });
                        cbSelectJobTitle.DataSource = listjobtitle;
                        cbSelectJobTitle.DataTextField = "JobName";
                        cbSelectJobTitle.DataValueField = "JobTitleID";
                        cbSelectJobTitle.DataBind();

                        var part = TeamInfo.GetAllTeamType(context, TeamLever.Part).SingleOrDefault(x => x.TeamID == Convert.ToInt32(partid));
                        if (part != null)
                        {
                            var listeam = new List<object>();
                            var listteam2 = TeamInfo.GetTeamInTree(part).FindAll(x => x.TeamID != part.TeamID && UserInfo.GetByTeam(x).Count() > 0);
                            var temp2 = listteam2.Select(x => new { x.TeamName, x.TeamID });
                            listeam.Add(new { PartID = part.TeamID, ListTeam = temp2 });

                            dataTeam.Value = new JavaScriptSerializer().Serialize(listeam);
                            var listteamchil = TeamInfo.GetTeamInTree(part);
                            cbTeam.DataSource = listteamchil;
                            cbTeam.DataTextField = "TeamName";
                            cbTeam.DataValueField = "TeamID";
                            cbTeam.DataBind();
                        }

                        //part.Insert(0, new Team() { TeamID = 0, TeamName = "===ALL===" });
                        cbSelectPart.DataTextField = "TeamName";
                        cbSelectPart.DataValueField = "TeamID";
                        cbSelectPart.DataSource = new List<Team> { part };
                        cbSelectPart.DataBind();
                    }
                }
            }
            catch (Exception)
            {
                Response.Redirect("~/home/error404.html");
            }


            //var listpossion = PermissionIDInfo.getAll();
            //listpossion.Insert(0, new Permission() { id = 0, name = "==ALL==" });
            //cbSelectPossition.DataSource = listpossion;
            //cbSelectPossition.DataTextField = "name";
            //cbSelectPossition.DataValueField = "id";
            //cbSelectPossition.DataBind();
        }

        [WebMethod]
        public static string GetAllUser(int PartID, string keyword, int numberinpage, int currentpage, int JobTitleID, int STCLevel, int PossitionID, int TeamID, string Gender)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    int totaluser = 0;
                    var dataresult = UserInfo.GetAllUser(context, keyword.ToLower(), numberinpage, currentpage, ref totaluser, JobTitleID, PossitionID, 0, STCLevel, TeamID == 0 ? PartID : TeamID, Gender, true);

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
                        });
                        //var dataReturn = dataresult.Select(x => new { x.FullName, x.JobTitle.JobName, x.Team.TeamName, x.UserName, x.Gender, Birthday = x.Birthday.ToShortDateString(), Avatar = UserInfo.GetAvatar(x), x.STCScore, x.ToeicScore, DateJoiningSEL = x.DateJoiningSEL.ToShortDateString(), x.JobDescription, x.PhoneNumber, x.GEN, Position = x.Permission.name }).ToList();
                    }
                    var text = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true, Data = dataReturn, TotalUser = totaluser });
                    return text;
                }
            }
            catch (Exception)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

    }
}