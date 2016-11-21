using DataAccess.Db.CategoryDb;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class CategoryInfo
    {
        public static bool addCategory(int parentId, String categoryName, String description)
        {
            try
            {
                using (var context = new CategoryDbDataContext())
                {
                    context.tbCategories.InsertOnSubmit(new tbCategory()
                    {
                       
                        Name = categoryName,
                        Description = description,
                        ParentId = parentId
                    });
                    context.SubmitChanges();
                    return true;

                }
            }
            catch (Exception)
            {

            }
            return false;

        }

        public static Object getAllCategory()
        {
            try
            {
                using (var context = new CategoryDbDataContext())
                {
                    return context.tbCategories.Where(x => x.ParentId == null).Select(x => new
                    {
                        x.Id,
                        x.Name,
                        ParentId = 0,
                        x.Description,
                        Childrents = getAllCategory(x)
                    });

                }
            }
            catch (Exception)
            {

            }
            return new List<Object>();
        }

        private static object getAllCategory(tbCategory y)
        {
            try
            {
                if(y.tbCategories.Count()!=0)
                {
                    return y.tbCategories.Select(x => new { x.Id, x.Name, x.ParentId, x.Description, Childrents = getAllCategory(x) });
                } 
            }
            catch (Exception)
            {

            }
            return new List<Object>();
        }
    }
}
