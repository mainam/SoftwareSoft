using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class JobTitleInfo
    {
        public static List<JobTitle> GetAll()
        {
            try
            {
                var context = new DatabaseDataContext();
                return context.JobTitles.ToList();
            }
            catch (Exception)
            {
                return new List<JobTitle>();
            }
        }
    }
}
