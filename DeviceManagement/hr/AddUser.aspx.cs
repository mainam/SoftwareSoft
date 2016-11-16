using DataAccess;
using DataAccess.TeamFolder;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.hr
{
    public partial class AddUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public string GetAllTeam()
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    Dictionary<string, string> listAllTeam = TeamInfo.getAllTeamsDictionary(context);
                    List<string> list = new List<string>();
                    List<string> listKey = listAllTeam.Keys.ToList();
                    foreach (string key in listKey)
                    {
                        list.Add(key + "/" + listAllTeam[key]);
                    }
                    var jsonSerialiser = new JavaScriptSerializer();
                    return jsonSerialiser.Serialize(list);
                }
            }
            catch (Exception)
            {
                return "";
            }
        }
        public string GetAllTitle()
        {
            try
            {
                List<JobTitle> listAllTitle = JobTitleInfo.GetAll();
                List<string> list = new List<string>();
                foreach (JobTitle jobTitle in listAllTitle)
                {
                    list.Add(jobTitle.JobTitleID + "/" + jobTitle.JobName);
                }
                var jsonSerialiser = new JavaScriptSerializer();
                return jsonSerialiser.Serialize(list);
            }
            catch (Exception)
            {
                return "";
            }
        }
        //public string GetAllPermission()
        //{
        //    try
        //    {
        //        List<Permission> listAllPermission = PermissionIDInfo.getAll();
        //        List<string> list = new List<string>();
        //        foreach (Permission permission in listAllPermission)
        //        {
        //            list.Add(permission.id + "/" + permission.name);
        //        }
        //        var jsonSerialiser = new JavaScriptSerializer();
        //        return jsonSerialiser.Serialize(list);
        //    }
        //    catch (Exception)
        //    {
        //        return "";
        //    }
        //}
        [WebMethod]
        public static string addUser(DataUser userClass)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    if (UserInfo.IsAdmin(context, HttpContext.Current.User.Identity.Name))
                    {
                        if (DataUser.addUser(userClass))
                            return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = true });
                        else
                            return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
                    }
                    return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false });
            }

        }


    }
}