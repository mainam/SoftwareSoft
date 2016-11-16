using DataAccess;
using DataAccess.DataConfigFolder;
using DataAccess.DeviceFolder;
using DataAccess.LinkFolder;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.device.BorrowDevice
{
    public partial class Borrow : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (var context = new DatabaseDataContext())
            {

                var type = Request.QueryString["type"];
                if (type != "borrowreturndevice")
                {
                    if (!DeviceConfig.AllowBorrowDevice(context))
                    {
                        LinkInfo.RedirectError(Response, ErrorType.NotAllowBorrowDevice);
                        return;
                    }
                }
                else
                {
                    if (!DeviceConfig.AllowBorrowReturnDevice(context))
                    {
                        LinkInfo.RedirectError(Response, ErrorType.NotAllowBorrowDeviceHasReturn);
                        return;
                    }
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




                var from = HttpContext.Current.Session["txtFrom"];
                if (from != null)
                    startBorrow.Value = from.ToString();
                else
                    startBorrow.Value = DateTime.Now.ToString("MM/dd/yyyy");
                var to = HttpContext.Current.Session["txtTo"];
                if (to != null)
                    finishBorrow.Value = to.ToString();
                else
                    finishBorrow.Value = DateTime.Now.ToString("MM/dd/yyyy");
                var reason = HttpContext.Current.Session["txtReason"];
                if (reason != null)
                    txtReason.Value = reason.ToString();
            }
        }

        [WebMethod]
        public static string UpdateId(List<int> arrid, string txtFrom, string txtTo, string txtReason)
        {
            try
            {
                HttpContext.Current.Session["IDBorrow"] = arrid;
                HttpContext.Current.Session["txtFrom"] = txtFrom;
                HttpContext.Current.Session["txtTo"] = txtTo;
                HttpContext.Current.Session["txtReason"] = txtReason;

                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true });
            }
            catch (Exception)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
            }
        }


        [WebMethod]
        public static string Search(string keyword)
        {
            try
            {
                HttpContext.Current.Session["txtSearch"] = keyword;
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true });
            }
            catch
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
            }
        }


        [WebMethod]
        public static string borrow(List<int> listid, string from, string to, string reason)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (ApproveInfo.AddNewApproval(context, listid, username, Convert.ToDateTime(from), Convert.ToDateTime(to), reason, DataAccess.DeviceFolder.ApproveInfo.TypeApprove.ApproveBorrow))
                    {
                        EmptySession();
                        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true });
                    }
                    return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
        //public string GetAllDevices()
        //{
        //    try
        //    {
        //        List<DeviceInfo> listAllDevice = DeviceClass.GetAll();
        //        var jsonSerialiser = new JavaScriptSerializer();
        //        return jsonSerialiser.Serialize(listAllDevice);
        //    }
        //    catch (Exception)
        //    {
        //        return "";
        //    }

        //}

        [WebMethod]
        public static string GetDeviceSelected()
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var arrid = HttpContext.Current.Session["IDBorrow"] as List<int>;
                    var listdevice = DeviceInfo.GetByID(context, arrid);
                    return new JavaScriptSerializer().Serialize(new { Status = true, Data = listdevice });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false, Data = "[]" });
            }
        }
        public static void EmptySession()
        {
            try
            {
                HttpContext.Current.Session["IDBorrow"] = null;
                HttpContext.Current.Session["txtFrom"] = null;
                HttpContext.Current.Session["txtTo"] = null;
                HttpContext.Current.Session["txtReason"] = null;
            }
            catch (Exception)
            {
            }
        }


    }
}