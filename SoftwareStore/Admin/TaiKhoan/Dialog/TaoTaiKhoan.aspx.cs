using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DataAccess.UtilFolder;
using System.Web.Services;
using DataAccess;
using DataAccess.UserFolder;

namespace SoftwareStore.Admin.TaiKhoan.Dialog
{
    public partial class TaoTaiKhoan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String id = Request.QueryString["id"];
            if (id == "")
            {
                title.InnerText = "THÊM TÀI KHOẢN MỚI";
            }
            else
            {
                title.InnerText = "CHỈNH SỬA TÀI KHOẢN";
                inputPassword.InnerText = "Mật khẩu (để trống nếu không muốn thay đổi)";
                txtUserName.Disabled = true;
                var user = UserInfo.GetById(id);
                if(user!=null)
                {
                    txtFullName.Value = user.FullName;
                    txtEmail.Value = user.Email;
                    txtPhoneNumber.Value = user.Phone;
                    txtUserName.Value = user.UserName;
                    chkActive.Checked = user.Active;                   
                }
            }
        }

    }
}