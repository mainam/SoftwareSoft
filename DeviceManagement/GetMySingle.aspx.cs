using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore
{
    public partial class GetMySingle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string text = Request.QueryString["Url"];
                if (text != null)
                {
                    Form1.Action = HttpUtility.UrlDecode(text);
                }
                else
                {
                    Form1.Action = "Login.aspx";
                }
            }
        }
    }
}