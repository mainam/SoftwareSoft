using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DeviceFolder.InventoryFolder
{
    public class InventoryUserDeviceInfo
    {
        public int id;
        public string DeviceName;
        public string Type;
        public string Tag;
        public string Borrower;
        public string Keeper;
        public string BorrowDate;
        public string IMEI;
        public string Note;
        public string Serial;
        public int ConfirmStaus;
        public string Reason;
        public int LeaderConfirmStatus;
        public string LeaderReason;

        public InventoryUserDeviceInfo()
        {
        }

        public InventoryUserDeviceInfo(InventoryUserDevice userdevice)
        {
            id = userdevice.id;
            DeviceName = userdevice.Device.DeviceModel.ModelName;
            Type = userdevice.Device.DeviceModel.CategoryDevice.Name;
            Tag = userdevice.Device.Tag;
            Borrower = userdevice.Borrower + "/" + userdevice.User.FullName;
            Keeper = "";
            BorrowDate = userdevice.BorrowDate != null ? userdevice.BorrowDate.Value.ToString("MM/dd/yyyy") : "";
            IMEI = userdevice.Device.IMEI;
            Serial = userdevice.Device.Serial;
            ConfirmStaus = userdevice.ConfirmStatus;
            Reason = userdevice.Reason != null ? userdevice.Reason : "";
            LeaderConfirmStatus = userdevice.LeaderConfirmStatus;
            LeaderReason = userdevice.LeaderReasonReject != null ? userdevice.LeaderReasonReject : "";
            Note = userdevice.Device.Note != null ? userdevice.Device.Note : "";
        }


        public static bool isMatch(string keyword, InventoryUserDevice inventory)
        {
            try
            {
                keyword = keyword.ToLower();
                if (inventory.Borrower.Contains(keyword)
                    || inventory.User.FullName.Contains(keyword)
                    || DeviceFolder.DeviceInfo.IsMatch(inventory.Device, keyword))
                    return true;
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static object GetDataUserInventory(int inventoryid, string username, string keywordneedconfirm, string keywordlisthasconfirmed, string keywordlistaccept, string keywordlistreject)
        {
            try
            {
                var context = new DatabaseDataContext();

                var listmydeviceinventory = context.InventoryUserDevices.Where(x => x.Borrower == username && x.InventoryID == inventoryid);
                var listneedconfirm = new List<InventoryUserDevice>();
                var listhasconfirm = new List<InventoryUserDevice>();
                var listaccept = new List<InventoryUserDevice>();
                var listreject = new List<InventoryUserDevice>();
                foreach (var item in listmydeviceinventory)
                {
                    if (item.ConfirmStatus == 0)
                        listneedconfirm.Add(item);

                    switch (item.LeaderConfirmStatus)
                    {
                        case 0:
                            if (item.ConfirmStatus != 0)
                                listhasconfirm.Add(item);
                            break;
                        case 1:
                            listaccept.Add(item);
                            break;
                        case 2:
                            listreject.Add(item);
                            listneedconfirm.Add(item);
                            break;
                    }
                }
                listneedconfirm = listneedconfirm.FindAll(x => isMatch(keywordneedconfirm, x));
                listhasconfirm = listhasconfirm.FindAll(x => isMatch(keywordlisthasconfirmed, x));
                listaccept = listaccept.FindAll(x => isMatch(keywordlistaccept, x));
                listreject = listreject.FindAll(x => isMatch(keywordlistreject, x));
                var inventory = context.Inventories.Single(x => x.id == inventoryid);

                return new
                {
                    NeedConfirm = new { Data = listneedconfirm.Select(x => new InventoryUserDeviceInfo(x)), TotalItem = listneedconfirm.Count },
                    HasConfirmed = new { Data = listhasconfirm.Select(x => new InventoryUserDeviceInfo(x)), TotalItem = listhasconfirm.Count },
                    Accepted = new { Data = listaccept.Select(x => new InventoryUserDeviceInfo(x)), TotalItem = listaccept.Count },
                    Rejected = new { Data = listreject.Select(x => new InventoryUserDeviceInfo(x)), TotalItem = listreject.Count },
                    RequestName = inventory.InventoryName,
                    Date = inventory.RequestDate.ToString("dd/MM/yyyy"),
                    CreatedBy = inventory.User.FullName,
                    UserName = inventory.RequestBy,
                    TotalDevice = listmydeviceinventory.Count()
                };
            }

            catch (Exception)
            {
                return null;
            }
        }

        public static bool UserConfirm(string username, List<InventoryUserDeviceInfo> ListConfirm)
        {
            try
            {
                var listtemp = ListConfirm.Select(x => x.id);
                using (var context = new DatabaseDataContext())
                {
                    var listconfirmdevice = context.InventoryUserDevices.Where(x => listtemp.Contains(x.id));
                    if (listconfirmdevice.Count() != listtemp.Count())
                        throw new Exception();
                    foreach (var item in listconfirmdevice)
                    {
                        if (item.Borrower != username)
                            throw new Exception();
                        if (item.ConfirmStatus != 0 && item.LeaderConfirmStatus == 1)
                            throw new Exception();
                        var temp = ListConfirm.Single(x => x.id == item.id);
                        item.ConfirmStatus = ListConfirm.Single(x => x.id == item.id).ConfirmStaus;
                        item.Reason = temp.Reason;
                        item.LeaderConfirmStatus = 1;

                        //if (item.User.Team.Leader != username)
                        //    item.LeaderConfirmStatus = 0;
                        //else
                        //    item.LeaderConfirmStatus = 1;
                    }
                    context.SubmitChanges();
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static List<InventoryUserDeviceInfo> ListUserNeedConfirm(int inventoryid, string username, string keyword, int type)
        {
            try
            {
                var context = new DatabaseDataContext();
                var listtemp = context.InventoryUserDevices.Where(x => x.InventoryID == inventoryid && x.Borrower == username && x.ConfirmStatus == 0 || x.LeaderConfirmStatus == 2);
                var listresult = new List<InventoryUserDeviceInfo>();
                foreach (var item in listtemp)
                {
                    if (isMatch(keyword, item) && (type == 0 || item.Device.DeviceModel.Category == type))
                        listresult.Add(new InventoryUserDeviceInfo(item));
                }
                return listresult;
            }
            catch (Exception)
            {
                return new List<InventoryUserDeviceInfo>();
            }
        }

        public static List<InventoryUserDeviceInfo> ListHasConfirmed(int inventoryid, string username, string keyword, int type)
        {
            try
            {
                var context = new DatabaseDataContext();
                var listtemp = context.InventoryUserDevices.Where(x => x.InventoryID == inventoryid && x.Borrower == username && x.ConfirmStatus != 0 && x.LeaderConfirmStatus == 0);
                var listresult = new List<InventoryUserDeviceInfo>();
                foreach (var item in listtemp)
                {
                    if (isMatch(keyword, item) && (type == 0 || item.Device.DeviceModel.Category == type))
                        listresult.Add(new InventoryUserDeviceInfo(item));
                }
                return listresult;
            }
            catch (Exception)
            {
                return new List<InventoryUserDeviceInfo>();
            }
        }

        public static List<InventoryUserDeviceInfo> ListLeaderAccept(int inventoryid, string username, string keyword, int type)
        {
            try
            {
                var context = new DatabaseDataContext();
                var listtemp = context.InventoryUserDevices.Where(x => x.InventoryID == inventoryid && x.Borrower == username && x.ConfirmStatus != 0 && x.LeaderConfirmStatus == 1);
                var listresult = new List<InventoryUserDeviceInfo>();
                foreach (var item in listtemp)
                {
                    if (isMatch(keyword, item) && (type == 0 || item.Device.DeviceModel.Category == type))
                        listresult.Add(new InventoryUserDeviceInfo(item));
                }
                return listresult;
            }
            catch (Exception)
            {
                return new List<InventoryUserDeviceInfo>();
            }
        }

        public static List<InventoryUserDeviceInfo> ListLeaderReject(int inventoryid, string username, string keyword, int type)
        {
            try
            {
                var context = new DatabaseDataContext();
                var listtemp = context.InventoryUserDevices.Where(x => x.InventoryID == inventoryid && x.Borrower == username && x.ConfirmStatus != 0 && x.LeaderConfirmStatus == 2);
                var listresult = new List<InventoryUserDeviceInfo>();
                foreach (var item in listtemp)
                {
                    if (isMatch(keyword, item) && (type == 0 || item.Device.DeviceModel.Category == type))
                        listresult.Add(new InventoryUserDeviceInfo(item));
                }
                return listresult;
            }
            catch (Exception)
            {
                return new List<InventoryUserDeviceInfo>();
            }
        }


        public static object GetDataLeaderInventory(int inventoryid, string username, string keywordneedapprove, string keywordlisthascaccepted, string keywordlisthasrejected, string keywordnotconfirm)
        {
            try
            {
                var context = new DatabaseDataContext();
                var team = context.Teams.Single(x => x.Leader == username && x.User.TeamID == x.TeamID);
                var listuser = team.Users.Select(x => x.UserName);

                var listdeviceinventory = team.Users.SelectMany(x => x.InventoryUserDevices).Where(x => x.InventoryID == inventoryid).ToList();
                var listneedapprove = new List<InventoryUserDevice>();
                var listhasaccept = new List<InventoryUserDevice>();
                var listhasreject = new List<InventoryUserDevice>();
                var listnotconfirm = new List<InventoryUserDevice>();
                foreach (var item in listdeviceinventory)
                {
                    if (item.LeaderConfirmStatus == 1)
                        listhasaccept.Add(item);
                    else
                        if (item.LeaderConfirmStatus == 2)
                            listhasreject.Add(item);
                        else
                            if (item.ConfirmStatus != 0)
                                listneedapprove.Add(item);
                            else
                                listnotconfirm.Add(item);
                }

                listneedapprove = listneedapprove.FindAll(x => isMatch(keywordneedapprove, x));
                listhasaccept = listhasaccept.FindAll(x => isMatch(keywordlisthascaccepted, x));
                listhasreject = listhasreject.FindAll(x => isMatch(keywordlisthasrejected, x));
                listnotconfirm = listnotconfirm.FindAll(x => isMatch(keywordnotconfirm, x));
                var inventory = context.Inventories.Single(x => x.id == inventoryid);

                return new
                {
                    NeedApprove = new { Data = listneedapprove.Select(x => new InventoryUserDeviceInfo(x)), TotalItem = listneedapprove.Count },
                    HasAccept = new { Data = listhasaccept.Select(x => new InventoryUserDeviceInfo(x)), TotalItem = listhasaccept.Count },
                    HasReject = new { Data = listhasreject.Select(x => new InventoryUserDeviceInfo(x)), TotalItem = listhasreject.Count },
                    NotConfirm = new { Data = listnotconfirm.Select(x => new InventoryUserDeviceInfo(x)), TotalItem = listnotconfirm.Count },
                    RequestName = inventory.InventoryName,
                    Date = inventory.RequestDate.ToString("dd/MM/yyyy"),
                    CreatedBy = inventory.User.FullName,
                    UserName = inventory.RequestBy,
                    TotalDevice = listdeviceinventory.Count()
                };
            }

            catch (Exception)
            {
                return null;
            }
        }


        public static List<InventoryUserDeviceInfo> ListLeaderNeedApprove(int inventoryid, string username, string keyword, int type)
        {
            try
            {
                var context = new DatabaseDataContext();
                var team = context.Teams.Single(x => x.Leader == username && x.User.TeamID == x.TeamID);
                var listtemp = team.Users.SelectMany(x => x.InventoryUserDevices).Where(x => x.InventoryID == inventoryid && x.ConfirmStatus != 0 && x.LeaderConfirmStatus == 0);
                var listresult = new List<InventoryUserDeviceInfo>();
                foreach (var item in listtemp)
                {
                    if (isMatch(keyword, item) && (type == 0 || item.Device.DeviceModel.Category == type))
                        listresult.Add(new InventoryUserDeviceInfo(item));
                }
                return listresult;
            }
            catch (Exception)
            {
                return new List<InventoryUserDeviceInfo>();
            }
        }

        public static List<InventoryUserDeviceInfo> ListHasAccepted(int inventoryid, string username, string keyword, int type)
        {
            try
            {
                var context = new DatabaseDataContext();
                var team = context.Teams.Single(x => x.Leader == username && x.User.TeamID == x.TeamID);
                var listtemp = team.Users.SelectMany(x => x.InventoryUserDevices).Where(x => x.InventoryID == inventoryid && x.LeaderConfirmStatus == 1);
                var listresult = new List<InventoryUserDeviceInfo>();
                foreach (var item in listtemp)
                {
                    if (isMatch(keyword, item) && (type == 0 || item.Device.DeviceModel.Category == type))
                        listresult.Add(new InventoryUserDeviceInfo(item));
                }
                return listresult;
            }
            catch (Exception)
            {
                return new List<InventoryUserDeviceInfo>();
            }
        }

        public static List<InventoryUserDeviceInfo> ListHasRejected(int inventoryid, string username, string keyword, int type)
        {
            try
            {
                var context = new DatabaseDataContext();
                var team = context.Teams.Single(x => x.Leader == username && x.User.TeamID == x.TeamID);
                var listtemp = team.Users.SelectMany(x => x.InventoryUserDevices).Where(x => x.InventoryID == inventoryid && x.LeaderConfirmStatus == 2);
                var listresult = new List<InventoryUserDeviceInfo>();
                foreach (var item in listtemp)
                {
                    if (isMatch(keyword, item) && (type == 0 || item.Device.DeviceModel.Category == type))
                        listresult.Add(new InventoryUserDeviceInfo(item));
                }
                return listresult;
            }
            catch (Exception)
            {
                return new List<InventoryUserDeviceInfo>();
            }
        }

        public static List<InventoryUserDeviceInfo> ListNotConfirm(int inventoryid, string username, string keyword, int type)
        {
            try
            {
                var context = new DatabaseDataContext();
                var team = context.Teams.Single(x => x.Leader == username && x.User.TeamID == x.TeamID);
                var listtemp = team.Users.SelectMany(x => x.InventoryUserDevices).Where(x => x.InventoryID == inventoryid && x.ConfirmStatus == 0);
                var listresult = new List<InventoryUserDeviceInfo>();
                foreach (var item in listtemp)
                {
                    if (isMatch(keyword, item) && (type == 0 || item.Device.DeviceModel.Category == type))
                        listresult.Add(new InventoryUserDeviceInfo(item));
                }
                return listresult;
            }
            catch (Exception)
            {
                return new List<InventoryUserDeviceInfo>();
            }
        }

        public static bool LeaderConfirm(string username, List<InventoryUserDeviceInfo> ListConfirm)
        {
            try
            {
                var listtemp = ListConfirm.Select(x => x.id);
                using (var context = new DatabaseDataContext())
                {
                    var listconfirmdevice = context.InventoryUserDevices.Where(x => listtemp.Contains(x.id));
                    if (listconfirmdevice.Count() != listtemp.Count())
                        throw new Exception();
                    foreach (var item in listconfirmdevice)
                    {
                        if (item.User.Team.Leader != username)
                            throw new Exception();
                        if (item.LeaderConfirmStatus != 0)
                            throw new Exception();
                        if (item.ConfirmStatus == 0)
                            throw new Exception();
                        var temp = ListConfirm.Single(x => x.id == item.id);
                        item.LeaderConfirmStatus = ListConfirm.Single(x => x.id == item.id).LeaderConfirmStatus;
                        item.LeaderReasonReject = temp.LeaderReason;
                    }
                    context.SubmitChanges();
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
