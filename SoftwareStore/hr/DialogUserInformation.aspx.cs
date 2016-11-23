using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess;
using DataAccess.UserFolder;
namespace SoftwareStore.hr
{
    public partial class DialogUserInformation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = Request.QueryString["user"];
                    var user = UserInfo.GetByID(context, username);
                    if (user != null)
                    {
                        lbFullName.InnerText = user.FullName;
                        imgAvatar.Src = UserInfo.GetAvatar(user);
                        lbBirthday.InnerText = user.Birthday.ToShortDateString();
                        lbJobTitle.InnerText = user.JobTitle.JobName;
                        lbTeam.InnerText = user.Team.TeamName;
                        lbSingleID.InnerText = user.UserName;
                        lbGenNumber.InnerText = user.GEN;
                        lbGender.InnerText = user.Gender;
                        lbPhone.InnerText = user.PhoneNumber;
                        lbLeader.InnerText = user.Team.Leader == user.UserName ? "" : user.Team.Leader == null ? "" : user.Team.Leader;
                        lbDateJoinSel.InnerText = user.DateJoiningSEL.ToShortDateString();
                        lbAddress.InnerText = user.Address != null ? user.Address : "";//.DateJoiningSEL.ToShortDateString();
                        lbJobDescription.InnerText = user.JobDescription;
                        lbToeicScore.InnerText = user.ToeicScore.ToString();
                        lbSTCScore.InnerText = user.STCLevel.ToString();

                    }
                    else
                    {
                        Response.Redirect("/home/error404.html");
                    }
                }
            }
        }
    }
}