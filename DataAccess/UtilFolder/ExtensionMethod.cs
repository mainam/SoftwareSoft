using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.SessionState;

namespace DataAccess.UtilFolder
{
    public static class ExtensionMethod
    {
        public static string GetCurrentUser(this string session)
        {
            try
            {
                return HttpContext.Current.User.Identity.Name;
            }
            catch (Exception)
            {
                return "";
            }
        }
    }
}
