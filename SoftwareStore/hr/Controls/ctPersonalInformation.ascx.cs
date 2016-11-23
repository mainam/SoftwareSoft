using DataAccess;
using DataAccess.TeamFolder;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.hr.Controls
{
    public partial class ctPersonalInformation : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                var _username = Request.QueryString["user"];
                var username = HttpContext.Current.User.Identity.Name;
                User user = null;
                if (_username != null)
                {
                    if (username != _username)
                    {
                        if (!UserInfo.IsAdmin(context, username))
                        {
                            btnEdit.Visible = false;
                            btnChangeAvatar.Visible = false;
                        }
                    }
                    user = UserInfo.GetByID(context, _username);
                    if (user == null)
                        throw new Exception();
                }
                else
                {
                    user = UserInfo.GetByID(context, username);
                    if (user == null)
                        throw new Exception();
                }

                var listjobtitle = JobTitleInfo.GetAll();
                txtJobTitle.DataSource = listjobtitle;
                txtJobTitle.DataTextField = "JobName";
                txtJobTitle.DataValueField = "JobTitleID";
                txtJobTitle.DataBind();

                var listteam = TeamInfo.GetAll(context).Where(x => x.TeamName != "");
                txtTeam.DataSource = listteam;
                txtTeam.DataTextField = "TeamName";
                txtTeam.DataValueField = "TeamID";
                txtTeam.DataBind();

                txtTeamLeader.DataSource = listteam.Where(x => x.User != null).Select(x => new { x.TeamID, x.User.FullName });
                txtTeamLeader.DataValueField = "TeamID";
                txtTeamLeader.DataTextField = "FullName";
                txtTeamLeader.DataBind();

                BindData(user);
            }
        }

        void BindData(User user)
        {
            txtFullName.Value = txtFullName.Value = user.FullName;
            txtGender.Value = user.Gender;
            txtDateofBirth.Value = user.Birthday.ToShortDateString();
            txtMySingleID.Value = user.UserName;
            txtGenNumber.Value = user.GEN;
            txtPhoneNumber.Value = user.PhoneNumber;
            txtJobTitle.Value = user.JobTitleID.Value.ToString();
            txtTeam.Value = user.TeamID.ToString();
            txtTeamLeader.Value = user.TeamID.ToString();
            imgAvatar.Src = UserInfo.GetAvatar(user);
            txtSTCLevel.Value = user.STCLevel.ToString();
            txtToeicScore.Value = user.ToeicScore.ToString();
            txtDateJoinSEL.Value = user.DateJoiningSEL.ToShortDateString();
            txtJobDescription.Value = user.JobDescription;
            txtAddress.Value = user.Address;
        }

    }
}