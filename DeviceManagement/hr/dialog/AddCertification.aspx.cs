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
    public partial class AddCertification : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var listcertification = DataCertificationInfo.GetAll();
            txtCertification.DataSource = listcertification;
            txtCertification.DataTextField = "Name";
            txtCertification.DataValueField = "ID";
            txtCertification.DataBind();
        }
    }
}