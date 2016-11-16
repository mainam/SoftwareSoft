using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.HRFolder
{
  public  class MajorInfo
    {
      public static List<Major> GetAll()
      {
          try
          {
              var context=new DatabaseDataContext();
              return context.Majors.OrderByDescending(x=>x.ID).ToList();
          }
          catch (Exception)
          {
              return new List<Major>();
          }
      }
    }
}
