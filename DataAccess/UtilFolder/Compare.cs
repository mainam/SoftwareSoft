using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.UtilFolder
{
    public class Compare
    {
        public static bool cmpDate(DateTime a, DateTime b)
        {
            try
            {
                return a.Year == b.Year && a.Month == b.Month && b.Date == a.Date;
            }
            catch (Exception)
            {
                return false;
            }
        }
        public static bool cmpDate(object a, object b)
        {
            try
            {
                return cmpDate(Convert.ToDateTime(a), Convert.ToDateTime(b));
            }
            catch (Exception)
            {
                return false;
            }
        }
        public static bool cmpObject(object a, object b)
        {
            try
            {
                if (a == null && b == null) return true;
                return a.ToString().Equals(b.ToString());
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static int CompareDate(DateTime a, DateTime b)
        {
            try
            {
                if (a.Year == b.Year && a.Month == b.Month && b.Date == a.Date)
                    return 0;
                return (a - b).TotalDays > 0 ? 1 : -1;
            }
            catch (Exception)
            {
                throw new Exception("Cannot compare data");
            }
        }

       

    }
}
