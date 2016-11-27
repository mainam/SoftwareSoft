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

namespace SoftwareStore.Admin.SanPham
{
    public partial class SanPhamCuaToi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetListUser(string keyword, int currentpage, int numberinpage, int type)
        {
            try
            {
                int totalitem = 0;
                var data = UserInfo.getAll(HttpContext.Current.User.Identity.Name, type, currentpage, numberinpage, keyword, ref totalitem);
                return Converts.Serialize(new { Status = true, Data = data, TotalItem = totalitem });
            }
            catch (Exception)
            {
                return Converts.Serialize(new { Status = false });
            }
        }
        [WebMethod]
        public static string ActiveUser(String id)
        {
            try
            {
                if (id.Equals(HttpContext.Current.User.Identity.Name))
                    throw new Exception("Bạn không thể tự active tài khoản của mình");
                var user = UserInfo.ActiveMember(HttpContext.Current.User.Identity.Name, id);

                return Converts.Serialize(new { Status = true, Data = user.Active ? "Kích hoạt tài khoản thành công" : "Hủy kích hoạt tài khoản thành công" });
            }
            catch (Exception e)
            {
                return Converts.Serialize(new { Status = false, Data = e.Message });
            }
        }
        [WebMethod]
        public static string MakeATransaction(String username, decimal value, string description, int type)
        {
            try
            {
                if (type == 1)
                    TransactionInfo.AddTransaction(HttpContext.Current.User.Identity.Name, HttpContext.Current.User.Identity.Name, username, description, value, 1);
                else
                    TransactionInfo.AddTransaction(HttpContext.Current.User.Identity.Name, username, HttpContext.Current.User.Identity.Name, description, value, 1);
                return Converts.Serialize(new { Status = true, Data = "Tạo giao dịch thành công" });
            }
            catch (Exception e)
            {
                return Converts.Serialize(new { Status = false, Data = e.Message });
            }
        }


        [WebMethod]
        public static string DeleteUser(List<String> arrid)
        {
            try
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = UserInfo.DeteteUser(HttpContext.Current.User.Identity.Name, arrid) });
            }
            catch (Exception e)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false, Data = e.Message });
            }
        }

        [WebMethod]
        public static string CreateNew(int type, bool isedit, string username, string fullname, string password, string email, string phonenumber, bool active)
        {
            try
            {
                UserInfo.CreateNew(HttpContext.Current.User.Identity.Name, isedit, type, username, fullname, password, email, phonenumber, active);
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true, Data = isedit ? "Chỉnh sửa thành công" : "Thêm mới tài khoản thành công" });
            }
            catch (Exception e)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false, Data = e.Message });
            }
        }


    }
}