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

namespace SoftwareStore.Admin.TaiKhoan
{
    public partial class TaiKhoanMgr : System.Web.UI.Page
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
                var user = UserInfo.ActiveMember(HttpContext.Current.User.Identity.Name, id);

                return Converts.Serialize(new { Status = true, Data = user.Active ? "Kích hoạt tài khoản thành công" : "Hủy kích hoạt tài khoản thành công" });
            }
            catch (Exception e)
            {
                return Converts.Serialize(new { Status = false, Data = e.Message });
            }
        }


        [WebMethod]
        public static string DeleteCategory(List<int> arrid)
        {
            try
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = CategoryInfo.DeteteCategory(HttpContext.Current.User.Identity.Name, arrid) });
            }
            catch (Exception e)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false, Data = e.Message });
            }
        }

        [WebMethod]
        public static string AddCategory(int id, string name, string description, int order, int parent)
        {
            try
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = CategoryInfo.AddCategory(HttpContext.Current.User.Identity.Name, id, name, description, order, parent) });
            }
            catch (Exception e)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false, Data = e.Message });
            }
        }

    }
}