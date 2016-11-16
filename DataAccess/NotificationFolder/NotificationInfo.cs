using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.NotificationFolder
{
    public enum EnumTypeNotification
    {
        taskclose,
        tasknewcomment,
        tasknewtask,
        tasknewreport,
        taskfinishtask,
        taskrejectreport,
        taskchangeprogress,
        ideanewcomment,
        ideaapprove,
        ideareject
    }
    public class NotificationInfo
    {


        public static List<Notification> GetByUserName(string username)
        {
            var context = new DatabaseDataContext();
            return context.Notifications.Where(x => x.UserName == username).ToList();
        }
        public static bool RemoveNotification(string username, string link)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var user = context.Users.Single(x => x.UserName == username);
                    context.Notifications.DeleteAllOnSubmit(user.Notifications.Where(x => x.Link.ToLower().Contains(link.ToLower())));
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool AddNewNotification(List<string> ListUser, string content, string link, EnumTypeNotification typenotification, DateTime date)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    context.Notifications.InsertAllOnSubmit(ListUser.Select(x => new Notification()
                    {
                        Content = content,
                        Link = link,
                        TypeNotication = typenotification.ToString(),
                        UserName = x,
                        Date = date
                    }));
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool AddNewNotification(DatabaseDataContext context, List<string> ListUser, string content, string link, EnumTypeNotification typenotification, DateTime date)
        {
            try
            {
                context.Notifications.InsertAllOnSubmit(ListUser.Select(x => new Notification()
                {
                    Content = content,
                    Link = link,
                    TypeNotication = typenotification.ToString(),
                    UserName = x,
                    Date = date

                }));
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool AddNewNotification(DatabaseDataContext context, List<Notification> listnotification)
        {
            try
            {
                context.Notifications.InsertAllOnSubmit(listnotification);
                //context.Notifications.InsertAllOnSubmit(ListUser.Select(x => new Notification()
                //{
                //    Content = content,
                //    Link = link,
                //    TypeNotication = typenotification.ToString(),
                //    UserName = x
                //}));
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static String CreateContent(string fullname, string content, DateTime date)
        {
            return string.Format("<b>{0}</b> {1} <br><i>at {2}</i>", fullname, content, date.ToString("dd-MM-yyyy hh:mm:ss tt"));
        }
    }
}
