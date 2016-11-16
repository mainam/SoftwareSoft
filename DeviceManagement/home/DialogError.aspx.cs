using DataAccess.LinkFolder;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.home
{
    public partial class DialogError : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var type = Request.QueryString["type"];
            if (type != null)
            {
                ErrorType _type = Converts.ToEnum<ErrorType>(type);
                switch (_type)
                {
                    case ErrorType.NotAllowUserTransferDevice:
                        spanTitle.InnerHtml = "KHOÁ TRANSFER DEVICE";
                        errorcontent.InnerHtml = "Hiện tại chức năng transfer device tạm ĐÓNG. Vui lòng liên hệ <a href='mysingleim://ngoc.nam@samsung.com'>ngoc.nam</a> hoặc  <a href='mysingleim://kim.yen@samsung.com'>kim.yen</a> để biết thêm thông tin.";
                        break;
                    default:
                        spanTitle.InnerHtml = "Access Denied";
                        errorcontent.InnerHtml = "Bạn không thể truy cập vào tính năng này. Vui lòng liên hệ <a href='mysingleim://ngoc.nam@samsung.com'>ngoc.nam</a> hoặc  <a href='mysingleim://kim.yen@samsung.com'>kim.yen</a> để biết thêm thông tin.";
                        break;
                }
                return;
            }
        }
    }
}