using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DataAccess.UtilFolder;
using System.Web.Services;
using DataAccess;

namespace SoftwareStore.Admin.ChuyenMuc.Dialog
{
    public partial class AddChuyenMuc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String _id = Request.QueryString["id"];
            int id = Converts.ToInt(_id, 0);
            if (id == 0)
                title.InnerHtml = "THÊM CHUYÊN MỤC";
            else
                title.InnerHtml = "CHỈNH SỬA CHUYÊN MỤC";
            cbListCategory.DataSource = CategoryInfo.getCategory(id);
            cbListCategory.DataTextField = "Name";
            cbListCategory.DataValueField = "Id";
            cbListCategory.DataBind();

        }

    }
}