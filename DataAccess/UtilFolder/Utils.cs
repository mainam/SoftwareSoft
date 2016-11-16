using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;

namespace DataAccess.UtilFolder
{
    public class Utils
    {
        public static string LocalHost = null;

        public static string Encryption(string pass)
        {
            MD5 md5hash = new MD5CryptoServiceProvider();
            UTF8Encoding encoder = new UTF8Encoding();
            byte[] hashBytes;
            hashBytes = md5hash.ComputeHash(encoder.GetBytes(pass));
            return BitConverter.ToString(hashBytes);
        }


        public static int GetWeek()
        {
            try
            {
                CalendarWeekRule weekRule = CalendarWeekRule.FirstFourDayWeek;
                DayOfWeek firstWeekDay = DayOfWeek.Monday;
                System.Globalization.Calendar calendar = System.Threading.Thread.CurrentThread.CurrentCulture.Calendar;
                return calendar.GetWeekOfYear(DateTime.Now, weekRule, firstWeekDay);
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public static int GetWeek(DateTime date)
        {
            try
            {
                CalendarWeekRule weekRule = CalendarWeekRule.FirstFourDayWeek;
                DayOfWeek firstWeekDay = DayOfWeek.Monday;
                System.Globalization.Calendar calendar = System.Threading.Thread.CurrentThread.CurrentCulture.Calendar;
                return calendar.GetWeekOfYear(date, weekRule, firstWeekDay);
            }
            catch (Exception)
            {
                return 0;
            }
        }


        public static DateTime FirstDateOfWeekISO8601(int year, int weekOfYear)
        {
            DateTime jan1 = new DateTime(year, 1, 1);
            int daysOffset = DayOfWeek.Thursday - jan1.DayOfWeek;

            DateTime firstThursday = jan1.AddDays(daysOffset);
            var cal = CultureInfo.CurrentCulture.Calendar;
            int firstWeek = cal.GetWeekOfYear(firstThursday, CalendarWeekRule.FirstFourDayWeek, DayOfWeek.Monday);

            var weekNum = weekOfYear;
            if (firstWeek <= 1)
            {
                weekNum -= 1;
            }
            var result = firstThursday.AddDays(weekNum * 7);
            return result.AddDays(-3);
        }

        public static DateTime GetFirstDay(int week)
        {
            try
            {
                return FirstDateOfWeekISO8601(DateTime.Now.Year, week);
            }
            catch (Exception)
            {
                return DateTime.Now;
            }
        }
        public static DateTime GetLastDay(int week)
        {
            return GetFirstDay(week).AddDays(6);
        }



        //public static string GetAddresses
        //{
        //    get
        //    {
        //        var host = Dns.GetHostEntry(Dns.GetHostName());
        //        try
        //        {
        //            return (from ip in host.AddressList where ip.AddressFamily == AddressFamily.InterNetwork select ip.ToString()).First();
        //        }
        //        catch (Exception)
        //        {
        //            return "";
        //        }
        //    }
        //}

        public static string GetLocation
        {
            get
            {
                try
                {
                    return HttpContext.Current.Request.Url.AbsolutePath.ToLower();
                }
                catch (Exception e)
                {
                    return e.Message;
                }
            }
        }
        public static void BackToHome(Page page, string Action)
        {
            try
            {
                page.Response.Redirect("~/Default.aspx?Action=" + Action);
            }
            catch (Exception)
            {
            }
        }
        public static void BackToHome(Page page)
        {
            try
            {
                page.Response.Redirect("~/Default.aspx?");
            }
            catch (Exception)
            {
            }
        }

        public static int CompareDateWithoutTime(DateTime dt1, DateTime dt2)
        {
            if (dt1.Date.Year < dt2.Date.Year)
            {
                return -1;
            }
            else if (dt1.Date.Year == dt2.Date.Year)
            {
                if (dt1.Date.DayOfYear < dt2.Date.DayOfYear)
                {
                    return -1;
                }
                else if (dt1.Date.DayOfYear == dt2.Date.DayOfYear)
                {
                    return 0;
                }
                else
                {
                    return 1;
                }
            }
            else
            {
                return 1;

            }
        }

        public static Color getColor(string c)
        {
            Color col = ColorTranslator.FromHtml(c);
            return col;
        }


        public static string RepareFile(string currentpath, string defaultpath)
        {
            try
            {
                var link = HttpContext.Current.Server.MapPath(currentpath);
                if (File.Exists(link))
                    return currentpath;
                return (defaultpath != null) ? defaultpath : "";
            }
            catch (Exception)
            {
                return (defaultpath != null) ? defaultpath : "";
            }
        }

    }
}
