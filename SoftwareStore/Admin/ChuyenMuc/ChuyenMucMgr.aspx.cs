using DataAccess;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.Admin.ChuyenMuc
{
    public partial class ChuyenMucMgr : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetListCategory(string keyword, int currentpage, int numberinpage)
        {
            try
            {
                int totalitem = 0;
                var data = CategoryInfo.getCategory(currentpage, numberinpage, keyword, ref totalitem);
                return Converts.Serialize(new { Status = true, Data = data, TotalItem = totalitem });
            }
            catch (Exception)
            {
                return Converts.Serialize(new { Status = false });
            }
        }


        [WebMethod]
        public static string DeleteCategory(int id)
        {
            try
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = CategoryInfo.DeteteCategory(HttpContext.Current.User.Identity.Name, id) });
            }
            catch (Exception e)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false, Data = e.Message });
            }
        }

    }
}