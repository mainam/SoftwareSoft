using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DataAccess.UtilFolder;
using System.Web.Services;
using DataAccess;

namespace SoftwareStore.Admin.TaiKhoan.Dialog
{
    public partial class TaoTaiKhoan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String _id = Request.QueryString["id"];
            int id = Converts.ToInt(_id, 0);
            if (id == 0)
            {
                title.InnerText = "THÊM TÀI KHOẢN MỚI";
            }
            else
            {
                title.InnerText = "CHỈNH SỬA TÀI KHOẢN";
                inputPassword.InnerText = "Mật khẩu (để trống nếu không muốn thay đổi)";
            }
        }

    }
}