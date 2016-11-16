using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.HRFolder
{
    public class DataLanguageInfo
    {
        public static List<DataLanguage> GetAll()
        {
            try
            {
                var context = new DatabaseDataContext();
                return context.DataLanguages.OrderByDescending(x => x.ID).ToList();
            }
            catch (Exception)
            {
                return new List<DataLanguage>();
            }
        }
    }
}
