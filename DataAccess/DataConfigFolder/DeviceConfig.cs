using DataAccess.DataConfigFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DataConfigFolder
{
    public class DeviceConfig
    {
        public static bool AllowTeamLeaderBorrowDevice(DatabaseDataContext context)
        {
            try
            {
                var data = DataConfigInfo.GetDataConfig(context, DataConfigEnum.AllowTeamLeaderBorrowDevice);
                return Convert.ToBoolean(data.First().DataValue);
            }
            catch (Exception)
            {
                return false;
            }

        }

        public static bool AllowApprovalDevice(DatabaseDataContext context)
        {
            try
            {
                var data = DataConfigInfo.GetDataConfig(context, DataConfigEnum.AllowApprovalBorrowDevice);
                return Convert.ToBoolean(data.First().DataValue);
            }
            catch (Exception)
            {
                return false;
            }

        }

        public static bool AllowBorrowDevice(DatabaseDataContext context)
        {
            try
            {
                var data = DataConfigInfo.GetDataConfig(context, DataConfigEnum.AllowBorrowDevice);
                return Convert.ToBoolean(data.First().DataValue);
            }
            catch (Exception)
            {
                return false;
            }

        }

        public static bool AllowBorrowReturnDevice(DatabaseDataContext context)
        {
            try
            {
                var data = DataConfigInfo.GetDataConfig(context, DataConfigEnum.AllowBorrowReturnDevice);
                return Convert.ToBoolean(data.First().DataValue);
            }
            catch (Exception)
            {
                return false;
            }

        }

        public static bool AllowTransferDevice(DatabaseDataContext context)
        {
            try
            {
                var data = DataConfigInfo.GetDataConfig(context, DataConfigEnum.AllowTransferDevice);
                return Convert.ToBoolean(data.First().DataValue);
            }
            catch (Exception)
            {
                return false;
            }

        }
    }
}
