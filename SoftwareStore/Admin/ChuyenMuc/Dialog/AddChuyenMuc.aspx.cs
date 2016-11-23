using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using DataAccess;
using DataAccess.UtilFolder;
using System.Web.UI.WebControls;
using System.Web.Services;
using DataAccess.Db.Db;

namespace SoftwareStore.Admin.ChuyenMuc.Dialog
{
    public partial class AddChuyenMuc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        [WebMethod]
        public static String AddNewCategory(int id, string name, string description, int parentId)
        {
            try
            {
                if (id == parentId)
                    throw new Exception("Không thể tự thêm mình là chuyên mục cha");

                using (var context = new CategoryDbFullDataContext())
                {
                    tbCategory category = null;             
                    if(id!=0)
                    {
                        category = context.tbCategories.SingleOrDefault(x => x.Id == id);
                    }
                    var listmanager = context.DeviceManagers.Select(x => x.UserName);
                    var listnew = listuser.Except(listmanager);
                    context.DeviceManagers.InsertAllOnSubmit(listnew.Select(x => new DeviceManager() { UserName = x, ApplyDate = DateTime.Now }));
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