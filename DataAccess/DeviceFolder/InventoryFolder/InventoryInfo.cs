using DataAccess.Helper;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DeviceFolder.InventoryFolder
{
    public class InventoryInfo
    {
        public int id;
        public string RequestBy;
        public string RequestDate;
        public string InventoryName;
        public int NotConfirm;
        public int NotBorrow;
        public int Loss;
        public int Broken;
        public int Good;

        public enum StatusConfirm
        {
            NotConfirm = 1,
            NotBorrow = 2,
            Loss = 3,
            Broken = 4,
            Good = 5
        }

        public static string GetStatus(int status)
        {
            switch (status)
            {
                case 0:
                    return "Not Confirm";
                case 1:
                    return "Not Borrow";
                case 2:
                    return "Loss";
                case 3:
                    return "Broken";
                case 4:
                    return "Good";
            }
            return "";
        }

        public static string GetStatus(InventoryUserDevice userdevice)
        {
            if (userdevice.LeaderConfirmStatus == 0)
                return "Not Confirm";
            switch (userdevice.ConfirmStatus)
            {
                case 0:
                    return "Not Confirm";
                case 1:
                    return "Not Borrow";
                case 2:
                    return "Loss";
                case 3:
                    return "Broken";
                case 4:
                    return "Good";
            }
            return "";
        }

        public static Inventory GetByID(int id)
        {
            try
            {
                var context = new DatabaseDataContext();
                return context.Inventories.Where(x => x.id == id).First();
            }
            catch (Exception)
            {

                return null;
            }
        }

        public static List<Inventory> GetListRequest(DatabaseDataContext context, string username)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.Inventories.Where(x => x.RequestBy.Equals(username)).ToList();
            }
            catch (Exception)
            {
                return new List<Inventory>();
            }
        }

        public static List<InventoryInfo> GetListRequest(DatabaseDataContext context, string username, string keyword, int currentpage, int numberinpage, ref int numberitem)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var listinventory = context.Inventories.Where(x => x.RequestBy.Equals(username) && x.InventoryName.ToLower().Contains(keyword)).OrderByDescending(x => x.RequestDate);
                numberitem = listinventory.Count();
                var listreturn = listinventory.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
                return listreturn.Select(x => new InventoryInfo()
                {
                    RequestDate = x.RequestDate.ToString("MM/dd/yyyy"),
                    RequestBy = x.RequestBy,
                    InventoryName = x.InventoryName,
                    id = x.id,
                    NotConfirm = x.InventoryUserDevices.Count(y => y.ConfirmStatus == 0),
                    NotBorrow = x.InventoryUserDevices.Count(y => y.ConfirmStatus == 1),
                    Loss = x.InventoryUserDevices.Count(y => y.ConfirmStatus == 2),
                    Broken = x.InventoryUserDevices.Count(y => y.ConfirmStatus == 3),
                    Good = x.InventoryUserDevices.Count(y => y.ConfirmStatus == 4)
                }).ToList();
            }
            catch (Exception)
            {
                return new List<InventoryInfo>();
            }
        }

        public static string BuildMailSendRequestInventory(User sender, string requestname, string requestdate, int totaldevice, string link)
        {
            StringBuilder strbuilder = new StringBuilder();
            strbuilder.Append("Dear All,<br><br>");
            strbuilder.Append(sender.FullName + "has requested Inventory Device with the following Information:<br>");
            strbuilder.Append("- Request Name: " + requestname + ". <br>");
            strbuilder.Append("- Request Date: " + requestdate + ". <br>");
            strbuilder.Append("- Total Device: " + totaldevice + ". <br><br>");
            strbuilder.Append("Click <a target='_blank' href='" + link + "'>here</a> to confirm your borrowing devices or access the link as below. <br> <a target='_blank' href='" + link + "'>" + link + "</a><br><br>");
            strbuilder.Append("Please do let me know if you need more information(" + sender.Email + ")<br><br>");
            strbuilder.Append("Yours sincerely,<br>" + sender.FullName);
            return strbuilder.ToString();
        }

        public static bool AddNewInventory(DatabaseDataContext context, string requestby, DateTime requestdate, string inventoryname, List<string> models)
        {

            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var user = context.Users.Single(x => x.UserName == requestby);
                    var inventory = new Inventory()
                    {
                        RequestDate = requestdate,
                        RequestBy = requestby,
                        InventoryName = inventoryname,
                    };
                    context.Inventories.InsertOnSubmit(inventory);

                    List<Device> listdevice;
                    if (models != null && models.Count > 0)
                    {
                        listdevice = context.Devices.Where(d => models.Contains(d.Model) && d.Manager.Equals(requestby)).ToList();
                    }
                    else
                    {
                        listdevice = context.Devices.Where(x => x.Manager.Equals(requestby)).ToList();
                    }

                    if (listdevice.Count() == 0)
                        return false;

                    List<string> email = new List<string>();

                    foreach (var item in listdevice)
                    {
                        var userborrow = requestby;
                        var keeper = requestby;

                        if (item.Borrower != null)
                        {
                            email.Add(item.User3.Email);
                            userborrow = item.Borrower;
                            keeper = userborrow;
                            if (item.Keeper != null)
                                keeper = item.Keeper;
                        }
                        else
                        {
                            email.Add(user.Email);
                        }

                        var inventoryuserdevice = new InventoryUserDevice()
                        {
                            Borrower = userborrow,
                            ConfirmStatus = 0,
                            DeviceID = item.IDDevice,
                            Inventory = inventory,
                            Keeper = keeper,
                            BorrowDate = DateTime.Now,
                            LeaderConfirmStatus = 0
                        };
                        if (item.BorrowDate.HasValue)
                        {
                            if (item.BorrowDate.Value > Convert.ToDateTime("1/1/1753"))
                                inventoryuserdevice.BorrowDate = item.BorrowDate.Value;
                        }
                        context.InventoryUserDevices.InsertOnSubmit(inventoryuserdevice);
                    }
                    context.SubmitChanges();
                    email = email.Distinct().ToList();
                    var link = Utils.LocalHost + "/Default.aspx#device/confirmation/userinventorypage.aspx?inventoryid=" + inventory.id;
                    SendMail.send(email, new List<string> { user.Email }, "[SELSVMC]Notice Inventory: " + inventoryname, BuildMailSendRequestInventory(user, inventoryname, requestdate.ToString("dd/MM/yyyy"), listdevice.Count(), link));
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool UpdateInventoryUserDevice(DatabaseDataContext context, List<InventoryUserDevice> listinventory)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    listinventory.ForEach(x =>
                    {
                        var inventorydevices = context.InventoryUserDevices.Where(y => y.id == x.id);
                        if (inventorydevices.Count() > 0)
                        {
                            inventorydevices.First().ConfirmStatus = x.ConfirmStatus;
                        }
                    });
                    context.SubmitChanges();
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool Update(DatabaseDataContext context, string username, List<InventoryUserDeviceInfo> listsave)
        {
            try
            {
                //var context = new DatabaseDataContext();
                foreach (var x in listsave)
                {
                    var inventoryusers = context.InventoryUserDevices.Where(y => y.id == x.id);
                    if (inventoryusers.Count() > 0 && inventoryusers.First().ConfirmStatus == 0)
                    {
                        var inventoryuser = inventoryusers.First();
                        if (inventoryuser.Borrower.Equals(username))
                        {
                            inventoryuser.Reason = x.Reason;
                            inventoryuser.ConfirmStatus = x.ConfirmStaus;
                        }
                        else
                        {
                            return false;
                        }
                    }
                };

                context.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static List<InventoryUserDevice> ExportFormInventory(DatabaseDataContext context, int inventoryid)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var inventory = context.Inventories.Single(x => x.id == inventoryid);
                var listinventory = inventory.InventoryUserDevices.ToList();
                return listinventory;
            }
            catch (Exception)
            {
                return new List<InventoryUserDevice>();
            }
        }



        public static List<InventoryUserDevice> GetListDeviceInventory(DatabaseDataContext context, int inventoryid)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.InventoryUserDevices.Where(x => x.InventoryID == inventoryid).ToList();
            }
            catch (Exception)
            {
                return new List<InventoryUserDevice>();
            }
        }

        public static List<InventoryUserDevice> GetListDeviceInventory(DatabaseDataContext context, int inventoryid, string keyword, int type, int status, int currentpage, int numberinpage, ref int totalitem)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var list = context.InventoryUserDevices.Where(x => x.InventoryID == inventoryid && (type == 0 || (x.Device.DeviceModel.Category == type)));
                List<InventoryUserDevice> listresult = new List<InventoryUserDevice>();
                foreach (var x in list)
                {
                    if (!IsMatch(x, keyword))
                        continue;
                    if (status != -1)
                    {
                        if (status != 0 && x.LeaderConfirmStatus == 0)
                            continue;
                        if (!(x.ConfirmStatus == status || (status == 0 && x.LeaderConfirmStatus == 0)))
                            continue;
                    }
                    listresult.Add(x);
                }
                totalitem = listresult.Count();
                return listresult.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
            }
            catch (Exception)
            {
                return new List<InventoryUserDevice>();
            }
        }

        public static bool IsMatch(InventoryUserDevice inventoryuser, string keyword)
        {
            try
            {
                if (inventoryuser.User.UserName.ToLower().Contains(keyword)
                    || inventoryuser.User.FullName.ToLower().Contains(keyword)
                    || inventoryuser.User1.UserName.ToLower().Contains(keyword)
                    || inventoryuser.User1.UserName.ToLower().Contains(keyword)
                    || inventoryuser.Device.Tag.ToLower().Contains(keyword)
                    || inventoryuser.Device.Model.ToLower().Contains(keyword)
                    || inventoryuser.Device.IMEI.ToLower().Contains(keyword)
                    || inventoryuser.Device.Serial.ToLower().Contains(keyword)
                    || (inventoryuser.BorrowDate.HasValue && inventoryuser.BorrowDate.Value.ToString().ToLower().Contains(keyword)))
                    return true;
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static List<InventoryUserDevice> GetListDeviceInventory(DatabaseDataContext context, int inventoryid, string username)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.InventoryUserDevices.Where(x => x.InventoryID == inventoryid && x.Borrower.Equals(username)).ToList();
            }
            catch (Exception)
            {
                return new List<InventoryUserDevice>();
            }
        }


        public static List<InventoryUserDevice> GetListDeviceInventoryByTeam(DatabaseDataContext context, int inventoryid, string username)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var user = context.Users.Single(x => x.UserName == username);
                if (user.Team.Leader != user.UserName)
                    throw new Exception();
                var listuserinteam = user.Team.Users.Select(x => x.UserName);
                if (listuserinteam.Count() > 0)
                    return context.InventoryUserDevices.Where(x => x.InventoryID == inventoryid && x.LeaderConfirmStatus == 0 && x.ConfirmStatus != 0 && listuserinteam.Contains(x.Borrower)).ToList();
                return new List<InventoryUserDevice>();
            }
            catch (Exception)
            {
                return new List<InventoryUserDevice>();
            }
        }

        public static bool Delete(DatabaseDataContext context, int inventoryid, string username)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var inventory = context.Inventories.Where(x => x.id == inventoryid).First();
                if (inventory.RequestBy.Equals(username))
                {
                    context.Inventories.DeleteOnSubmit(inventory);
                    context.SubmitChanges();
                    return true;
                }
                return false;
            }
            catch (Exception)
            {
                return false;
            }

        }

        public static object GetInventoryRequest(DatabaseDataContext context, string username, int numberinpage)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var user = context.Users.Single(x => x.UserName == username);
                var listinventoryuser = user.InventoryUserDevices.Select(x => x.Inventory).Distinct().OrderByDescending(x => x.RequestDate);
                var listuser = user.Team.Users.Where(x => x.Team.Leader == username);
                var listinventoryleader = listuser.SelectMany(x => x.InventoryUserDevices).Select(x => x.Inventory).Distinct().OrderByDescending(x => x.RequestDate);
                return new
                {
                    UserInventory = new
                    {
                        TotalItem = listinventoryuser.Count(),
                        Data = listinventoryuser.Take(numberinpage).Select(x => new { ID = x.id, Name = x.InventoryName, RequestBy = x.RequestBy + "/" + x.User.FullName, RequestDate = x.RequestDate.ToString("MM/dd/yyyy"), DataDevice = InventoryInfo.GetDataDeviceBorrow(x, username), Status = InventoryInfo.IsFinishConfirm(x, username) })
                    },
                    LeaderInventory = new
                    {
                        TotalItem = listinventoryleader.Count(),
                        Data = listinventoryleader.Take(numberinpage).Select(x => new { ID = x.id, Name = x.InventoryName, RequestBy = x.RequestBy + "/" + x.User.FullName, RequestDate = x.RequestDate.ToString("MM/dd/yyyy"), DataInventory = InventoryInfo.LeaderGetDataInventory(x, user), Status = InventoryInfo.IsFinishLeaderConfirm(x, username) })
                    }
                };
            }
            catch (Exception)
            {
                throw;
            }

        }

        public static List<Inventory> GetInventoryRequestForTeam(DatabaseDataContext context, string username, int status, string keyword, int currentpage, int numberinpage, ref int numberitem)
        {
            try
            {
                //var context = new DatabaseDataContext();

                var user = context.Users.Single(x => x.UserName == username);
                var team = user.Team;

                if (team == null)
                    throw new Exception();

                if (team.Leader != username)
                    throw new Exception();

                var listuser = team.Users;

                var listall = listuser.SelectMany(x => x.InventoryUserDevices).Select(x => x.Inventory).Distinct().OrderByDescending(x => x.RequestDate).Where(x => (x.InventoryName.ToLower().Contains(keyword) || x.User.FullName.ToLower().Contains(keyword) || x.User.UserName.ToLower().Contains(keyword)));

                switch (status)
                {
                    case 1:
                        var list1 = listall.Where(x => x.InventoryUserDevices.Count(y => y.ConfirmStatus == 0) != 0);
                        numberitem = list1.Count();
                        return list1.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
                    case 2:
                        var list2 = listall.Where(x => x.InventoryUserDevices.Count(y => y.ConfirmStatus == 0) == 0);
                        numberitem = list2.Count();
                        return list2.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
                    default:
                        numberitem = listall.Count();
                        return listall.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
                }
            }
            catch (Exception)
            {
                return new List<Inventory>();
            }
        }

        public static List<Inventory> GetInventoryRequestForUser(DatabaseDataContext context, string username, int status, string keyword, int currentpage, int numberinpage, ref int numberitem)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var listall = context.Inventories.Where(x => (x.InventoryName.ToLower().Contains(keyword) || x.User.FullName.ToLower().Contains(keyword) || x.User.UserName.ToLower().Contains(keyword))
                              && x.InventoryUserDevices.Count(y => y.Borrower.Equals(username)) != 0).OrderByDescending(x => x.RequestDate);


                switch (status)
                {
                    case 1:
                        var list1 = listall.Where(x => x.InventoryUserDevices.Count(y => y.Borrower.Equals(username) && y.LeaderConfirmStatus != 1) == 0);
                        numberitem = list1.Count();
                        return list1.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
                    case 2:
                        var list2 = listall.Where(x => x.InventoryUserDevices.Count(y => y.Borrower.Equals(username) && y.LeaderConfirmStatus != 1) != 0);
                        numberitem = list2.Count();
                        return list2.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
                    default:
                        numberitem = listall.Count();
                        return listall.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
                }
            }
            catch (Exception)
            {
                return new List<Inventory>();
            }
        }
        public static int GetTotalDeviceBorrow(Inventory inventory)
        {
            try
            {
                return inventory.InventoryUserDevices.Count();
            }
            catch (Exception)
            {
                return 0;
            }
        }

        public static object GetDataDeviceBorrow(Inventory inventory, string username)
        {
            try
            {
                var totalborrow = inventory.InventoryUserDevices.Where(x => x.Borrower == username);
                var totaldevice = totalborrow.Count();
                var confirm = totalborrow.Count(x => x.ConfirmStatus != 0);
                var leaderaccept = totalborrow.Count(x => x.LeaderConfirmStatus == 1);
                var leaderreject = totalborrow.Count(x => x.LeaderConfirmStatus == 2);
                var pending = totalborrow.Count(x => x.ConfirmStatus != 0 && x.LeaderConfirmStatus == 0);
                return new { TotalDevice = totaldevice, Confirmed = confirm, LeaderAccepted = leaderaccept, LeaderRejected = leaderreject, Pending = pending };
            }
            catch (Exception)
            {
                return new { TotalDevice = 0, Confirmed = 0, LeaderAccepted = 0, LeaderRejected = 0, Pending = 0 };
            }
        }

        public static bool IsFinishConfirm(Inventory inventory, string username)
        {
            try
            {
                return inventory.InventoryUserDevices.Count(x => x.Borrower.Equals(username) && x.LeaderConfirmStatus != 1) == 0;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool IsFinishLeaderConfirm(Inventory inventory, string username)
        {
            try
            {
                return inventory.InventoryUserDevices.Count(x => !x.Borrower.Equals(username) && x.ConfirmStatus == 0) == 0;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static object LeaderGetDataInventory(Inventory inventory, User user)
        {
            try
            {
                if (user.Team.Leader != user.UserName)
                    throw new Exception();
                var listuser = user.Team.Users.Select(x => x.UserName);
                var temp = inventory.InventoryUserDevices.Where(x => listuser.Contains(x.Borrower));
                int totaldevice = temp.Count();
                int pending = temp.Count(x => x.LeaderConfirmStatus == 0 && x.ConfirmStatus != 0);
                int accept = temp.Count(x => x.LeaderConfirmStatus == 1);
                int reject = temp.Count(x => x.LeaderConfirmStatus == 2);
                int notconfirm = temp.Count(x => x.ConfirmStatus == 0);
                return new { TotalDevice = totaldevice, NumberAccept = accept, NumberReject = reject, NumberPending = pending, NumberNotConfirm = notconfirm };
            }
            catch (Exception)
            {
                return new { TotalDevice = 0, NumberAccept = 0, NumberReject = 0, NumberPending = 0 };
            }
        }

        public static bool AcceptConfirm(DatabaseDataContext context, int dataid, string username)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var inventory = context.InventoryUserDevices.Single(x => x.id == dataid);
                    if (inventory.User.Team.Leader != username)
                        return false;
                    if (inventory.LeaderConfirmStatus != 0)
                        return false;
                    if (inventory.ConfirmStatus == 0)
                        return false;
                    inventory.LeaderConfirmStatus = 1;
                    inventory.LeaderReasonReject = "";
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool RejectConfirm(DatabaseDataContext context, int dataid, string reason, string username)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var inventory = context.InventoryUserDevices.Single(x => x.id == dataid);
                    if (inventory.User.Team.Leader != username)
                        return false;
                    if (inventory.LeaderConfirmStatus != 0)
                        return false;
                    if (inventory.ConfirmStatus == 0)
                        return false;
                    inventory.LeaderConfirmStatus = 2;
                    inventory.LeaderReasonReject = reason;
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
