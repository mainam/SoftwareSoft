using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Configuration;
using DataAccess;
using System.IO;
using DataAccess.UserFolder;

namespace SoftwareStore.account
{
    /// <summary>
    /// Summary description for AJAXImport
    /// </summary>
    public class AJAXImportAvatar : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            try
            {
                using (var context2 = new DatabaseDataContext())
                {

                    var username = HttpContext.Current.User.Identity.Name;
                    var currentusername = context.Request.Form["username"];
                    if (username != currentusername)
                        if (!UserInfo.IsAdmin(username))
                        {
                            context.Response.Write(new JavaScriptSerializer().Serialize(new { Status = false }));
                            return;
                        }

                    //var user = UserInfo.GetByID( currentusername);
                    //if (user == null)
                    //{
                    //    context.Response.Write(new JavaScriptSerializer().Serialize(new { Status = false }));
                    //    return;
                    //}

                    var httpPostedFile = context.Request.Files["File"];

                    string directoryPath = HttpContext.Current.Server.MapPath("~/images/");
                    if (!Directory.Exists(directoryPath))
                        Directory.CreateDirectory(directoryPath);
                    directoryPath = HttpContext.Current.Server.MapPath("~/images/avatars");
                    if (!Directory.Exists(directoryPath))
                        Directory.CreateDirectory(directoryPath);
                    directoryPath = HttpContext.Current.Server.MapPath("~/images/avatars/" + currentusername);
                    if (!Directory.Exists(directoryPath))
                        Directory.CreateDirectory(directoryPath);
                    var time = DateTime.Now.ToString("ddMMyyyyhhmmss");
                    string filename = httpPostedFile.FileName;
                    var i = filename.LastIndexOf("\\");
                    if (i != -1)
                    {
                        filename = filename.Substring(i + 1);
                    }
                    string file = string.Concat(directoryPath + "/" + time + filename);
                    httpPostedFile.SaveAs(file);
                    if (UserInfo.ChangeAvatar(context2, currentusername, "~/images/avatars/" + currentusername + "/" + time + filename))
                        context.Response.Write(new JavaScriptSerializer().Serialize(new { Status = true, Link = "/images/avatars/" + currentusername + "/" + time + filename, isAdminEdit = username != currentusername }));
                    else
                        context.Response.Write(new JavaScriptSerializer().Serialize(new { Status = false }));
                }
            }
            catch (Exception e)
            {
                context.Response.Write(new JavaScriptSerializer().Serialize(new { Status = false }));
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}