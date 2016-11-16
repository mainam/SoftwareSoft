using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace DataAccess.DeviceFolder
{
    public class DeviceNoticeInfo
    {
        public static List<DeviceNotice> GetAll(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.DeviceNotices.OrderByDescending(x => x.CreateDate).ToList();
            }
            catch (Exception)
            {
                return new List<DeviceNotice>();
            }
        }
        public static List<DeviceNotice> GetAll(DatabaseDataContext context, string keyword, int currentpage, int numberinpage, ref int numberitem)
        {
            try
            {
                //var context = new DatabaseDataContext();
                
                var listnotice = context.DeviceNotices.OrderByDescending(x => x.CreateDate);
                if (string.IsNullOrEmpty(keyword))
                {
                    numberitem = listnotice.Count();
                    return listnotice.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
                }
                var listresult = new List<DeviceNotice>();
                foreach (var item in listnotice)
                {
                    if (item.Title.ToLower().Contains(keyword) || item.Content.ToLower().Contains(keyword) || item.User.UserName.ToLower().Contains(keyword) || item.User.FullName.ToLower().Contains(keyword))
                        listresult.Add(item);
                }
                numberitem = listresult.Count();
                return listresult.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
            }
            catch (Exception)
            {
                return new List<DeviceNotice>();
            }
        }

        public static bool SaveNotice(DatabaseDataContext context, int IDNotice, string Title, string Content, string UserName, bool Active)
        {
            try
            {

                //using (var context = new DatabaseDataContext())
                {
                    if (IDNotice == 0)
                    {
                        var notice = new DeviceNotice()
                        {
                            Content = HttpUtility.HtmlEncode(Content),
                            Title = Title,
                            CreateBy = UserName,
                            CreateDate = DateTime.Now,

                        };
                        context.DeviceNotices.InsertOnSubmit(notice);
                    }
                    else
                    {
                        var notice = context.DeviceNotices.Single(x => x.ID == IDNotice);
                        if (notice.CreateBy != UserName)
                            return false;
                        notice.Title = Title;
                        notice.Content = Content = HttpUtility.HtmlEncode(Content);
                    }
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }



        public static bool Delete(DatabaseDataContext context, string username, int IDNotice)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var notice = context.DeviceNotices.Single(x => x.ID == IDNotice);
                    if (notice.CreateBy != username)
                        return false;
                    context.DeviceNotices.DeleteOnSubmit(notice);
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static DeviceNotice GetByID(DatabaseDataContext context, int p)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.DeviceNotices.Single(x => x.ID == p);
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}
