using DataAccess.Db.CategoryDb;
using DataAccess.Db.Db;
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
                    context.tbCategories.InsertOnSubmit(new Db.CategoryDb.tbCategory()
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

        public static bool DeteteCategory(string name, int id)
        {
            try
            {
                using (var context = new CategoryDbFullDataContext())
                {
                    var user = context.tbUsers.FirstOrDefault(x => x.UserName.Equals(id));
                    if (user == null)
                        throw new Exception("Tài khoản không tồn tại");
                    if (user.tbTypeUser.Id != 1)
                        throw new Exception("Bạn không có quyền xóa chuyên mục");
                    var category = context.tbCategories.SingleOrDefault(x => x.Id == id);
                    if (category != null)
                    {
                        if (category.Id == 1)
                            throw new Exception("Không thể xóa chuyên mục này");
                        foreach (var item in category.tbSoftwares)
                        {
                            item.CategoryId = 1;
                        }
                        context.tbCategories.DeleteOnSubmit(category);
                        context.SubmitChanges();
                        return true;
                    }
                    else
                    {
                        throw new Exception("Không tìm thấy chuyên mục này");
                    }
                }
            }
            catch (Exception)
            {
            }
            return false;
        }
        public static Object getAllCategory(Db.CategoryDb.tbCategory y)
        {
            try
            {
                if (y.tbCategories.Count() != 0)
                {
                    return y.tbCategories.Select(x => new { x.Id, x.Name, x.ParentId, x.Description, Childrents = getAllCategory(x) });
                }
            }
            catch (Exception)
            {

            }
            return new List<Object>();
        }

        public static Object getCategory(int currentpage, int numberinpage, String keyword, ref int totalItem)
        {
            try
            {
                using (var context = new CategoryDbDataContext())
                {
                    var list = context.tbCategories.ToList();
                    if (!String.IsNullOrWhiteSpace(keyword))
                    {
                        keyword = keyword.ToLower().Trim();
                        list = list.Where(x => x.Name.ToLower().Contains(keyword)).ToList();
                    }
                    totalItem = list.Count();
                    return list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).Select(x => new { x.Id, x.Name, ParentId = x.ParentId.HasValue ? x.ParentId.Value : 0, ParentName = x.tbCategory1 != null ? x.tbCategory1.Name : "", x.Description });
                }
            }
            catch (Exception)
            {
            }
            totalItem = 0;
            return new List<Object>();
        }

    }
}
