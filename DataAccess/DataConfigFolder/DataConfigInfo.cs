using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DataConfigFolder
{
    public enum DataConfigEnum
    {
        MailSystem,
        subjectemail,
        localhost,

        AllowTeamLeaderBorrowDevice,
        AllowApprovalBorrowDevice, //Khoa tinh nang approve 
        AllowTransferDevice, //khoa tinh nang transfer device
        AllowTransferAllMember,
        AllowTransferInTeam,
        AllowTransferInPart,
        AllowTransferInGroup,
        AllowTransferOverGroup,

        MailService,

        AllowBorrowDevice, //Khoa tinh nang borrow device
        AllowBorrowReturnDevice, //Khoa tinh nang borrow device da return

        AllowAllMemberCreateProject,
        AllowTeamLeaderCreateProject,
        AllowCreateProject,
        AllowAssignWorkArrangement
    }

    public class DataConfigInfo
    {
        public static List<DataConfig> GetDataConfig(DatabaseDataContext context, DataConfigEnum config)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    return context.DataConfigs.Where(x => x.DataKey == config.ToString()).ToList();
                }
            }
            catch (Exception)
            {
                return new List<DataConfig>();
            }
        }

        public static List<DataConfig> GetAll(DatabaseDataContext context)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    return context.DataConfigs.ToList();
                }
            }
            catch (Exception)
            {
                return new List<DataConfig>();
            }
        }

        public static bool HasRecord(DatabaseDataContext context, DataConfigEnum config, string value)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    return context.DataConfigs.SingleOrDefault(x => x.DataKey == config.ToString() && x.DataValue == value) != null;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
