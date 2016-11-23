using DataAccess;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SELPORTAL.AJAXProcess
{
    public partial class FileExplorer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetFile(string folder, bool byuser, int type, int numberinpage, int currentpage, string keyword)
        {
            try
            {
                keyword = keyword.ToLower();
                var server = HttpContext.Current.Server.MapPath("~/");
                var part = server + folder;
                if (byuser)
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (username == "")
                        throw new Exception();
                    part += "\\" + username;
                }
                if (Directory.Exists(part))
                {
                    var temp = Directory.GetFiles(part).ToList();
                    for (var i = 0; i < temp.Count; i++)
                    {
                        var filename = temp[i].Split('\\').Last();
                        if (!filename.ToLower().Contains(keyword))
                        {
                            temp.RemoveAt(i);
                            i--;
                        }
                    }

                    if (type == 1)
                    {
                        var listfile = temp.Where(x => (x.ToLower().EndsWith(".png") || x.ToLower().EndsWith(".jpg") || x.ToLower().EndsWith(".gif") || x.ToLower().EndsWith(".bmp")));
                        return new JavaScriptSerializer().Serialize(new { Status = true, TotalItem = listfile.Count(), Data = listfile.Select(x => Utils.LocalHost + "/" + x.Replace(server, "")).Skip((currentpage - 1) * numberinpage).Take(numberinpage) });
                    }
                    else
                    {
                        var listfile = temp.Where(x => (!x.ToLower().EndsWith(".png") && !x.ToLower().EndsWith(".jpg") && !x.ToLower().EndsWith(".gif") && !x.ToLower().EndsWith(".bmp")));
                        return new JavaScriptSerializer().Serialize(new { Status = true, TotalItem = listfile.Count(), Data = listfile.Select(x => Utils.LocalHost + "/" + x.Replace(server, "")).Skip((currentpage - 1) * numberinpage).Take(numberinpage) });
                    }
                }
                else
                {
                    return new JavaScriptSerializer().Serialize(new { Status = true, TotalItem = 0, Data = new List<string>() });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}