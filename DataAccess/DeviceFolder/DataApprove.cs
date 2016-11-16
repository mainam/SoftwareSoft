using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DeviceFolder
{
    public class DataApprove
    {
        public int IDApprove { get; set; }
        public int IDDevice { get; set; }
        public string Type { get; set; }
        public string TagDevice { get; set; }
        public string Model { get; set; }
        public string Serial { get; set; }
        public string IMEI { get; set; }

        public string SubmitDate { get; set; }
        public string StartDate { get; set; }
        public string EndDate { get; set; }
        public string UserBorrow { get; set; }
        public string Manager { get; set; }
        public string Borrower { get; set; }
        public string StatusManager { get; set; }
        public string StatusKeeper { get; set; }
        public string Reason { get; set; }
        public string StatusBorrow { get; set; }
        public string StatusDevice { get; set; }
        public bool AllowShowManager { get; set; }
        public bool AllowShowKeeper { get; set; }
        public DataApprove()
        {

        }



        public DataApprove(int IDApprove, int IDDevice, string Type, string TagDevice, string Model, string IMEI, string Serial, string SubmitDate, string StartDate, string EndDate, string UserBorrow, string Manager, string Borrower, string StatusManager, string StatusKeeper, string Reason, string StatusBorrow, string StatusDevice, bool AllowShowKeeper, bool AllowShowManager)
        {
            this.Type = Type;
            this.IDApprove = IDApprove;
            this.IDDevice = IDDevice;
            this.TagDevice = TagDevice;
            this.Model = Model;
            this.SubmitDate = SubmitDate;
            this.StartDate = StartDate;
            this.EndDate = EndDate;
            this.UserBorrow = UserBorrow;
            this.Manager = Manager;
            this.Borrower = Borrower;
            this.StatusManager = StatusManager;
            this.StatusKeeper = StatusKeeper;
            this.Reason = Reason;
            this.StatusBorrow = StatusBorrow;
            this.StatusDevice = StatusDevice;
            this.AllowShowKeeper = AllowShowKeeper;
            this.AllowShowManager = AllowShowManager;
            this.IMEI = IMEI;
            this.Serial = Serial;
        }

        public DataApprove(Approve x)
        {
            this.Type = x.Device.DeviceModel.CategoryDevice.Name;
            this.IDApprove = x.IDApprove;
            this.IDDevice = x.IDDevice;
            this.TagDevice = x.Device.Tag;
            this.Model = x.Device.Model;
            this.SubmitDate = x.SubmitDate.ToShortDateString();
            this.StartDate = x.StartDate.ToShortDateString();
            this.EndDate = x.EndDate.ToShortDateString();
            this.UserBorrow = x.UserBorrow + "/" + x.User.FullName;
            this.Manager = x.Manager;
            this.Borrower = x.Borrower;
            this.StatusManager = x.Borrower == null ? x.StatusApproval.Name : x.StatusApproval1.Name;
            this.StatusKeeper = x.StatusApproval1.Name;
            this.Reason = x.Reason;
            this.StatusBorrow = x.StatusBorrow1.Name;
            this.StatusDevice = x.Status.Name;
            this.AllowShowKeeper = x.AllowShowKeeper;
            this.AllowShowManager = x.AllowShowManager;
            this.IMEI = x.Device.IMEI;
            this.Serial = x.Device.Serial;
        }
    }
}
