using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DeviceManagement
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<object> list = new List<object> { 1, 23, 4, 5, 6, 7, 8, 9, 54435, 45234, 2345, 2435, 24352, 3542, 3452, 3452, 3452, 3452, 34523, 4 };
                repListSoftware.DataSource = list;
                repListSoftware.DataBind();
            }
        }
    }
}