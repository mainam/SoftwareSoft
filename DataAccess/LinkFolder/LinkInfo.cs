using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace DataAccess.LinkFolder
{
    public enum ErrorType
    {
        NotAllowApprovalDevice, //khoa chuc nang approval device
        NotAllowBorrowDevice, //khoa chuc nang muon device
        NotAllowBorrowDeviceHasReturn, //khoa chuc nang muon device da tra
        NotAcceptUserBorrowDevice, //khong cho use muon device
        NotAllowUserTransferDevice

    }



    public class LinkInfo
    {

        public static string LinkViewTask(int id)
        {
            return "/#mgrTask/viewtask.aspx?taskid=" + id;
        }

        public static string LinkViewTask(object id)
        {
            return "/#mgrTask/viewtask.aspx?taskid=" + id.ToString();
        }

        public static string LinkViewIdea(int id)
        {
            return "/#innovation/viewidea.aspx?ideaid=" + id;
        }

        public static string LinkApprovePage()
        {
            return "/#device/MyApprove/ApproveGroupByModel.aspx";
        }

        //public static string ListBorrowing()
        //{
        //    return "/#device/MyApprove/ApproveGroupByModel.aspx";
        //}

        public static void RedirectNotAllowCreateProject(HttpResponse httpresponse)
        {
            RedirectError(httpresponse, "~/home/error404.html");
        }

        public static void RedirectError(HttpResponse httpresponse, ErrorType errortype)
        {
            RedirectError(httpresponse, "~/home/error.aspx?type=" + errortype.ToString());
        }

        //public static void RedirectNotAllowBorrow(HttpResponse httpresponse)
        //{
        //    RedirectError(httpresponse, "~/home/error.aspx?type=NotAllowBorrowDevice");
        //}

        //public static void RedirectNotAllowBorrowDeviceHasReturn(HttpResponse httpresponse)
        //{
        //    RedirectError(httpresponse, "~/home/error.aspx?type=NotAllowBorrowDevice");
        //}

        public static void RedirectError(HttpResponse httpresponse)
        {
            RedirectError(httpresponse, "~/home/error404.html");
        }
        public static void RedirectError(HttpResponse httpresponse, string link)
        {
            httpresponse.Redirect(link);
        }
        public static void RedirectDialogError(HttpResponse httpresponse, ErrorType errortype)
        {
            RedirectError(httpresponse, "~/home/dialogerror.aspx?type=" + errortype.ToString());
        }

    }
}
