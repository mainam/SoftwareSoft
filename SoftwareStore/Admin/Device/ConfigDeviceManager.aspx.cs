using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccess.UtilFolder;
using DataAccess;
using DataAccess.UserFolder;

namespace SoftwareStore.Admin.Device
{
    public partial class ConfigDeviceManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static String LoadData(string keyword, int numberinpage, int currentpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    string data = "";
                    if (String.IsNullOrWhiteSpace(keyword))
                    {
                        var list = context.DeviceManagers;
                        data = Converts.Serialize(new
                       {
                           Status = true,
                           Data = list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList().Select(x => new
                               {
                                   ApplyDate = x.ApplyDate.ToString("dd/MM/yyyy"),
                                   x.UserName,
                                   x.User.FullName,
                                   x.User.Active,
                                   x.User.JobTitle.JobName
                               }),
                           TotalItem = list.Count()
                       });
                    }
                    else
                    {
                        keyword = keyword.ToLower().Trim();
                        var list = context.DeviceManagers.Where(x => x.UserName.ToLower().Contains(keyword)
                                                        || x.User.FullName.ToLower().Contains(keyword));
                        data = Converts.Serialize(new
                        {
                            Status = true,
                            Data = list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList().Select(x => new
                                {
                                    ApplyDate = x.ApplyDate.ToString("dd/MM/yyyy"),
                                    x.UserName,
                                    x.User.FullName,
                                    x.User.Active
                                }),
                            TotalItem = list.Count()
                        });
                    }
                    return data;
                }
            }
            catch (Exception e)
            {
                return Converts.Serialize(new { Status = false });
            }

        }

        [WebMethod]
        public static String DeleteMultipleManager(List<String> ListManager)
        {
            try
            {
                if (ListManager == null || ListManager.Count == 0)
                    throw new Exception();
                using (var context = new DatabaseDataContext())
                {
                    var _user = HttpContext.Current.User.Identity.Name;
                    var user = context.Users.SingleOrDefault(x => x.UserName == _user);
                    if (user == null || !UserInfo.IsAdmin(context,user))
                        throw new Exception();
                    var list = context.DeviceManagers.Where(x=>ListManager.Contains(x.UserName));
                    context.DeviceManagers.DeleteAllOnSubmit(list);
                    context.SubmitChanges();
                    return Converts.Serialize(new { Status = true });
                }
            }
            catch (Exception)
            {
                return Converts.Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static String Delete(string username)
        {
            try
            {
                if (String.IsNullOrWhiteSpace(username))
                    throw new Exception();
                using (var context = new DatabaseDataContext())
                {
                    var _user = HttpContext.Current.User.Identity.Name;
                    var user = context.Users.SingleOrDefault(x => x.UserName == _user);
                    if (user == null || !UserInfo.IsAdmin(context,user))
                        throw new Exception();
                    var list = context.DeviceManagers.Where(x => x.UserName == username);
                    context.DeviceManagers.DeleteAllOnSubmit(list);
                    context.SubmitChanges();
                    return Converts.Serialize(new { Status = true });
                }
            }
            catch (Exception)
            {
                return Converts.Serialize(new { Status = false });
            }
        }
    }
}