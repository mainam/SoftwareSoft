using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Script.Serialization;

namespace DataAccess.DeviceFolder
{
    public class CategoryDeviceInfo
    {

        public static List<CategoryDevice> GetAll(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.CategoryDevices.ToList();

            }
            catch (Exception)
            {
                return new List<CategoryDevice>();
            }
        }

        public static List<object> GetDataCategory(DatabaseDataContext context,string keyword, int currentpage, int numberinpage, ref int totalitem)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var listmodel = context.CategoryDevices.ToList();
                    listmodel = listmodel.FindAll(x => x.Name.ToLower().Contains(keyword));
                    var listresult = new List<object>();
                    var listtake = listmodel.Skip((currentpage - 1) * numberinpage).Take(numberinpage);
                    totalitem = listmodel.Count();
                    if (listtake.Count() > 0)
                    {
                        var statuslot = context.Status.Single(x => x.Name == DataAccess.DeviceFolder.ApproveInfo.StatusDevice.Loss.ToString());
                        var statusbroken = context.Status.Single(x => x.Name == DataAccess.DeviceFolder.ApproveInfo.StatusDevice.Broken.ToString());
                        var statusgood = context.Status.Single(x => x.Name == DataAccess.DeviceFolder.ApproveInfo.StatusDevice.Good.ToString());
                        foreach (var item in listtake)
                        {
                            var numberlost = item.DeviceModels.Sum(x => x.Devices.Count(y => y.Borrower == null && y.Status == statuslot));
                            var numberbroken = item.DeviceModels.Sum(x => x.Devices.Count(y => y.Borrower == null && y.Status == statusbroken));
                            var numberavailable = item.DeviceModels.Sum(x => x.Devices.Count(y => y.Borrower == null && y.Status == statusgood));
                            var numberborrowed = item.DeviceModels.Sum(x => x.Devices.Count(y => y.Borrower != null));
                            var _object = new { item.ID, item.Name, Lost = numberlost, Broken = numberbroken, Available = numberavailable, Borrowed = numberborrowed, Total = numberavailable + numberbroken + numberlost + numberborrowed };
                            listresult.Add(_object);
                        }
                    }
                    return listresult;
                }
            }
            catch (Exception)
            {
                return new List<object>();
            }
        }

        public static bool Delete(DatabaseDataContext context, int id)
        {
            try
            {
                if (id == 6) return false;
                //using (var context = new DatabaseDataContext())
                {
                    var category = context.CategoryDevices.Single(x => x.ID == id);
                    foreach (var item in category.DeviceModels)
                        item.Category = 6;
                    context.CategoryDevices.DeleteOnSubmit(category);
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
        public static bool Save(DatabaseDataContext context, int id, string name)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    if (id != 0)
                    {
                        var cabinet = context.CategoryDevices.Single(x => x.ID == id);
                        cabinet.Name = name;
                    }
                    else
                    {
                        var category = new CategoryDevice()
                        {
                            Name = name
                        };
                        context.CategoryDevices.InsertOnSubmit(category);
                    }
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static string ListCategoryDevice(DatabaseDataContext context)
        {
            var listcate = CategoryDeviceInfo.GetAll(context).Select(x => new { ID = x.ID, Name = x.Name });
            return new JavaScriptSerializer().Serialize(listcate);
        }

    }
}
