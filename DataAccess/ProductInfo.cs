using DataAccess.Db.Product.ProductDbFull;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class ProductInfo
    {
        public static object GetBySeller(string seller, int type, int currentpage, int numberinpage, string keyword, ref int totalitem)
        {
            using (var context = new ProductDbFullDataContext())
            {
                keyword = keyword.ToLower().Trim();
                var list = context.tbSoftwares.Where(x => x.UpBy.Equals(seller) && (type == 0 || type == x.Status)).ToList();
                totalitem = list.Count;
                if (String.IsNullOrWhiteSpace(keyword))
                    return list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).Select(x => new
                    {
                        x.Id,
                        SellerName = x.tbUser.FullName,
                        SellerId = x.UpBy,
                        x.Status,
                        StatusName = x.tbSoftwaraStatus.Name,
                        x.Price,
                        x.Name,
                        x.NumberGuaranteeDate,
                        x.Discount,
                        Category = x.tbCategory.Name,
                        ClosedDate = x.CloseDate.HasValue ? x.CloseDate.Value.ToString("dd/MM/yyyy") : ""
                    }).ToList();
                list = list.FindAll(x =>
               x.Name.ToLower().Contains(keyword));
                totalitem = list.Count;
                return list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).Select(x => new
                {
                    x.Id,
                    SellerName = x.tbUser.FullName,
                    SellerId = x.UpBy,
                    x.Status,
                    x.Price,
                    x.Name,
                    StatusName = x.tbSoftwaraStatus.Name,
                    x.NumberGuaranteeDate,
                    x.Discount,
                    Category = x.tbCategory.Name
                }).ToList();
            }
        }

        public static bool DeleteProduct(string name, List<int> arrid)
        {
            using (var context = new ProductDbFullDataContext())
            {
                var user = context.tbUsers.SingleOrDefault(x => x.UserName.Equals(name));
                if (user == null)
                    throw new Exception("Vui lòng đăng nhập");

                bool isAdmin = user != null && user.TypeUser == 1;
                foreach (var id in arrid)
                {
                    var data = context.tbSoftwares.SingleOrDefault(x => x.Id == id);
                    if (data == null)
                        throw new Exception("Không tìm thấy thông tin sản phẩm");
                    if (!isAdmin && data.UpBy != name)
                        throw new Exception("Bạn không thể xóa phần mềm của người khác");
                    context.tbSoftwares.DeleteOnSubmit(data);
                }
                context.SubmitChanges();
                return true;
            }
        }

    }
}
