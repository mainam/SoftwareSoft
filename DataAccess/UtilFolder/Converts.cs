using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace DataAccess.UtilFolder
{
    public class Converts
    {
        public static bool ToBool(object ob)
        {
            try
            {
                return Convert.ToBoolean(ob);
            }
            catch (Exception)
            {

                return false;
            }
        }

        public static int ToInt(object ob, int defaultvalue)
        {
            try
            {
                return Convert.ToInt32(ob);
            }
            catch (Exception)
            {
                return defaultvalue;
            }
        }


        public static DateTime ToDate(object date, DateTime defaultvalue)
        {
            try
            {
                if (date == null) return defaultvalue;
                return Convert.ToDateTime(date);
            }
            catch (Exception)
            {
                return defaultvalue;
            }
        }

        public static string ToValidDate(string date)
        {
            try
            {
                var temp = date.Split('/');
                return temp[1] + "/" + temp[0] + "/" + temp[2];
            }
            catch (Exception)
            {
                return date;
            }
        }

        //T ToEnum<T>(object o)
        public static List<string> ToListString<T>() where T : struct
        {
            try
            {
                return Enum.GetNames(typeof(T)).ToList();
            }
            catch (Exception)
            {

                return new List<string>();
            }
        }

        public static string ToString(object ob, string DefaultValue)
        {
            try
            {
                if (ob == null)
                    return DefaultValue;
                if (ob is DateTime || ob is DateTime?)
                    return ((ob as DateTime?).Value.ToString("MM/dd/yyyy"));
                return ob.ToString();
            }
            catch (Exception)
            {
                return DefaultValue;

            }
        }
        public static string ToString(object ob)
        {
            try
            {
                return ToString(ob, "");
            }
            catch (Exception)
            {
                return "";
            }
        }


        public static T ToEnum<T>(object o)
        {
            T enumVal = (T)Enum.Parse(typeof(T), o.ToString());
            return enumVal;
        }

        public static DataTable ToDataTable<T>(IEnumerable<T> items)
        {
            var tb = new DataTable(typeof(T).Name);
            PropertyInfo[] props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
            foreach (var prop in props)
            {
                Type myDataType;
                if (prop.PropertyType.Name.Contains("Nullable"))
                    myDataType = typeof(String);
                else
                    if (prop.PropertyType.Name.Contains("DateTime"))
                        myDataType = typeof(String);// prop.PropertyType;
                    else
                        myDataType = prop.PropertyType;

                tb.Columns.Add(prop.Name, myDataType);
            }

            foreach (var item in items)
            {
                var values = new object[props.Length];
                for (var i = 0; i < props.Length; i++)
                {
                    var val = props[i].GetValue(item, null);
                    if (val != null && val is DateTime)
                    {
                        values[i] = Convert.ToDateTime(val.ToString()).ToString("Date(MM/dd/yyyy)");
                    }
                    if (val != null && val is Nullable<DateTime>)
                    {
                        var date = (val as Nullable<DateTime>);
                        if (date.HasValue)
                            values[i] = date.Value.ToString("Date(MM/dd/yyyy)");
                        else
                            values[i] = "";
                    }
                    else
                        values[i] = props[i].GetValue(item, null);
                }

                tb.Rows.Add(values);
            }
            return tb;
        }

        public static T Deserialize<T>(string data)
        {
            try
            {
                return new JavaScriptSerializer().Deserialize<T>(data);
            }
            catch (Exception)
            {
                return default(T);
            }
        }

        public static string Serialize(object ob)
        {
            try
            {
                return new JavaScriptSerializer().Serialize(ob);
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
}
