using DataAccess;
using DataAccess.HRFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.hr.dialog
{
    public partial class AddEducation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var listeducationlevel = EducationLevelInfo.GetAll();
            txtEducationLevel.DataSource = listeducationlevel;
            txtEducationLevel.DataTextField = "Level";
            txtEducationLevel.DataValueField = "ID";
            txtEducationLevel.DataBind();

            var listmajor = MajorInfo.GetAll();
            txtMajor.DataSource = listmajor;
            txtMajor.DataTextField = "Name";
            txtMajor.DataValueField = "ID";
            txtMajor.DataBind();

            var listschool = UniversityInfo.GetAll();
            txtSchool.DataSource = listschool;
            txtSchool.DataTextField = "Name";
            txtSchool.DataValueField = "ID";
            txtSchool.DataBind();
        }
    }
}