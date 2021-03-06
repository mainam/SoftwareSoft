﻿using DataAccess;
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