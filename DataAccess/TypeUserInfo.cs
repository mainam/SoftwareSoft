using DataAccess.Db.UserType.UserTypeDb;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class TypeUserInfo
    {
        public static object GetAll()
        {
            try
            {
                using (var context = new UserTypeDbDataContext())
                {
                    return context.tbTypeUsers.Select(x => new { x.Id, x.Name }).ToList();
                }
            }
            catch (Exception)
            {
                return new List<Object>();
            }
        }
    }
}
