using DataAccess.Db.Category.CategoryDb;
using DataAccess.Db.Category.CategoryDbFull;
using System;
using System.Collections.Generic;
using System.Linq;

namespace DataAccess
{
    public class CategoryInfo
    {

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

        public static List<Db.Category.CategoryDb.tbCategory> GetChild(CategoryDbDataContext context, Db.Category.CategoryDb.tbCategory category)
        {
            var data = new List<Db.Category.CategoryDb.tbCategory>();
            foreach (var item in category.tbCategories)
            {
                data.Add(item);
                data.AddRange(GetChild(context, item));

            }
            return data;
        }
        public static object getCategory(int ignoreId)
        {
            using (var context = new CategoryDbDataContext())
            {
                if (ignoreId == 0)
                {
                    return context.tbCategories.Select(x => new { x.Name, x.Id }).ToList();
                }
                var category = context.tbCategories.SingleOrDefault(x => x.Id == ignoreId);
                if (category == null)
                    return context.tbCategories.Select(x => new { x.Name, x.Id }).ToList();
                var ignorelist = GetChild(context, category);
                ignorelist.Add(category);
                return context.tbCategories.Where(x => !ignorelist.Contains(x)).Select(x => new { x.Name, x.Id }).ToList();
            }
        }

        public static bool DeteteCategory(string name, List<int> arrid)
        {

            using (var context = new CategoryDbFullDataContext())
            {
                checkUserPermission(context, name);

                foreach (int id in arrid)
                {
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
                    }
                    else
                    {
                        throw new Exception("Không tìm thấy chuyên mục này");
                    }
                }
                context.SubmitChanges();
                return true;
            }
        }

        private static void checkUserPermission(CategoryDbFullDataContext context, string name)
        {
            var user = context.tbUsers.FirstOrDefault(x => x.UserName.Equals(name));
            if (user == null)
                throw new Exception("Tài khoản không tồn tại");
            if (user.tbTypeUser.Id != 1)
                throw new Exception("Bạn không có quyền xóa chuyên mục");
        }

        public static Object getAllCategory(Db.Category.CategoryDb.tbCategory y)
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



        public static bool AddCategory(String currentUser, int id, string name, string description, int order, int parent)
        {
            int? _parent = null;
            if (parent != 0)
                _parent = parent;
            using (var context = new CategoryDbFullDataContext())
            {
                checkUserPermission(context, currentUser);
                if (id == 0)
                {
                    context.tbCategories.InsertOnSubmit(new Db.Category.CategoryDbFull.tbCategory()
                    {
                        Name = name,
                        Description = description,
                        Order = order,
                        ParentId = _parent
                    });
                    context.SubmitChanges();
                }
                else
                {
                    var category = context.tbCategories.SingleOrDefault(x => x.Id == id);
                    if (category == null)
                        throw new Exception("Không tìm thấy thông tin về chuyên mục này");
                    category.Name = name;
                    category.ParentId = _parent;
                    category.Order = order;
                    category.Description = description;
                    context.SubmitChanges();
                }
                return true;
            }
        }

    }
}
