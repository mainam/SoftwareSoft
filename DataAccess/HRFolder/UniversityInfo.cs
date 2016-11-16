using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.HRFolder
{
    public class UniversityInfo
    {
        public static List<University> GetAll()
        {
            try
            {
                var context = new DatabaseDataContext();
                return context.Universities.OrderByDescending(x => x.ID).ToList();
            }
            catch (Exception)
            {
                return new List<University>();
            }
        }
    }
}
