using DataAccess.Db.Transaction.TransactionDbFull;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess
{
    public class TransactionInfo
    {
        public static bool AddTransaction(String currentUser, String from, String to, String description, decimal value, int type)
        {
            using (var context = new TransactionDbFullDataContext())
            {
                var user = context.tbUsers.SingleOrDefault(x => x.UserName.Equals(currentUser));
                if (user == null || user.TypeUser != 1 || !user.Active)
                    throw new Exception("Tài khoản của bạn không có quyền thực hiện chức năng này");
                var userfrom = context.tbUsers.SingleOrDefault(x => x.UserName.Equals(from));
                if (userfrom == null)
                    throw new Exception("Vui lòng kiểm tra lại thông tin người nhận và người gửi");
                var userto = context.tbUsers.SingleOrDefault(x => x.UserName.Equals(to));
                if (userto == null)
                    throw new Exception("Vui lòng kiểm tra lại thông tin người nhận và người gửi");
                if (userfrom.Money < value)
                    throw new Exception("Tài khoản chuyển không đủ tiền để thực hiện giao dịch");

                context.tbTransactions.InsertOnSubmit(new tbTransaction()
                {
                    CreatedDate = DateTime.Now,
                    Description = description,
                    Source = from,
                    Destination = to,
                    Type = 1,
                    Value = value
                });

                if (from.Equals(to) && from.Equals(currentUser))
                    userto.Money += value;
                else
                {
                    userto.Money += value;
                    userfrom.Money -= value;

                }

                context.SubmitChanges();
                return true;
            }
        }

        public static object GetAll(string name, int currentpage, int numberinpage, string keyword, ref int totalitem)
        {
            using (var context = new TransactionDbFullDataContext())
            {
                var user = context.tbUsers.SingleOrDefault(x => x.UserName.Equals(name));
                if (user == null || user.TypeUser != 1 || !user.Active)
                    throw new Exception("Tài khoản của bạn không có quyền thực hiện chức năng này");

                keyword = keyword.ToLower().Trim();
                var list = context.tbTransactions.ToList();
                totalitem = list.Count;
                if (String.IsNullOrWhiteSpace(keyword))
                    return list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).Select(x => new
                    {
                        x.Id,
                        InvokeId = x.InvokeId.HasValue ? x.InvokeId.Value : 0,
                        x.Value,
                        Type = x.tbTypeTransaction.Name,
                        SourceId = x.Source,
                        SourceName = x.tbUser.FullName,
                        DesId = x.Destination,
                        DesName = x.tbUser1.FullName,
                        x.Description,
                        CreatedDate = x.CreatedDate.ToString("dd/MM/yyyy")
                    }).ToList();
                list = list.FindAll(x =>
               x.Description.ToLower().Contains(keyword)
               || x.tbUser.FullName.ToLower().Contains(keyword)
               || x.tbUser.UserName.ToLower().Contains(keyword)
               || x.tbUser1.FullName.ToLower().Contains(keyword)
               || x.tbUser1.UserName.ToLower().Contains(keyword));
                totalitem = list.Count;
                return list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).Select(x => new
                {
                    x.Id,
                    InvokeId = x.InvokeId.HasValue ? x.InvokeId.Value : 0,
                    x.Value,
                    Type = x.tbTypeTransaction.Name,
                    SourceId = x.Source,
                    SourceName = x.tbUser.FullName,
                    DesId = x.Destination,
                    DesName = x.tbUser1.FullName,
                    x.Description,
                    CreatedDate = x.CreatedDate.ToString("dd/MM/yyyy")
                }).ToList();
            }
        }


        public static object GetByUser(string name, int currentpage, int numberinpage, string keyword, ref int totalitem)
        {
            using (var context = new TransactionDbFullDataContext())
            {
                keyword = keyword.ToLower().Trim();
                var list = context.tbTransactions.Where(x => x.Destination.Equals(name) || x.Source.Equals(name)).ToList();
                totalitem = list.Count;
                if (String.IsNullOrWhiteSpace(keyword))
                    return list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).Select(x => new
                    {
                        x.Id,
                        InvokeId = x.InvokeId.HasValue ? x.InvokeId.Value : 0,
                        x.Value,
                        Type = x.tbTypeTransaction.Name,
                        SourceId = x.Source,
                        SourceName = x.tbUser.FullName,
                        DesId = x.Destination,
                        DesName = x.tbUser1.FullName,
                        x.Description,
                        CreatedDate = x.CreatedDate.ToString("dd/MM/yyyy")
                    }).ToList();
                list = list.FindAll(x =>
               x.Description.ToLower().Contains(keyword)
               || x.tbUser.FullName.ToLower().Contains(keyword)
               || x.tbUser.UserName.ToLower().Contains(keyword)
               || x.tbUser1.FullName.ToLower().Contains(keyword)
               || x.tbUser1.UserName.ToLower().Contains(keyword));
                totalitem = list.Count;
                return list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).Select(x => new
                {
                    x.Id,
                    InvokeId = x.InvokeId.HasValue ? x.InvokeId.Value : 0,
                    x.Value,
                    Type = x.tbTypeTransaction.Name,
                    SourceId = x.Source,
                    SourceName = x.tbUser.FullName,
                    DesId = x.Destination,
                    DesName = x.tbUser1.FullName,
                    x.Description,
                    CreatedDate = x.CreatedDate.ToString("dd/MM/yyyy")
                }).ToList();
            }
        }
    }
}
