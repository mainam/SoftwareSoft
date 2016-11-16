using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DeviceFolder
{
    public class CabinetInfo
    {
        public static List<Cabinet> GetAll(DatabaseDataContext context, bool status)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.Cabinets.Where(x => x.Status == status).ToList();

            }
            catch (Exception)
            {
                return new List<Cabinet>();
            }
        }
        public static List<Cabinet> GetAll(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.Cabinets.ToList();

            }
            catch (Exception)
            {
                return new List<Cabinet>();
            }
        }
        public static List<object> GetDataCabinet(DatabaseDataContext context, string keyword, int currentpage, int numberinpage, ref int totalitem)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var listcabinet = context.Cabinets.ToList();
                    listcabinet = listcabinet.FindAll(x => x.Name.ToLower().Contains(keyword) || x.Place.ToLower().Contains(keyword) || (x.Status && "good".Contains(keyword)) || (!x.Status && "broken".Contains(keyword)));
                    var listresult = new List<object>();
                    var listtake = listcabinet.Skip((currentpage - 1) * numberinpage).Take(numberinpage);
                    totalitem = listcabinet.Count();
                    if (listtake.Count() > 0)
                    {
                        var statuslot = context.Status.Single(x => x.Name == DataAccess.DeviceFolder.ApproveInfo.StatusDevice.Loss.ToString());
                        var statusbroken = context.Status.Single(x => x.Name == DataAccess.DeviceFolder.ApproveInfo.StatusDevice.Broken.ToString());
                        var statusgood = context.Status.Single(x => x.Name == DataAccess.DeviceFolder.ApproveInfo.StatusDevice.Good.ToString());
                        foreach (var item in listtake)
                        {
                            var numberlost = item.Devices.Count(x => x.Status == statuslot);
                            var numberbroken = item.Devices.Count(x => x.Status == statusbroken);
                            var numbergood = item.Devices.Count(x => x.Status == statusgood);
                            var _object = new { item.ID, item.Name, item.Status, item.Place, Lost = numberlost, Broken = numberbroken, Good = numbergood, Total = numbergood + numberbroken + numberlost };
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
                if (id == 1) return false;
                //using (var context = new DatabaseDataContext())
                {
                    var cabinet = context.Cabinets.Single(x => x.ID == id);
                    foreach (var item in cabinet.Devices)
                        item.Cabinet = 1;
                    context.Cabinets.DeleteOnSubmit(cabinet);
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool Save(DatabaseDataContext context, int id, string name, string location, bool status)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    if (id != 0)
                    {
                        var cabinet = context.Cabinets.Single(x => x.ID == id);
                        cabinet.Name = name;
                        cabinet.Place = location;
                        cabinet.Status = status;
                    }
                    else
                    {
                        var cabinet = new Cabinet()
                        {
                            Name = name,
                            Place = location,
                            Status = status
                        };
                        context.Cabinets.InsertOnSubmit(cabinet);
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
    }
}
