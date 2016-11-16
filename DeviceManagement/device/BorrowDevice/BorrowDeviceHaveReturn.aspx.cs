using DataAccess.DeviceFolder;
using DataAccess.UserFolder;
using DataAccess;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess.LinkFolder;
using DataAccess.DataConfigFolder;

namespace SoftwareStore.device.BorrowDevice
{
    public partial class BorrowDeviceHaveReturn : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {
                if (!DeviceConfig.AllowBorrowReturnDevice(context))
                {
                    LinkInfo.RedirectError(Response, ErrorType.NotAllowBorrowDeviceHasReturn);
                    return;
                }

                var username = HttpContext.Current.User.Identity.Name;
                User user = null;
                if (username != null)
                    user = UserInfo.GetByID(context, username);

                if (user == null)
                {
                    Response.Redirect(string.Format("~/Login.aspx?"));
                }
                else
                {
                    if (!UserInfo.AllowBorrowDevice(context, user))
                        LinkInfo.RedirectError(Response, ErrorType.NotAcceptUserBorrowDevice);
                }


                var txtSearch = HttpContext.Current.Session["txtSearch"];
                HttpContext.Current.Session["txtSearch"] = "";
                if (txtSearch != null)
                    inputSearch.Value = txtSearch.ToString();
            }
        }

        [WebMethod]
        public static string LoadData(string keyword, int type, int currentpage, int numberinpage, int status)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (keyword != null) keyword = keyword.ToLower();
                    var _listignore = HttpContext.Current.Session["IDBorrow"];
                    var listignore = new List<int>();
                    try
                    {
                        if (_listignore != null)
                            listignore = _listignore as List<int>;
                    }
                    catch (Exception)
                    {
                    }

                    int totalitem = 0;
                    var myList = DeviceInfo.GetListDeviceHaveReturn(context, username, type, status, keyword.ToLower(), currentpage, numberinpage, ref totalitem, ApproveInfo.TypeApprove.ApproveBorrow, listignore);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = myList, TotalItem = totalitem });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }

        }

        [WebMethod]
        public static void PostId(List<int> arrid)
        {
            try
            {
                var temp = HttpContext.Current.Session["IDBorrow"];
                List<int> temp1 = temp as List<int>;
                if (temp != null)
                    foreach (int x in temp1)
                    {
                        if (!arrid.Contains(x))
                            arrid.Add(x);
                    }
                HttpContext.Current.Session["IDBorrow"] = arrid;
            }
            catch (Exception)
            {
            }
        }
    }
}