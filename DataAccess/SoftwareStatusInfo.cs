using DataAccess.Db.Product.ProductDbFull;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class SoftwareStatusInfo
    {
        public static object getAll()
        {
            using (var context = new ProductDbFullDataContext())
            {
                return context.tbSoftwaraStatus.Select(x => new { x.Name, x.Id }).ToList();
            }
        }
    }
}
