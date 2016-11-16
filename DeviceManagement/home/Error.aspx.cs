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
    public partial class Error : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            var type = Request.QueryString["type"];
            if (type != null)
            {
                ErrorType _type = Converts.ToEnum<ErrorType>(type);
                switch (_type)
                {
                    case ErrorType.NotAllowBorrowDevice:
                        errortype.InnerHtml = "Access Denied";
                        errorname.InnerHtml = "KHÓA MƯỢN DEVICE";
                        message.InnerHtml = "Hiện tại chức năng mượn device tạm ĐÓNG. Bạn không thể truy cập vào mượn device. Hãy thử mượn những device đã trả <a href='#device/BorrowDevice/BorrowDeviceHaveReturn.aspx'>tại đây</a>. Vui lòng liên hệ <a href='mysingleim://ngoc.nam@samsung.com'>ngoc.nam</a> hoặc  <a href='mysingleim://kim.yen@samsung.com'>kim.yen</a> để biết thêm thông tin.";
                        break;
                    case ErrorType.NotAllowBorrowDeviceHasReturn:
                        errortype.InnerHtml = "Access Denied";
                        errorname.InnerHtml = "KHÓA MƯỢN DEVICE ĐÃ TRẢ";
                        message.InnerHtml = "Hiện tại chức năng mượn device đã trả tạm đóng. Bạn không thể truy cập vào mượn device. Vui lòng liên hệ <a href='mysingleim://ngoc.nam@samsung.com'>ngoc.nam</a> hoặc  <a href='mysingleim://kim.yen@samsung.com'>kim.yen</a> để biết thêm thông tin.";
                        break;
                    case ErrorType.NotAcceptUserBorrowDevice:
                        errortype.InnerHtml = "Access Denied";
                        errorname.InnerHtml = "CẦN QUYỀN TRUY CẬP MƯỢN DEVICE";
                        message.InnerHtml = "Bạn chưa có quyền mượn device. Vui lòng liên hệ <a href='mysingleim://ngoc.nam@samsung.com'>ngoc.nam</a> hoặc  <a href='mysingleim://kim.yen@samsung.com'>kim.yen</a> để biết thêm thông tin.";
                        break;
                    case ErrorType.NotAllowApprovalDevice:
                        errortype.InnerHtml = "Access Denied";
                        errorname.InnerHtml = "KHÓA CHỨC NĂNG PHÊ DUYỆT MƯỢN DEVICE";
                        message.InnerHtml = "Hiện tại chức năng phê duyệt device đã trả tạm đóng. Bạn không thể truy cập. Vui lòng liên hệ <a href='mysingleim://ngoc.nam@samsung.com'>ngoc.nam</a> hoặc  <a href='mysingleim://kim.yen@samsung.com'>kim.yen</a> để biết thêm thông tin.";
                        break;
                }
                return;
            }
        }
    }
}