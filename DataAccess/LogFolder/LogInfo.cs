using DataAccess.Db;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.LogFolder
{
    public class LogInfo
    {
        public static void Insert(Log log)
        {
            try
            {
                using (LogAccessSystemDataContext context = new LogAccessSystemDataContext())
                {
                    context.Logs.InsertOnSubmit(log);
                    context.SubmitChanges();
                }
            }
            catch (Exception)
            {
            }


        }

        public static List<Log> GetByUser(string username, string keyword, int page, int numberinpage, ref int totalitem)
        {
            try
            {
                var listkeyword = keyword.ToLower().Split('|');
                using (LogAccessSystemDataContext context = new LogAccessSystemDataContext())
                {
                    var list = context.Logs.Where(x => x.UserName == username).OrderByDescending(x => x.Time).ToList();
                    foreach (var item in listkeyword)
                    {
                        if (!string.IsNullOrWhiteSpace(item))
                        {
                            list = list.FindAll(x => x.IP.Contains(item) || x.UserName.ToLower().Contains(item) || x.Status.ToLower().Contains(item));
                        }
                    }
                    totalitem = list.Count();
                    return list.Skip((page - 1) * numberinpage).Take(numberinpage).ToList();
                }
            }
            catch (Exception)
            {
                return new List<Log>();
            }
        }

        public static List<Log> GetAll(string username, string keyword, int page, int numberinpage, ref int totalitem)
        {
            try
            {
                var listkeyword = keyword.ToLower().Split('|');
                using (LogAccessSystemDataContext context = new LogAccessSystemDataContext())
                {
                    //var user = context.Users.SingleOrDefault(x => x.UserName == username);
                    //if (UserInfo.IsAdmin(context,user))
                    {
                        var list = context.Logs.OrderByDescending(x => x.Time).ToList();
                        foreach (var item in listkeyword)
                        {
                            if (!string.IsNullOrWhiteSpace(item))
                            {
                                list = list.FindAll(x => x.IP.Contains(item) || x.UserName.ToLower().Contains(item) || x.Status.ToLower().Contains(item));
                            }
                        }
                        totalitem = list.Count();
                        return list.Skip((page - 1) * numberinpage).Take(numberinpage).ToList();
                    }
                    return new List<Log>();
                }
            }
            catch (Exception)
            {
                return new List<Log>();
            }
        }

        public static bool Delete(List<int> IDLog, string username)
        {
            try
            {
                using (LogAccessSystemDataContext context = new LogAccessSystemDataContext())
                {
                    //var user = context.Users.SingleOrDefault(x => x.UserName == username);
                    //if (UserInfo.IsAdmin(context,user))
                    {
                        var list = context.Logs.Where(x => IDLog.Contains(x.Id)).ToList();
                        context.Logs.DeleteAllOnSubmit(list);
                        context.SubmitChanges();
                        return true;
                    }
                    return false;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
