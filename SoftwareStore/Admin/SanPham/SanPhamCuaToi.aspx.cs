﻿using DataAccess;
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
        public static string GetListProduct(string keyword, int currentpage, int numberinpage, int type)
        {
            try
            {
                int totalitem = 0;
                var data = ProductInfo.GetBySeller(HttpContext.Current.User.Identity.Name, type, currentpage, numberinpage, keyword, ref totalitem);
                return Converts.Serialize(new { Status = true, Data = data, TotalItem = totalitem });
            }
            catch (Exception)
            {
                return Converts.Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static string DeleteProduct(List<int> arrid)
        {
            try
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = ProductInfo.DeleteProduct(HttpContext.Current.User.Identity.Name, arrid) });
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