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

        
    }
}
