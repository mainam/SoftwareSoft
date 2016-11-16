using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.HRFolder
{
    public class EducationLevelInfo
    {
        public static List<EducationLevel> GetAll()
        {
            try
            {
                var context = new DatabaseDataContext();
                return context.EducationLevels.OrderByDescending(x => x.ID).ToList();
            }
            catch (Exception)
            {
                return new List<EducationLevel>();
            }
        }
    }
}
