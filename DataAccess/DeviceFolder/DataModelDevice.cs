using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DeviceFolder
{
    public class DataModelDevice
    {
        public string ID;
        public string ModelName;
        public string Manager;
        public string Type;
        public string Company;
        public int Available;
        public int Borrowed;
        public int YouBorrow;
        public int PendingApproval;
        public DataModelDevice()
        {
        }

        public DataModelDevice(Device device, int Available, int Borrowed, int YouBorrow, int PendingApproval)
        {
            ID = device.DeviceModel.ModelName;
            this.Available = Available;
            this.Borrowed = Borrowed;
            this.YouBorrow = YouBorrow;
            this.PendingApproval = PendingApproval;
            this.ModelName = device.Model;
            this.Manager = device.Manager + "/" + device.User.FullName;
            this.Type = device.DeviceModel.CategoryDevice.Name;
            this.Company = device.DeviceModel.Company;
        }

    }
}
