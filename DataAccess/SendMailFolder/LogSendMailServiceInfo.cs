using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.SendMailFolder
{
    public class LogSendMailServiceInfo
    {
        public static LogSendMailService GetByID(DatabaseDataContext context, int ID)
        {
            try
            {
                //   using (var context = new DatabaseDataContext())
                {
                    return context.LogSendMailServices.SingleOrDefault(x => x.ID == ID);
                }
            }
            catch (Exception)
            {
                return null;
            }
        }

        public static List<LogSendMailService> GetAll(DatabaseDataContext context, string keyword, int page, int numberinpage, string username, ref int totalitem)
        {
            try
            {
                keyword = keyword.ToLower().Trim();
                //    using (var context = new DatabaseDataContext())
                {
                    var user = context.Users.SingleOrDefault(x => x.UserName == username);
                    if (UserInfo.IsAdmin(context, user))
                    {
                        if (!string.IsNullOrWhiteSpace(keyword))
                        {

                            var list = context.LogSendMailServices.Where(x =>
                                x.From.ToLower().Contains(keyword)
                                || x.To.ToLower().Contains(keyword)
                                || x.CC.ToLower().Contains(keyword)
                                || x.Content.ToLower().Contains(keyword)
                                || x.UserName.ToLower().Contains(keyword)
                                || x.Subject.ToLower().Contains(keyword)
                                );
                            totalitem = list.Count();
                            return list.OrderByDescending(x => x.Date).Skip((page - 1) * numberinpage).Take(numberinpage).ToList();
                        }
                        else
                        {
                            var list = context.LogSendMailServices;
                            totalitem = list.Count();
                            return list.OrderByDescending(x => x.Date).Skip((page - 1) * numberinpage).Take(numberinpage).ToList();
                        }
                    }
                    return new List<LogSendMailService>();
                }
            }
            catch (Exception)
            {
                return new List<LogSendMailService>();
            }
        }

        public static bool Insert(DatabaseDataContext context, string from, string subject, List<string> to, List<string> cc, string content, string username, DateTime date)
        {
            try
            {
                // using (var context = new DatabaseDataContext())
                {
                    var log = new LogSendMailService()
                    {
                        CC = cc == null ? "" : string.Join(";", cc),
                        To = to == null ? "" : string.Join(";", to),
                        Content = content,
                        Date = date,
                        From = from,
                        Subject = subject,
                        UserName = username
                    };
                    context.LogSendMailServices.InsertOnSubmit(log);
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
