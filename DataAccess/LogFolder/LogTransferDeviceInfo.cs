using DataAccess.Db;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.LogFolder
{
    public enum TypeTransferDevice
    {
        manager_return,
        borrow_from_manager,
        borrow_form_user,
        manager_set_borrow,
        user_transfer_to_member
    }

    public class LogTransferDeviceInfo
    {

        public static List<LogTransferDevice> GetAll(string username, string keyword, int page, int numberinpage, ref int totalitem)
        {
            try
            {
                var listkeyword = keyword.ToLower().Split('|');
                using (LogTransferDeviceDataContext context = new LogTransferDeviceDataContext())
                {
                    //var user = context.Users.SingleOrDefault(x => x.UserName == username);
                    //if (UserInfo.IsAdmin(context,user))
                    {
                        var list = context.LogTransferDevices.OrderByDescending(x => x.TransferDate).ToList();
                        foreach (var item in listkeyword)
                        {
                            if (!string.IsNullOrWhiteSpace(item))
                            {
                                if (item.StartsWith("model:"))
                                {
                                    list = list.FindAll(x => x.IDDevice.ToString().Contains(item)
                                        || x.Model.ToLower().Contains(item.Replace("model:", "").Trim())
                                        );
                                }
                                else
                                {
                                    list = list.FindAll(x => x.IDDevice.ToString().Contains(item)
                                        || x.Model.ToLower().Contains(item)
                                        || x.Borrower.ToLower().Contains(item)
                                        || x.Manager.ToLower().Contains(item)
                                        || x.Keeper.ToLower().Contains(item)
                                        || x.IMEI.ToLower().Contains(item)
                                        || x.Serial.ToLower().Contains(item)
                                        || x.StatusDevice.ToLower().Contains(item)
                                        || x.Tag.ToLower().Contains(item)
                                        || x.Type.ToLower().Contains(item)
                                        );
                                }
                            }
                        }
                        totalitem = list.Count();
                        return list.Skip((page - 1) * numberinpage).Take(numberinpage).ToList();
                    }
                    //return new List<LogTransferDevice>();
                }
            }
            catch (Exception)
            {
                return new List<LogTransferDevice>();
            }
        }


        public static void Insert(LogTransferDevice log)
        {
            try
            {
                using (LogTransferDeviceDataContext context = new LogTransferDeviceDataContext())
                {
                    context.LogTransferDevices.InsertOnSubmit(log);
                    context.SubmitChanges();
                }
            }
            catch (Exception)
            {
            }
        }

        public static void Insert(int deviceID, string model, string tag, string imei, string serial, string manager, string borrower, string keeper, DateTime transferdate, string statusdevice, TypeTransferDevice type)
        {
            try
            {
                var log = new LogTransferDevice()
                {
                    IDDevice = deviceID,
                    Model = model,
                    Tag = tag,
                    IMEI = imei,
                    Serial = serial,
                    Manager = manager,
                    Borrower = borrower,
                    Keeper = keeper,
                    TransferDate = transferdate,
                    StatusDevice = statusdevice,
                    Type = type.ToString()
                };
                Insert(log);
            }
            catch (Exception)
            {
            }
        }
        public static bool Delete(List<int> IDLog, string username)
        {
            try
            {
                using (LogTransferDeviceDataContext context = new LogTransferDeviceDataContext())
                {
                    //var user = context.Users.SingleOrDefault(x => x.UserName == username);
                    //if (UserInfo.IsAdmin(context,user))
                    {
                        var list = context.LogTransferDevices.Where(x => IDLog.Contains(x.ID)).ToList();
                        context.LogTransferDevices.DeleteAllOnSubmit(list);
                        context.SubmitChanges();
                        return true;
                    }
                    //return false;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
