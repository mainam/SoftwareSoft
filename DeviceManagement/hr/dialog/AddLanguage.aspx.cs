using DataAccess.HRFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.hr.dialog
{
    public partial class AddLanguage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var listlanguage = DataLanguageInfo.GetAll();
            txtLanguage.DataSource = listlanguage;
            txtLanguage.DataTextField = "Name";
            txtLanguage.DataValueField = "ID";
            txtLanguage.DataBind();
        }
    }
}