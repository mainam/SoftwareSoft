using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.HRFolder
{
    public class DataCertificationInfo
    {
        public static List<DataCertification> GetAll()
        {
            try
            {
                var context = new DatabaseDataContext();
                return context.DataCertifications.OrderByDescending(x => x.ID).ToList();
            }
            catch (Exception)
            {
                return new List<DataCertification>();
            }
        }
    }
}
