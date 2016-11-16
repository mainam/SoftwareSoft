using DataAccess.UserFolder;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DataConfigFolder
{
    public class ProjectConfig
    {
        public static bool AllowTeamLeaderCreateProject(DatabaseDataContext context)
        {
            try
            {
                var data = DataConfigInfo.GetDataConfig(context, DataConfigEnum.AllowTeamLeaderCreateProject);
                return Convert.ToBoolean(data.First().DataValue);
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool AllowAddProject(DatabaseDataContext context, string username)
        {
            try
            {
                var list = context.DataConfigs.Where(x => x.DataKey == DataConfigEnum.AllowCreateProject.ToString()
                    || x.DataKey == DataConfigEnum.AllowAllMemberCreateProject.ToString()
                    || x.DataKey == DataConfigEnum.AllowTeamLeaderCreateProject.ToString()).ToList();

                if (list.SingleOrDefault(x => x.DataKey == DataConfigEnum.AllowAllMemberCreateProject.ToString() && Converts.ToBool(x.DataValue)) != null)
                    return true;

                if (list.SingleOrDefault(x => x.DataKey == DataConfigEnum.AllowCreateProject.ToString() && x.DataValue == username) != null)
                    return true;

                if (list.SingleOrDefault(x => x.DataKey == DataConfigEnum.AllowTeamLeaderCreateProject.ToString() && Converts.ToBool(x.DataValue)) != null && UserInfo.IsAdmin(context, username))
                    return true;
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
