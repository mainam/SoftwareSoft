using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DeviceFolder
{
    public class DataDevice
    {
        public int IDDevice { get; set; }
        public string Model { get; set; }
        public string Type { get; set; }
        public string CabinetName { get; set; }
        public int CabinetID { get; set; }
        public string Tag { get; set; }
        public string Project { get; set; }
        public string Manager { get; set; }
        public string Borrower { get; set; }
        public string Keeper { get; set; }
        public string NewKeeper { get; set; }
        public string BorrowDate { get; set; }
        public string ReturnDate { get; set; }
        public string KeepDate { get; set; }
        public string TransferDate { get; set; }
        public string Status { get; set; }
        public string IMEI { get; set; }
        public string Serial { get; set; }
        public string Region { get; set; }
        public string Version { get; set; }
        public string Receiver { get; set; }
        public string From { get; set; }
        public string ReceiveDate { get; set; }
        public string Note { get; set; }
        public string BorrowerNote { get; set; }
        public bool AllowBorrow { get; set; }


        public DataDevice()
        { }

        string GetFullname(string name)
        {
            try
            {
                if (name == null)
                    return "";
                var a = name.Split('/');
                return a[1];
            }
            catch (Exception)
            {
                return name;
            }

        }

        public string FullNameManager
        {
            get
            {
                return GetFullname(Manager);
            }
        }
        public string FullNameBorrower
        {
            get
            {
                return GetFullname(Borrower);
            }
        }
        public string FullNameKeeper
        {
            get
            {
                return GetFullname(Keeper);
            }
        }
        public string FullNameNewKeeper
        {
            get
            {
                return GetFullname(NewKeeper);
            }
        }


        public DataDevice(Device device)
        {
            this.IDDevice = device.IDDevice;
            this.Type = device.DeviceModel.CategoryDevice.Name;
            this.Tag = device.Tag;
            this.Model = device.Model;
            this.Version = device.Version;
            this.Manager = (device.Manager + "/" + device.User.FullName);
            this.Borrower = device.Borrower == null ? "" : (device.Borrower + "/" + device.User3.FullName);
            this.Keeper = device.Keeper == null ? "" : (device.Keeper + "/" + device.User1.FullName);
            this.NewKeeper = device.NewKeeper == null ? "" : (device.NewKeeper + "/" + device.User4.FullName);

            this.BorrowDate = device.BorrowDate.HasValue ? device.BorrowDate.Value.ToString("MM/dd/yyyy") : "";
            this.ReturnDate = device.ReturnDate.HasValue ? device.ReturnDate.Value.ToString("MM/dd/yyyy") : "";
            this.KeepDate = device.KeepDate.HasValue ? device.KeepDate.Value.ToString("MM/dd/yyyy") : "";
            this.TransferDate = device.TransferDate.HasValue ? device.TransferDate.Value.ToString("MM/dd/yyyy") : "";
            this.Status = device.Status.Name;
            this.IMEI = device.IMEI;
            this.Serial = device.Serial;
            this.Region = device.Region;
            this.Receiver = (device.Receiver + "/" + device.User2.FullName); ;
            this.From = device.From_ != null ? device.From_.Replace("\n", "") : "";
            this.ReceiveDate = device.ReceiveDate.HasValue ? device.ReceiveDate.Value.ToString("MM/dd/yyyy") : "";
            this.Project = device.Project != null ? device.Project.Replace("\n", "") : "";
            this.Note = device.Note != null ? device.Note.Replace("\n", "") : "";
            this.CabinetID = device.Cabinet == null ? 0 : device.Cabinet.Value;
            this.CabinetName = device.Cabinet == null ? "" : device.Cabinet1.Name;
            this.AllowBorrow = true;
            this.BorrowerNote = device.BorrowerNote;
        }


        public DataDevice(int IDDevice, string Type, string Tag, string Model, string Version, string Project, string Manager, string Borrower, string Keeper, string BorrowDate, string ReturnDate, string Status, string IMEI, string Serial, string Region, string Receiver, string ReceiveDate, string From, string Note, bool AllowBorrow, int cabinetid, string cabinetname, string borrowernote)
        {
            this.IDDevice = IDDevice;
            this.Type = Type;
            this.Tag = Tag;
            this.Model = Model;
            this.Version = Version;
            this.Manager = Manager;
            this.Borrower = Borrower;
            this.Keeper = Keeper;
            this.BorrowDate = BorrowDate;
            this.ReturnDate = ReturnDate;
            this.Status = Status;
            this.IMEI = IMEI;
            this.Serial = Serial;
            this.Region = Region;
            this.Receiver = Receiver;
            this.From = From;
            this.ReceiveDate = ReceiveDate;
            this.Project = Project;
            this.Note = Note;
            this.AllowBorrow = AllowBorrow;
            this.CabinetID = cabinetid;
            this.CabinetName = cabinetname;
            this.BorrowerNote = borrowernote;
        }

        public override bool Equals(object obj)
        {
            var device = obj as DataDevice;
            return obj != null && Type == device.Type && Tag == device.Tag && Model == device.Model;
        }

    }
}
