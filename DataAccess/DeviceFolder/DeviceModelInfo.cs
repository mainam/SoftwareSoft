using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DeviceFolder
{
    public class DeviceModelInfo
    {
        public static List<DeviceModel> GetAll(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.DeviceModels.ToList();

            }
            catch (Exception)
            {
                return new List<DeviceModel>();
            }
        }

        public static List<object> GetDataModel(DatabaseDataContext context,string keyword, int currentpage, int numberinpage, ref int totalitem)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var listmodel = context.DeviceModels.ToList();
                    listmodel = listmodel.FindAll(x => x.ModelName.ToLower().Contains(keyword) || x.Company.ToLower().Contains(keyword) || x.CategoryDevice.Name.ToLower().Contains(keyword));
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
                            var numberlost = item.Devices.Count(y => y.Borrower == null && y.Status == statuslot);
                            var numberbroken = item.Devices.Count(y => y.Borrower == null && y.Status == statusbroken);
                            var numberavailable = item.Devices.Count(y => y.Borrower == null && y.Status == statusgood);
                            var numberborrowed = item.Devices.Count(y => y.Borrower != null);
                            var _object = new { item.ModelName, item.Company, item.Category, item.CategoryDevice.Name, Lost = numberlost, Broken = numberbroken, Available = numberavailable, Borrowed = numberborrowed, Total = numberavailable + numberbroken + numberlost + numberborrowed };
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

        public static bool Delete(DatabaseDataContext context,string id)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var model = context.DeviceModels.Single(x => x.ModelName == id);
                    context.DeviceModels.DeleteOnSubmit(model);
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
        public static bool Save(DatabaseDataContext context,string oldname, string newname, string company, int category)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    if (string.IsNullOrWhiteSpace(newname))
                        return false;
                    if (oldname != "")
                    {
                        var model1 = context.DeviceModels.Single(x => x.ModelName == oldname);
                        var model = new DeviceModel();
                        model.ModelName = newname;
                        model.Company = company;
                        model.Category = category;
                        foreach (var item in model1.Devices)
                            item.Model = model.ModelName;
                        context.DeviceModels.InsertOnSubmit(model);
                        context.DeviceModels.DeleteOnSubmit(model1);
                    }
                    else
                    {
                        var model = new DeviceModel()
                        {
                            ModelName = newname,
                            Category = category,
                            Company = company
                        };
                        context.DeviceModels.InsertOnSubmit(model);
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

        public static List<string> getAllModelNames(DatabaseDataContext context,string managerName)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    return context.Users.SingleOrDefault(u => u.UserName == managerName).Devices.Select(d => d.Model)
                        .Distinct().ToList();
                }
            }
            catch
            {
                return new List<string>();
            }
        }
    }
}

