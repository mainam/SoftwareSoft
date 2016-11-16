using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DeviceFolder
{
    public class StatusDeviceInfo
    {
        public static List<Status> GetAll(DatabaseDataContext context)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    return context.Status.ToList();
                }
            }
            catch (Exception)
            {
                return new List<Status>();
            }
        }
    }
}
