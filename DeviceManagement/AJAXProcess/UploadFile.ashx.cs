using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace SELPORTAL.AJAXProcess
{
    /// <summary>
    /// Summary description for UploadFile
    /// </summary>
    public class UploadFile : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            var username = HttpContext.Current.User.Identity.Name;
            if (username != null && username != "")
            {
                context.Response.ContentType = "text/plain";

                var folder = context.Request.Form["folder"];
                var byuser = context.Request.Form["byuser"];

                string directoryPath = "";
                var folderuser = "";
                if (byuser != null && Convert.ToBoolean(byuser))
                {
                    folderuser = username;
                }
                else
                {
                    folderuser = "";
                }
                if (folder == null)
                {
                    folder = "Uploads/AttachFiles/SubmitIdeas/";

                }

                directoryPath = HttpContext.Current.Server.MapPath("~/") + folder + "/" + folderuser;

                if (!Directory.Exists(directoryPath))
                    Directory.CreateDirectory(directoryPath);

                var time = DateTime.Now.ToString("yyyyMMddhhmmss");

                var httpPostedFile = context.Request.Files["Filedata"];

                string filename = httpPostedFile.FileName;
                var i = filename.LastIndexOf("\\");
                if (i != -1)
                {
                    filename = filename.Substring(i + 1);
                }
                string file = string.Concat(directoryPath + "/" + time + filename);

                httpPostedFile.SaveAs(file);

                var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                var json = serializer.Serialize(new { Status = true, Link = "~" + folder + "/" + folderuser + "/" + time + filename });
                context.Response.ContentType = "text/json";
                context.Response.Write(json);
            }
            else
            {
                var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                var json = serializer.Serialize(new { Status = false });
                context.Response.ContentType = "text/json";
                context.Response.Write(json);
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