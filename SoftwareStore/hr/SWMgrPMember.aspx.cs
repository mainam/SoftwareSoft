using DataAccess;
using DataAccess.TeamFolder;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.hr
{
    public partial class SWMgrPMember : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var listjobtitle = JobTitleInfo.GetAll().OrderBy(x => x.Order).ToList();
                listjobtitle.Insert(0, new JobTitle() { JobTitleID = 0, JobName = "===ALL===" });
                cbSelectJobTitle.DataSource = listjobtitle;
                cbSelectJobTitle.DataTextField = "JobName";
                cbSelectJobTitle.DataValueField = "JobTitleID";
                cbSelectJobTitle.DataBind();

                var part = TeamInfo.GetAllTeamType(context, TeamLever.Part).SingleOrDefault(x => x.TeamID == 89);
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



                //var listpossion = PermissionIDInfo.getAll();
                //listpossion.Insert(0, new Permission() { id = 0, name = "==ALL==" });
                //cbSelectPossition.DataSource = listpossion;
                //cbSelectPossition.DataTextField = "name";
                //cbSelectPossition.DataValueField = "id";
                //cbSelectPossition.DataBind();
            }
        }
    }
}