using DataAccess;
using DataAccess.UserFolder;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.Admin.GiaoDich
{
    public partial class TatCaGiaoDich : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetListTransaction(string keyword, int currentpage, int numberinpage)
        {
            try
            {
                int totalitem = 0;
                var data = TransactionInfo.GetAll(HttpContext.Current.User.Identity.Name,currentpage, numberinpage, keyword, ref totalitem);
                return Converts.Serialize(new { Status = true, Data = data, TotalItem = totalitem });
            }
            catch (Exception e)
            {
                return Converts.Serialize(new { Status = false, Data = e.Message });
            }
        }       
    }
}