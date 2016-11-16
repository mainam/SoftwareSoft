using DataAccess.Helper;
using DataAccess.LogFolder;
using DataAccess.TeamFolder;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Serialization;

namespace DataAccess.DeviceFolder
{
    public class DeviceInfo
    {

        public class JsonStatistcTypeDevice
        {
            public int typeid;
            public string typename;
            public List<StatisticStatusDevice> statisticstatus;
            public StatisticStatusDevice FindStatus(string name)
            {
                foreach (var x in statisticstatus)
                {
                    if (x.StatusName.Equals(name))
                        return x;
                }
                var status = new StatisticStatusDevice() { CountDevices = 0, StatusName = name };
                statisticstatus.Add(status);
                return status;
            }
            public class StatisticStatusDevice
            {
                public string StatusName;
                public int CountDevices;
                public StatisticStatusDevice()
                {
                    StatusName = "";
                    CountDevices = 0;
                }
            }
            public JsonStatistcTypeDevice()
            {
                typeid = 0;
                typename = "";
                statisticstatus = new List<StatisticStatusDevice>() { 
                    new StatisticStatusDevice(){StatusName="Available"},
                    new StatisticStatusDevice(){StatusName="Borrow"},
                    new StatisticStatusDevice(){StatusName="Loss"},
                    new StatisticStatusDevice(){StatusName="Broken"}                
                };
            }

        }
        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Lấy ra statistic device
        /// </summary>
        /// <returns></returns>
        public static string GetJSONStatistcDevice(DatabaseDataContext context, string username)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var listdevices = context.Devices.Where(x => x.Manager == username);
                var listmanager = new Dictionary<string, string>();
                var result = new List<JsonStatistcTypeDevice>();
                foreach (var item in listdevices)
                {
                    if (!listmanager.ContainsKey(item.Manager))
                        listmanager[item.Manager] = item.Manager + ";" + item.User.FullName;
                    var type = result.Find(x => x.typeid == item.DeviceModel.Category);
                    if (type == null)
                    {
                        type = new JsonStatistcTypeDevice()
                        {
                            typeid = item.DeviceModel.Category,
                            typename = item.DeviceModel.CategoryDevice.Name
                        };
                        result.Add(type);
                    }
                    JsonStatistcTypeDevice.StatisticStatusDevice statisticstatus = null;
                    switch (item.StatusDevice)
                    {
                        case 1:
                            statisticstatus = type.FindStatus(item.Borrower == null ? "Available" : "Borrow");
                            statisticstatus.CountDevices++;
                            break;
                        case 2:
                            statisticstatus = type.FindStatus("Broken");
                            statisticstatus.CountDevices++;
                            break;
                        case 3:
                            statisticstatus = type.FindStatus("Loss");
                            statisticstatus.CountDevices++;
                            break;
                    }
                }
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = result, ListManager = listmanager.Select(x => x.Value) });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Lấy ra statistic device
        /// </summary>
        /// <returns></returns>
        public static string GetJSONStatistcDevice(DatabaseDataContext context)
        {
            try
            {
                //    var context = new DatabaseDataContext();
                var listdevices = context.Devices;
                var listmanager = new Dictionary<string, string>();
                var result = new List<JsonStatistcTypeDevice>();
                foreach (var item in listdevices)
                {
                    if (!listmanager.ContainsKey(item.Manager))
                        listmanager[item.Manager] = item.Manager + ";" + item.User.FullName;
                    var type = result.Find(x => x.typeid == item.DeviceModel.Category);
                    if (type == null)
                    {
                        type = new JsonStatistcTypeDevice()
                        {
                            typeid = item.DeviceModel.CategoryDevice.ID,
                            typename = item.DeviceModel.CategoryDevice.Name
                        };
                        result.Add(type);
                    }
                    JsonStatistcTypeDevice.StatisticStatusDevice statisticstatus = null;
                    switch (item.StatusDevice)
                    {
                        case 1:
                            statisticstatus = type.FindStatus(item.Borrower == null ? "Available" : "Borrow");
                            statisticstatus.CountDevices++;
                            break;
                        case 2:
                            statisticstatus = type.FindStatus("Broken");
                            statisticstatus.CountDevices++;
                            break;
                        case 3:
                            statisticstatus = type.FindStatus("Loss");
                            statisticstatus.CountDevices++;
                            break;
                    }
                }
                return new JavaScriptSerializer().Serialize(new { Status = true, Data = result, ListManager = listmanager.Select(x => x.Value) });
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// lấy ra danh sách các devcice theo các id cho trước
        /// </summary>
        /// <param name="arrid"></param>
        /// <returns></returns>
        public static List<DataDevice> GetByID(DatabaseDataContext context, List<int> arrid)
        {
            try
            {

                return context.Devices.Where(x => arrid.Contains(x.IDDevice)).Select(x => new DataDevice(x)).ToList();
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// lấy ra device theo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Device GetByID(DatabaseDataContext context, int id)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.Devices.Where(x => x.IDDevice == id).First();
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// lấy ra danh sách các device đang được mượn
        /// </summary>
        /// <returns></returns>
        public static List<Device> ListDeviceHasBorrow(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.Devices.Where(x => x.Borrower != null).ToList();
            }
            catch (Exception)
            {
                return new List<Device>();
            }
        }


        /// <summary>
        /// ngoc.nam 21/03/2015
        /// lấy ra danh sách device cần trả trong hôm nay
        /// </summary>
        /// <returns></returns>
        public static List<Device> ListDeviceReturnToday(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.Devices.Where(x => x.Borrower != null && x.ReturnDate != null && x.ReturnDate <= DateTime.Now).OrderByDescending(x => x.ReturnDate).ToList();
            }
            catch (Exception)
            {
                return new List<Device>();
            }
        }


        public static List<Status> GetAllStatus(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.Status.ToList();
            }
            catch (Exception)
            {

                return new List<Status>();
            }
        }


        /// <summary>
        /// ngoc.nam 03.03.2015
        /// lấy ra danh sách tất cả các device cần trả 
        /// </summary>
        /// <returns></returns>
        public static List<DataDevice> GetListDeviceNeedReturn(DatabaseDataContext context, string username)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var list = context.Devices.Where(x => x.Manager.Equals(username) && x.Borrower != null).Select(x => new DataDevice(x)).ToList();
                return list;
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }


        /// <summary>
        /// ngoc.nam 03.03.2015
        /// lấy ra danh sách tất cả các device cần trả 
        /// </summary>
        /// <returns></returns>
        public static List<DataDevice> GetListDeviceNeedReturn(DatabaseDataContext context, string username, string listimei)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var list = context.Devices.Where(x => x.Manager.Equals(username) && x.Borrower != null);
                var temp = listimei.Split('\n').Select(x => x.Trim().Replace("\r", "")).Where(x => x != "");
                return list.Where(x => temp.Contains(x.IMEI)).Select(x => new DataDevice(x)).ToList();
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }


        /// <summary>
        /// ngoc.nam 03.03.2015
        /// lấy ra danh sách device đang mượn cần trả
        /// </summary>
        /// <param name="type"></param>
        /// <param name="status"></param>
        /// <param name="keyword"></param>
        /// <param name="keyword2"></param>
        /// <param name="page"></param>
        /// <param name="numberinpage"></param>
        /// <param name="numberitem"></param>
        /// <returns></returns>
        public static List<DataDevice> GetListDeviceNeedReturn(DatabaseDataContext context, string username, int type, int status, string keyword, string keyword2, int page, int numberinpage, ref int numberitem)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var list = context.Devices.Where(x => x.Manager.Equals(username) && x.Borrower != null && (x.Status.ID == status || status == 0) && (x.DeviceModel.Category == type || type == 0));

                var listResult = new List<Device>(list);

                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    var listkeyword = keyword.Split('|').Where(x => !string.IsNullOrWhiteSpace(x));
                    for (int i = listResult.Count - 1; i >= 0; i--)
                    {
                        foreach (var item in listkeyword)
                        {
                            if (item.StartsWith("model:"))
                            {
                                if (!listResult[i].Model.ToLower().Contains(item.Replace("model:", "").Trim()))
                                {
                                    listResult.RemoveAt(i);
                                    break;
                                }
                            }
                            else
                            {
                                if (!IsMatch(listResult[i], item))
                                {
                                    listResult.RemoveAt(i);
                                    break;
                                }
                            }
                        }
                    }


                    //var temp = keyword.Split(':');
                    //if (temp.Length > 1 && temp[0].ToLower() == "model")
                    //{
                    //    for (int i = listResult.Count - 1; i >= 0; i--)
                    //    {
                    //        if (!listResult[i].Model.ToLower().Contains(temp[1]))
                    //            listResult.RemoveAt(i);
                    //    }
                    //}
                    //else
                    //{
                    //    for (int i = listResult.Count - 1; i >= 0; i--)
                    //    {
                    //        if (!IsMatch(listResult[i], keyword))
                    //            listResult.RemoveAt(i);
                    //    }
                    //}
                }
                //if (!string.IsNullOrWhiteSpace(keyword2))
                //{
                //    for (int i = listResult.Count - 1; i >= 0; i--)
                //    {
                //        if (!IsMatch(listResult[i], keyword2))
                //            listResult.RemoveAt(i);
                //    }
                //}

                numberitem = listResult.Count();
                return listResult.Skip((page - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }


        /// <summary>
        /// create date 21.3.2015
        /// Export danh sách device trong team
        /// </summary>
        /// <returns></returns>
        public static List<DataDevice> GetListDeviceInTeam(DatabaseDataContext context, string username)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var user = context.Users.Single(x => x.UserName == username);
                var team = user.Team;
                var list = team.Users.SelectMany(x => x.Devices3).OrderByDescending(x => x.Model).ToList();
                if (team.User != null)
                {
                    list.AddRange(team.User.Devices3);
                }
                var part = TeamInfo.GetTeamType(user, TeamLever.Part);
                if (part != null && part.TeamID == 62)
                {
                    var teampl = context.Teams.SingleOrDefault(x => x.TeamID == 64);
                    if (teampl != null)
                        list.AddRange(teampl.Users.SelectMany(x => x.Devices3));
                }

                return list.Distinct().Select(x => new DataDevice(x)).ToList();
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }


        /// <summary>
        /// create date 3.3.2014
        /// </summary>
        /// <param name="type"></param>
        /// <param name="status"></param>
        /// <param name="keyword"></param>
        /// <param name="page"></param>
        /// <param name="numberinpage"></param>
        /// <param name="numberitem"></param>
        /// <returns></returns>
        public static List<DataDevice> GetListDeviceInTeam(DatabaseDataContext context, string username, int type, int status, string keyword, int page, int numberinpage, ref int numberitem)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var user = context.Users.Single(x => x.UserName == username);
                var team = user.Team;
                var list = team.Users.SelectMany(x => x.Devices3).ToList();


                if (team.User != null)
                {
                    list.AddRange(team.User.Devices3);
                }

                var part = TeamInfo.GetTeamType(user, TeamLever.Part);
                if (part != null && part.TeamID == 62)
                {
                    var teampl = context.Teams.SingleOrDefault(x => x.TeamID == 64);
                    if (teampl != null)
                        list.AddRange(teampl.Users.SelectMany(x => x.Devices3));
                }

                list = list.Distinct().Where(x => (x.Status.ID == status || status == 0) && (x.DeviceModel.Category == type || type == 0)).OrderByDescending(x => x.Model).ToList();


                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    var listresult = new List<Device>();
                    foreach (var x in list)
                    {
                        if (IsMatch(x, keyword))
                            listresult.Add(x);
                    }
                    numberitem = listresult.Count();
                    return listresult.Skip((page - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
                }
                else
                {
                    numberitem = list.Count();
                    return list.Skip((page - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
                }
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }


        /// <summary>
        /// ngoc.nam 04.03.2015
        /// lấy ra danh sách những device cần phê duyệt là đang keeping
        /// </summary>
        /// <param name="type"></param>
        /// <param name="status"></param>
        /// <param name="keyword"></param>
        /// <param name="currentpage"></param>
        /// <param name="numberinpage"></param>
        /// <param name="numberitem"></param>
        /// <returns></returns>
        public static List<DataDevice> GetListDevicePendingTransfer(DatabaseDataContext context, int type, int status, string keyword, int currentpage, int numberinpage, ref int numberitem)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                //var context = new DatabaseDataContext();

                var list = context.Devices.Where(x => x.NewKeeper == username && (x.Status.ID == status || status == 0) && (x.DeviceModel.Category == type || type == 0)).OrderByDescending(x => x.Model);
                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    var listresult = new List<Device>();
                    foreach (var x in list)
                    {
                        if (IsMatch(x, keyword))
                            listresult.Add(x);
                    }
                    numberitem = listresult.Count();
                    return listresult.Skip((currentpage - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
                }
                else
                {
                    numberitem = list.Count();
                    return list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
                }
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }


        /// <summary>
        /// ngoc.nam 21/03/2015
        /// thực hiện transfer device qua một người khác
        /// </summary>
        /// <param name="listid"></param>
        /// <param name="username"></param>
        /// <param name="reject"></param>
        /// <returns></returns>
        public static bool ConfirmTransferDevice(DatabaseDataContext context, List<int> listid, string username, bool reject)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var listdevice = context.Devices.Where(x => listid.Contains(x.IDDevice)).ToList();
                    var newkeeper = context.Users.Single(x => x.UserName == username);
                    var data = new Dictionary<string, List<int>>();
                    for (int i = 0; i < listdevice.Count(); i++)
                    {
                        var item = listdevice[i];
                        if (!data.Keys.Contains(item.Keeper))
                            data.Add(item.Keeper, new List<int>());

                        data[item.Keeper].Add(item.IDDevice);

                        if (item.NewKeeper == username)
                        {
                            if (reject)
                            {
                                item.NewKeeper = null;
                                item.TransferDate = null;
                            }
                            else
                            {
                                item.Keeper = item.NewKeeper;
                                item.NewKeeper = null;
                                item.KeepDate = item.TransferDate;
                                item.TransferDate = null;

                                LogTransferDeviceInfo.Insert(item.IDDevice, item.Model, item.Tag, item.IMEI, item.Serial, item.Manager, item.Borrower == null ? item.Manager : item.Borrower, item.Keeper, DateTime.Now, item.Status.Name, TypeTransferDevice.user_transfer_to_member);
                            }
                        }
                        else
                            throw new Exception();
                    }

                    context.SubmitChanges();
                    // var temp = listdevice.GroupBy(x=>x.kee)

                    if (!reject)
                    {
                        foreach (var item in data)
                        {
                            var user = context.Users.Single(x => x.UserName == item.Key);
                            var temp = listdevice.Where(x => item.Value.Contains(x.IDDevice)).ToList();

                            var mailcontent = ApproveInfo.BuildMailSendRequest(newkeeper, user, "You accepted the transfer from " + user.FullName + " as below", "Please contact " + (user.Gender.ToLower() == "male" ? "Mr " : "Ms ") + user.UserName + " to get these devices", temp);
                            var listcc = new List<string>() { 
                                user.Email 
                            };
                            SendMail.send(new List<string>() { newkeeper.Email }, listcc, "[SELSVMC]Notice: Accept transfer device", mailcontent);
                        }
                    }
                    else
                    {
                        foreach (var item in data)
                        {
                            var user = context.Users.Single(x => x.UserName == item.Key);
                            var temp = listdevice.Where(x => item.Value.Contains(x.IDDevice)).ToList();
                            var mailcontent = ApproveInfo.BuildMailSendRequest(user, newkeeper, newkeeper.FullName + " has rejected some devices in your transfer as detailed below", "Please do let me know if you need more information(" + newkeeper.Email + ")", temp);
                            var listcc = new List<string>() { 
                                newkeeper.Email 
                            };
                            SendMail.send(new List<string>() { user.Email }, listcc, "[SELSVMC]Notice: Reject transfer device", mailcontent);
                        }
                    }

                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }


        /// <summary>
        /// ngoc.nam 03.03.15
        /// lấy ra danh sách tất cả device đang giu
        /// </summary>
        /// <returns></returns>


        /// <summary>
        /// ngoc.nam 03.03.15
        /// lấy ra danh sách device đang giữ
        /// </summary>
        /// <param name="type"></param>
        /// <param name="status"></param>
        /// <param name="keyword"></param>
        /// <param name="page"></param>
        /// <param name="numberinpage"></param>
        /// <param name="numberitem"></param>
        /// <returns></returns>
        public static List<DataDevice> GetListDeviceKeeping(DatabaseDataContext context, string username, int type, int status, string keyword, int page, int numberinpage, ref int numberitem)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var list = context.Devices.Where(x => x.Keeper == username && (x.Status.ID == status || status == 0) && (x.DeviceModel.Category == type || type == 0)).OrderByDescending(x => x.Model);
                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    var listresult = new List<Device>();
                    foreach (var x in list)
                    {
                        if (IsMatch(x, keyword))
                            listresult.Add(x);
                    }
                    numberitem = listresult.Count();
                    return listresult.Skip((page - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
                }
                else
                {
                    numberitem = list.Count();
                    return list.Skip((page - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
                }
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }


        /// <summary>
        /// ngoc.nam 21.01.16
        /// lấy ra danh sách device transfer pending
        /// </summary>
        /// <param name="context"></param>
        /// <param name="username"></param>
        /// <param name="type"></param>
        /// <param name="status"></param>
        /// <param name="keyword"></param>
        /// <param name="page"></param>
        /// <param name="numberinpage"></param>
        /// <param name="numberitem"></param>
        /// <returns></returns>
        public static List<DataDevice> GetListDeviceTransferPending(DatabaseDataContext context, string username, int type, int status, string keyword, int page, int numberinpage, ref int numberitem)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var list = context.Devices.Where(x => x.NewKeeper != null && (x.Status.ID == status || status == 0) && (x.DeviceModel.Category == type || type == 0)).OrderByDescending(x => x.Model);
                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    var listresult = new List<Device>();
                    foreach (var x in list)
                    {
                        if (IsMatch(x, keyword))
                            listresult.Add(x);
                    }
                    numberitem = listresult.Count();
                    return listresult.Skip((page - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
                }
                else
                {
                    numberitem = list.Count();
                    return list.Skip((page - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
                }
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }


        public static List<DataDevice> GetListDeviceTransferPending(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var list = context.Devices.Where(x => x.NewKeeper != null).OrderByDescending(x => x.Model).Select(x => new DataDevice(x)).ToList();
                return list;
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }

        /// <summary>
        /// ngoc.nam 03.03.15
        /// lấy ra danh sách device đang mượn
        /// </summary>
        /// <param name="type"></param>
        /// <param name="status"></param>
        /// <param name="keyword"></param>
        /// <param name="page"></param>
        /// <param name="numberinpage"></param>
        /// <param name="numberitem"></param>
        /// <returns></returns>
        public static List<DataDevice> GetListDeviceBorrowing(DatabaseDataContext context, int type, int status, string keyword, int page, int numberinpage, ref int numberitem)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                //var context = new DatabaseDataContext();
                var list = context.Devices.Where(x => (x.Borrower != null && x.Borrower == username) && (x.Status.ID == status || status == 0) && (x.DeviceModel.Category == type || type == 0)).OrderByDescending(x => x.Model);
                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    var listresult = new List<Device>();
                    foreach (var x in list)
                    {
                        if (IsMatch(x, keyword))
                            listresult.Add(x);
                    }
                    numberitem = listresult.Count();
                    return listresult.Skip((page - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
                }
                else
                {
                    numberitem = list.Count();
                    return list.Skip((page - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
                }
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }

        /// <summary>
        /// ngoc.nam 03.03.15
        /// lấy tất cả các device đang mượn
        /// </summary>
        /// <returns></returns>
        public static List<DataDevice> GetListDeviceBorrowing(DatabaseDataContext context, string username)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var list = context.Devices.Where(x => (x.Borrower != null && x.Borrower.Equals(username))).OrderByDescending(x => x.Model);
                return list.Select(x => new DataDevice(x)).ToList();
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }

        public static List<DataDevice> GetListDeviceKeeping(DatabaseDataContext context, string username)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var list = context.Devices.Where(x => x.Keeper == username).OrderByDescending(x => x.Model).Select(x => new DataDevice(x)).ToList();
                return list;
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }

        /// <summary>
        /// ngoc.nam 26.04.15
        /// lấy ra danh sách tất cả device đã trả
        /// </summary>
        /// <returns></returns>
        public static List<DataDevice> GetListDeviceHaveReturn(DatabaseDataContext context, string username, int type, int status, string keyword, int page, int numberinpage, ref int numberitem, DataAccess.DeviceFolder.ApproveInfo.TypeApprove _typeapprove, List<int> listignore)
        {
            try
            {
                //var context = new DatabaseDataContext();
                int typeapprove = (int)_typeapprove;
                var listdevice = context.Approves.Where(x => x.SubmitDate >= DateTime.Now.AddMonths(-2) && x.TypeApprove == typeapprove && x.StatusBorrow == 3).OrderByDescending(x => x.SubmitDate).GroupBy(x => x.IDDevice).Select(x => x.First()).Where(x => x.UserBorrow == username).OrderByDescending(x => x.Device.Model).Select(x => x.Device);
                List<Device> list = new List<Device>();
                foreach (var item in listdevice)
                {
                    if (listignore.Contains(item.IDDevice))
                        continue;

                    bool allowborrow = true;
                    if (item.Borrower != null && item.Borrower.Equals(username))
                        allowborrow = false;
                    if (item.StatusDevice != 1)
                        allowborrow = false;
                    else
                        if (item.Approves.Count() > 0 && item.Approves.Count(x => x.StatusBorrow == 1) != 0)
                            allowborrow = false;
                    if (!allowborrow)
                        continue;
                    else
                    {
                        if (!string.IsNullOrWhiteSpace(keyword))
                        {
                            if (IsMatch(item, keyword))
                                list.Add(item);
                        }
                        else
                            list.Add(item);
                    }
                }
                numberitem = list.Count();
                return list.Skip((page - 1) * numberinpage).Take(numberinpage).Select(x => new DataDevice(x)).ToList();
            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }


        /// <summary>
        /// ngoc.nam 21/3/2015
        /// lấy và phân trang danh sách device có thể mượn
        /// </summary>
        /// <param name="type"></param>
        /// <param name="status"></param>
        /// <param name="keyword"></param>
        /// <param name="page"></param>
        /// <param name="numberinpage"></param>
        /// <param name="numberitem"></param>
        /// <param name="ListIgnore"></param>
        /// <returns></returns>
        public static List<DataDevice> GetAllDeviceAllowBorrow(DatabaseDataContext context, string username, int type, int status, string keyword, int page, int numberinpage, ref int numberitem, List<int> ListIgnore)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var listfilter = context.Devices.Where(x => (x.Status.ID == status || status == 0) && (x.DeviceModel.Category == type || type == 0)).OrderByDescending(x => x.Model);
                    List<Device> list = new List<Device>();
                    foreach (var item in listfilter)
                    {
                        if (ListIgnore.Contains(item.IDDevice))
                            continue;
                        bool allowborrow = true;
                        if (item.Borrower != null && item.Borrower.Equals(username)) allowborrow = false;
                        if (item.StatusDevice != 1)
                            allowborrow = false;
                        else
                            if (item.Approves.Count() > 0 && item.Approves.Count(x => x.StatusBorrow == 1) != 0)
                                allowborrow = false;
                        if (!allowborrow)
                            continue;
                        else
                        {
                            if (!string.IsNullOrWhiteSpace(keyword))
                            {
                                if (IsMatch(item, keyword))
                                    list.Add(item);
                            }
                            else
                                list.Add(item);
                        }
                    }

                    var listtake = list.Skip((page - 1) * numberinpage).Take(numberinpage);
                    numberitem = list.Count();
                    return listtake.Select(x => new DataDevice(x)).ToList();
                }

            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015 
        /// Lấy ra danh sách tất cả device có thể mượn
        /// </summary>
        /// <returns></returns>
        public static List<DataDevice> GetAllDeviceAllowBorrow(DatabaseDataContext context, string username, List<int> ListIgnore)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var listfilter = context.Devices.OrderByDescending(x => x.Model);
                    List<Device> list = new List<Device>();
                    foreach (var item in listfilter)
                    {
                        if (ListIgnore.Contains(item.IDDevice))
                            continue;
                        bool allowborrow = true;
                        if (item.Borrower != null && item.Borrower.Equals(username)) allowborrow = false;
                        if (item.StatusDevice != 1)
                            allowborrow = false;
                        else
                            if (item.Approves.Count() > 0 && item.Approves.Count(x => x.StatusBorrow == 1) != 0)
                                allowborrow = false;
                        if (!allowborrow)
                            continue;
                        else
                        {
                            list.Add(item);
                        }
                    }

                    return list.Select(x => new DataDevice(x)).ToList();
                }

            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }


        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Lấy và phân trang danh sách tất cả các device đang quản lý
        /// </summary>
        /// <param name="username"></param>
        /// <param name="type"></param>
        /// <param name="status"></param>
        /// <param name="keyword"></param>
        /// <param name="page"></param>
        /// <param name="numberinpage"></param>
        /// <param name="numberitem"></param>
        /// <returns></returns>
        public static List<DataDevice> GetAllDeviceManagement(DatabaseDataContext context, string username, int type, int status, string keyword, int page, int numberinpage, ref int numberitem)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    List<DataDevice> list = new List<DataDevice>();
                    var listfilter = context.Devices.Where(x => x.Manager.Equals(username) && (x.Status.ID == status || status == 0) && (x.DeviceModel.Category == type || type == 0)).OrderByDescending(x => x.Model).ToList();
                    if (!string.IsNullOrWhiteSpace(keyword))
                        listfilter = listfilter.FindAll(x => IsMatch(x, keyword));
                    var listtake = listfilter.Skip((page - 1) * numberinpage).Take(numberinpage);
                    numberitem = listfilter.Count();
                    foreach (Device x in listtake)
                    {
                        DataDevice deviceInfo = new DataDevice(x);
                        list.Add(deviceInfo);
                    }
                    return list;
                }

            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }


        /// <summary>
        /// ngoc.nam 07/05/2015
        /// Lấy ra danh sách device có thể set borrow
        /// </summary>
        /// <param name="username"></param>
        /// <param name="type"></param>
        /// <param name="status"></param>
        /// <param name="keyword"></param>
        /// <param name="page"></param>
        /// <param name="numberinpage"></param>
        /// <param name="numberitem"></param>
        /// <returns></returns>
        public static List<DataDevice> GetAllDeviceAllowSetBorrow(DatabaseDataContext context, string username, int type, string status, string keyword, int page, int numberinpage, ref int numberitem)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    List<DataDevice> list = new List<DataDevice>();
                    var listfilter = context.Devices.Where(x => x.Manager.Equals(username) && x.Borrower == null && (x.Status.Name == status || status == "All") && (x.DeviceModel.Category == type || type == 0)).OrderByDescending(x => x.Model).ToList();
                    if (!string.IsNullOrWhiteSpace(keyword))
                        listfilter = listfilter.FindAll(x => IsMatch(x, keyword));
                    var listtake = listfilter.Skip((page - 1) * numberinpage).Take(numberinpage);
                    numberitem = listfilter.Count();
                    foreach (Device x in listtake)
                    {
                        DataDevice deviceInfo = new DataDevice(x);
                        list.Add(deviceInfo);
                    }
                    return list;
                }

            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// lấy ra danh sách tất cả các devuce đang quản lý
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>


        /// <summary>
        /// ngoc.nam 21/03/2015
        /// lấy ra danh sách tất cả các devuce đang quản lý
        /// </summary>
        /// <param name="username"></param>
        /// <returns></returns>
        public static List<DataDevice> GetAllDeviceManagement(DatabaseDataContext context, string username)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    //List<DataDevice> list = new List<DataDevice>();
                    var listfilter = context.Devices.Where(x => x.Manager.Equals(username)).OrderByDescending(x => x.Model);
                    return listfilter.Select(x => new DataDevice(x)).ToList();
                    //return list;
                }

            }
            catch (Exception)
            {
                return new List<DataDevice>();
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// compare device với keyword
        /// </summary>
        /// <param name="device"></param>
        /// <param name="keyword"></param>
        /// <returns></returns>
        public static bool IsMatch(Device device, string keyword)
        {
            try
            {
                if (device.Model.ToLower().Contains(keyword) ||
                    (device.Note != null && device.Note.ToLower().Contains(keyword)) ||
                    (device.Project != null && device.Project.ToLower().Contains(keyword)) ||
                    device.Serial.ToLower().Contains(keyword) ||
                    device.Version.ToLower().Contains(keyword) ||
                    device.Tag.ToLower().Contains(keyword) ||
                    device.IMEI.ToLower().Contains(keyword))
                    return true;
                if (device.Keeper != null)
                {
                    if (device.User1.UserName.ToLower().Contains(keyword) || device.User1.FullName.ToLower().Contains(keyword))
                        return true;
                }
                if (device.Borrower != null)
                {
                    if (device.User3.UserName.ToLower().Contains(keyword) || device.User3.FullName.ToLower().Contains(keyword))
                        return true;
                }
                if (device.Manager != null)
                {
                    if (device.User.UserName.ToLower().Contains(keyword) || device.User.FullName.ToLower().Contains(keyword))
                        return true;
                }
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// Lấy ra danh sách device được mượn theo user
        /// </summary>
        /// <param name="userName"></param>
        /// <returns></returns>
        public static List<DataDevice> GetByBorrower(DatabaseDataContext context, string userName)
        {
            try
            {
                //var context = new DatabaseDataContext();
                List<Device> listDevice = context.Devices.Where(x => x.Borrower == userName).ToList();
                return listDevice.Select(x => new DataDevice(x.IDDevice, x.DeviceModel.CategoryDevice.Name.Trim(), x.Tag.Trim(), x.Model.Trim(), x.Version.Trim(), x.Project.Trim(), x.Manager.Trim() + "/" + x.User.FullName.Trim(), x.Borrower + "/" + x.User3.FullName, x.Keeper.Trim() + "/" + x.User1.FullName.Trim(), x.BorrowDate.Value.ToShortDateString(), x.ReceiveDate.Value.ToShortDateString(), x.Status.Name, x.IMEI.Trim(), x.Serial.Trim(), x.Region.Trim(), x.Receiver.Trim() + "/" + x.User2.FullName.Trim(), x.ReceiveDate.Value.ToShortDateString(), x.From_.Trim(), x.Note, true, x.Cabinet == null ? 0 : x.Cabinet.Value, x.Cabinet == null ? "" : x.Cabinet1.Name, x.BorrowerNote)).ToList();
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Manager set user borrow device
        /// </summary>
        /// <param name="IDdevice"></param>
        /// <param name="manager"></param>
        /// <param name="username"></param>
        /// <param name="date"></param>
        /// <returns></returns>
        public static bool SetBorrowDevice(DatabaseDataContext context, int IDdevice, string manager, string username, string date)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var user = context.Users.Single(x => x.UserName == username);
                Device device = context.Devices.Single(x => x.IDDevice == IDdevice && x.Manager == manager);

                if (device.Borrower != null)
                    throw new Exception();

                var statuspendingborrow = ApproveInfo.getStatusBorrow(context, ApproveInfo.StatusBorrow.Pending.ToString());
                var statusrejectborrow = ApproveInfo.getStatusBorrow(context, ApproveInfo.StatusBorrow.Reject.ToString());
                var statusborrowing = ApproveInfo.getStatusBorrow(context, ApproveInfo.StatusBorrow.Borrowing.ToString());

                var statuspendingapproval = ApproveInfo.getStatusApproval(context, ApproveInfo.StatusApproval.Pending.ToString());
                var statusreject = ApproveInfo.getStatusApproval(context, ApproveInfo.StatusApproval.Reject.ToString());
                var statusapprove = ApproveInfo.getStatusApproval(context, ApproveInfo.StatusApproval.Approved.ToString());

                var listpendingborrow = device.Approves.Where(x => x.StatusBorrow == statuspendingborrow);
                var listemailpendingborrow = listpendingborrow.Select(x => x.User.Email).ToList();

                foreach (var item in listpendingborrow)
                {
                    item.StatusBorrow = statusrejectborrow;
                    item.StatusKeeper = item.StatusKeeper = statusreject;
                }

                device.Borrower = device.Keeper = username;
                device.BorrowDate = DateTime.Parse(date);
                device.KeepDate = DateTime.Parse(date);
                device.ReturnDate = device.BorrowDate.Value.AddMonths(6);
                var approve = new Approve()
                {
                    StartDate = device.BorrowDate.Value,
                    EndDate = device.ReturnDate.Value,
                    Reason = "",
                    AllowShowKeeper = true,
                    AllowShowManager = true,
                    AllowShowUserBorrow = true,
                    Borrower = device.Manager,
                    IDDevice = device.IDDevice,
                    Manager = device.Manager,
                    StatusDevice = device.StatusDevice,
                    StatusBorrow = statusborrowing,
                    StatusKeeper = statusapprove,
                    StatusManager = statusapprove,
                    UserBorrow = username,
                    SubmitDate = DateTime.Now,
                };
                LogTransferDeviceInfo.Insert(device.IDDevice, device.Model, device.Tag, device.IMEI, device.Serial, device.Manager, device.Manager, username, DateTime.Now, device.Status.Name, TypeTransferDevice.manager_set_borrow);

                context.Approves.InsertOnSubmit(approve);

                var listcc = device.DeviceModel.CategoryDevice.CCEmailBorrows.Select(x => x.User.Email).ToList();
                listcc.Add(device.User.Email);
                listcc = listcc.Distinct().ToList();

                context.SubmitChanges();

                var mailcontent1 = ApproveInfo.BuildMailSendRequest(new User() { FullName = "All Member" }, device.User, "Your request has been rejected because it was borrowed by another person", "Please do let me know if you need more information(" + device.User.Email + ")", new List<Device>() { device });
                SendMail.send(listemailpendingborrow, listcc, "[SELSVMC]Notice: Request has been rejected", mailcontent1);

                var mailcontent = ApproveInfo.BuildMailSendRequest(user, device.User, "You have been marked as keeping the device below", "Please do let me know if you need more information(" + device.User.Email + ")", new List<Device>() { device });
                listcc.Add(device.User.Email);
                SendMail.send(new List<string>() { user.Email }, listcc, "[SELSVMC]Notice: Keeping device", mailcontent);

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Manager set user borrow device
        /// </summary>
        /// <param name="IDdevice"></param>
        /// <param name="manager"></param>
        /// <param name="username"></param>
        /// <param name="date"></param>
        /// <returns></returns>
        public static bool SetBorrowDevice(DatabaseDataContext context, List<int> ListIDDevice, string manager, string username, string date)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var user = context.Users.Single(x => x.UserName == username);
                    var listdevice = new List<Device>();
                    var listmailcontent1 = new List<string>();
                    var listmailcontent2 = new List<string>();
                    var listccs = new List<List<string>>();
                    var listto1 = new List<List<string>>();

                    if (ListIDDevice.Count == 0) throw new Exception();
                    foreach (var IDdevice in ListIDDevice)
                    {
                        Device device = context.Devices.Single(x => x.IDDevice == IDdevice && x.Manager == manager);
                        listdevice.Add(device);

                        if (device.Borrower != null)
                            throw new Exception();

                        var statuspendingborrow = ApproveInfo.getStatusBorrow(context, ApproveInfo.StatusBorrow.Pending.ToString());
                        var statusrejectborrow = ApproveInfo.getStatusBorrow(context, ApproveInfo.StatusBorrow.Reject.ToString());
                        var statusborrowing = ApproveInfo.getStatusBorrow(context, ApproveInfo.StatusBorrow.Borrowing.ToString());

                        var statuspendingapproval = ApproveInfo.getStatusApproval(context, ApproveInfo.StatusApproval.Pending.ToString());
                        var statusreject = ApproveInfo.getStatusApproval(context, ApproveInfo.StatusApproval.Reject.ToString());
                        var statusapprove = ApproveInfo.getStatusApproval(context, ApproveInfo.StatusApproval.Approved.ToString());

                        var listpendingborrow = device.Approves.Where(x => x.StatusBorrow == statuspendingborrow);
                        var listemailpendingborrow = listpendingborrow.Select(x => x.User.Email).ToList();

                        foreach (var item in listpendingborrow)
                        {
                            item.StatusBorrow = statusrejectborrow;
                            item.StatusKeeper = item.StatusKeeper = statusreject;
                        }

                        device.Borrower = device.Keeper = username;
                        device.BorrowDate = DateTime.Parse(date);
                        device.KeepDate = DateTime.Parse(date);
                        device.ReturnDate = device.BorrowDate.Value.AddMonths(6);
                        var approve = new Approve()
                        {
                            StartDate = device.BorrowDate.Value,
                            EndDate = device.ReturnDate.Value,
                            Reason = "",
                            AllowShowKeeper = true,
                            AllowShowManager = true,
                            AllowShowUserBorrow = true,
                            Borrower = device.Manager,
                            IDDevice = device.IDDevice,
                            Manager = device.Manager,
                            StatusDevice = device.StatusDevice,
                            StatusBorrow = statusborrowing,
                            StatusKeeper = statusapprove,
                            StatusManager = statusapprove,
                            UserBorrow = username,
                            SubmitDate = DateTime.Now,
                        };
                        LogTransferDeviceInfo.Insert(device.IDDevice, device.Model, device.Tag, device.IMEI, device.Serial, device.Manager, device.Manager, approve.UserBorrow, DateTime.Now, device.Status.Name, TypeTransferDevice.manager_set_borrow);

                        context.Approves.InsertOnSubmit(approve);

                        var listcc = device.DeviceModel.CategoryDevice.CCEmailBorrows.Select(x => x.User.Email).ToList();
                        listcc.Add(device.User.Email);
                        var mailcontent1 = ApproveInfo.BuildMailSendRequest(new User() { FullName = "All Member" }, device.User, "Your request has been rejected because it was borrowed by another person", "Please do let me know if you need more information(" + device.User.Email + ")", new List<Device>() { device });
                        listmailcontent1.Add(mailcontent1);
                        listccs.Add(listcc.Distinct().ToList());

                        listto1.Add(listemailpendingborrow);
                    }
                    context.SubmitChanges();

                    for (int i = 0; i < listmailcontent1.Count; i++)
                        SendMail.send(listto1[i], listccs[i], "[SELSVMC]Notice: Request has been rejected", listmailcontent1[i]);

                    var mailcontent2 = ApproveInfo.BuildMailSendRequest(user, listdevice[0].User, "You have been marked as keeping the" + (ListIDDevice.Count > 1 ? "se" : "") + " device below", "Please do let me know if you need more information(" + listdevice[0].User.Email + ")", listdevice);
                    SendMail.send(new List<string>() { user.Email }, listccs.SelectMany(x => x).Distinct().ToList(), "[SELSVMC]Notice: Keeping device", mailcontent2);

                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }


        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Update device
        /// </summary>
        /// <param name="newDevice"></param>
        /// <returns></returns>
        public static bool UpdateDevice(DatabaseDataContext context, DataDevice newDevice)
        {
            try
            {
                //var context = new DatabaseDataContext();
                Device device = context.Devices.Single(x => x.IDDevice == newDevice.IDDevice);
                if (newDevice.CabinetID == 0)
                    device.Cabinet = null;
                else
                    device.Cabinet = newDevice.CabinetID;
                device.Model = newDevice.Model;
                device.StatusDevice = ApproveInfo.getStatusDevice(context, newDevice.Status);
                device.Tag = newDevice.Tag;
                device.Version = newDevice.Version;
                device.Project = newDevice.Project;
                device.Manager = newDevice.Manager;
                device.Note = newDevice.Note;
                device.IMEI = newDevice.IMEI;
                device.Serial = newDevice.Serial;
                device.Region = newDevice.Region;
                device.From_ = newDevice.From;
                device.ReceiveDate = Convert.ToDateTime(newDevice.ReceiveDate);
                device.Receiver = newDevice.Receiver;
                context.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Transfer device qua người khác
        /// </summary>
        /// <param name="deviceid"></param>
        /// <param name="keeper"></param>
        /// <param name="username"></param>
        /// <param name="transferdate"></param>
        /// <returns></returns>
        public static bool TransferDevice(DatabaseDataContext context, int deviceid, string keeper, string username, DateTime transferdate)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var user = context.Users.Single(x => x.UserName == keeper);
                var newkeeper = context.Users.Single(x => x.UserName == username);

                Device device = context.Devices.Single(x => x.IDDevice == deviceid);
                if (device.Keeper != keeper)
                    throw new Exception();
                device.TransferDate = transferdate;
                device.NewKeeper = username;
                context.SubmitChanges();

                var link = Utils.LocalHost + "/Default.aspx#device/MyDevice/ConfirmKeepingDevice.aspx";

                var mailcontent = ApproveInfo.BuildMailSendRequest(newkeeper, user, "You have been marked as keeping the device below", "To receive the/these device, you have to access to <a target='_blank' href='" + link + "'>HERE</a> and confirm information or access the link as below. <br> <a target='_blank' href='" + link + "'>" + link + "</a><br><br>Please do let me know if you need more information(" + user.Email + ")", new List<Device>() { device });

                var listcc = new List<string>() { 
                    user.Email,
                };

                SendMail.send(new List<string>() { newkeeper.Email }, listcc, "[SELSVMC]Notice: Confirm keeping device", mailcontent);

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Chuyển 1 list device sang cho người khác giữ
        /// </summary>
        /// <param name="ListDevice"></param>
        /// <param name="keeper"></param>
        /// <param name="username"></param>
        /// <param name="transferdate"></param>
        /// <returns></returns>
        public static bool TransferDevice(DatabaseDataContext context, List<int> ListDevice, string keeper, string username, DateTime transferdate)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var user = context.Users.Single(x => x.UserName == keeper);
                    var newkeeper = context.Users.Single(x => x.UserName == username);
                    var listdevice = new List<Device>();
                    foreach (var item in ListDevice)
                    {
                        Device device = context.Devices.Single(x => x.IDDevice == item);
                        listdevice.Add(device);
                        if (device.Keeper != keeper)
                            throw new Exception();
                        device.TransferDate = transferdate;
                        device.NewKeeper = username;
                    }
                    context.SubmitChanges();
                    var link = Utils.LocalHost + "/Default.aspx#device/MyDevice/ConfirmKeepingDevice.aspx";

                    var mailcontent = ApproveInfo.BuildMailSendRequest(newkeeper, user, "You have been marked as keeping the device below", "To receive the/these device, you have to access to <a target='_blank' href='" + link + "'>HERE</a> and confirm information or access the link as below. <br> <a target='_blank' href='" + link + "'>" + link + "</a><br><br>Please do let me know if you need more information(" + user.Email + ")", listdevice);
                    var listcc = new List<string>() { user.Email };
                    SendMail.send(new List<string>() { newkeeper.Email }, listcc, "[SELSVMC]Notice: Confirm keeping device", mailcontent);

                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Cancel transfer device
        /// </summary>
        /// <param name="DeviceID"></param>
        /// <param name="keeper"></param>
        /// <returns></returns>
        public static bool CancelTransferDevice(DatabaseDataContext context, int DeviceID, string keeper)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    Device device = context.Devices.Single(x => x.IDDevice == DeviceID);
                    if (device.Keeper != keeper)
                        throw new Exception();
                    device.TransferDate = null;
                    device.NewKeeper = null;
                    context.SubmitChanges();
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Borrower thu lại device
        /// </summary>
        /// <param name="deviceid"></param>
        /// <param name="borrower"></param>
        /// <returns></returns>
        public static bool RetrieveDevice(DatabaseDataContext context, int deviceid, string borrower)
        {
            try
            {
                //var context = new DatabaseDataContext();
                Device device = context.Devices.Single(x => x.IDDevice == deviceid);
                if (device.Borrower != borrower)
                    throw new Exception();
                device.KeepDate = DateTime.Now;
                device.Keeper = borrower;
                context.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Xóa 1 device
        /// </summary>
        /// <param name="ID"></param>
        /// <returns></returns>
        public static bool DeleteDevice(DatabaseDataContext context, int ID, string username)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    Device device = context.Devices.Single(x => x.IDDevice == ID && x.Manager == username);
                    context.Devices.DeleteOnSubmit(device);
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// thêm mới  1 device
        /// </summary>
        /// <param name="deviceInfo"></param>
        /// <returns></returns>
        public static bool AddDevice(DatabaseDataContext context, DataDevice deviceInfo)
        {
            try
            {
                //var context = new DatabaseDataContext();
                Device device = new Device()
                {
                    Model = deviceInfo.Model,
                    Tag = deviceInfo.Tag,
                    Project = deviceInfo.Project,
                    Manager = deviceInfo.Manager,
                    Keeper = deviceInfo.Keeper,
                    BorrowDate = Convert.ToDateTime(deviceInfo.BorrowDate),
                    ReturnDate = Convert.ToDateTime(deviceInfo.ReturnDate),
                    StatusDevice = ApproveInfo.getStatusDevice(context, deviceInfo.Status),
                    IMEI = deviceInfo.IMEI,
                    Serial = deviceInfo.Serial,
                    Region = deviceInfo.Region,
                    Version = deviceInfo.Version,
                    Receiver = deviceInfo.Receiver,
                    From_ = deviceInfo.From,
                    ReceiveDate = Convert.ToDateTime(deviceInfo.ReceiveDate),
                    Borrower = deviceInfo.Borrower,
                    Note = deviceInfo.Note,
                    Cabinet = null,
                };
                if (deviceInfo.CabinetID != 0)
                    device.Cabinet = deviceInfo.CabinetID;
                context.Devices.InsertOnSubmit(device);
                context.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// thêm mới nhiều device
        /// </summary>
        /// <param name="ListDevice"></param>
        /// <returns></returns>
        public static bool AddDevice(DatabaseDataContext context, List<Device> ListDevice)
        {
            try
            {
                //var context = new DatabaseDataContext();
                context.Devices.InsertAllOnSubmit(ListDevice);
                context.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        public static int GetTypeDevice(DatabaseDataContext context, string type)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.CategoryDevices.Single(x => x.Name.Equals(type)).ID;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Return 1 list device
        /// </summary>
        /// <param name="listid"></param>
        /// <param name="username"></param>
        /// <returns></returns>
        public static bool ReturnDevice(DatabaseDataContext context, List<int> listid, string username)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var listdevice = context.Devices.Where(x => listid.Contains(x.IDDevice) && x.Manager == username);

                    var returned = ApproveInfo.getStatusBorrow(context, ApproveInfo.StatusBorrow.Returned.ToString());
                    var borrowing = ApproveInfo.getStatusBorrow(context, ApproveInfo.StatusBorrow.Borrowing.ToString());

                    var listtemp = listdevice.GroupBy(x => x.Borrower);
                    var listuser = listtemp.Select(x => x.First().User3).ToList();

                    foreach (var x in listdevice)
                    {
                        LogTransferDeviceInfo.Insert(x.IDDevice, x.Model, x.Tag, x.IMEI, x.Serial, x.Manager, x.Borrower == null ? x.Manager : x.Borrower, x.Manager, DateTime.Now, x.Status.Name, TypeTransferDevice.manager_return);
                        x.Borrower = null;
                        x.Keeper = null;
                        x.NewKeeper = null;
                        x.TransferDate = null;
                        x.KeepDate = null;
                        x.ReturnDate = DateTime.Now;
                        x.BorrowDate = null;
                        x.BorrowerNote = null;
                        var listapprove = x.Approves.Where(y => y.StatusBorrow == borrowing);
                        foreach (var y in listapprove)
                            y.StatusBorrow = returned;
                    }
                    context.SubmitChanges();

                    int i = 0;
                    foreach (var item in listtemp)
                    {
                        var mailcontent = ApproveInfo.BuildMailSendRequest(listuser[i], item.First().User, "You have returned successful " + item.Count() + (item.Count() > 1 ? " devices" : " device") + " below", "Please do let me know if you need more information(" + item.First().User.Email + ")", item.ToList());
                        var listcc = item.SelectMany(x => x.DeviceModel.CategoryDevice.CCEmailBorrows).Select(x => x.User.Email).Distinct().ToList();
                        listcc.Add(item.First().User.Email);
                        SendMail.send(new List<string>() { listuser[i].Email }, listcc, "[SELSVMC]Notice: Returned device", mailcontent);
                        i++;
                    }
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Get ra list model để borrow theo model
        /// </summary>
        /// <param name="totalitem"></param>
        /// <param name="keyword"></param>
        /// <param name="numberinpage"></param>
        /// <param name="currentpage"></param>
        /// <param name="type"></param>
        /// <param name="username"></param>
        /// <returns></returns>
        public static List<DataModelDevice> GetListDataModelDevice(DatabaseDataContext context, ref int totalitem, string keyword, int numberinpage, int currentpage, int type, string username)
        {
            try
            {
                keyword = keyword.ToLower();
                //var context = new DatabaseDataContext();
                var listmodel = context.Devices.GroupBy(x => new { x.Manager, x.Model }).OrderByDescending(x => x.First().Model).ToList();
                for (int i = 0; i < listmodel.Count; i++)
                {
                    var item = listmodel[i];
                    var device = item.First();
                    if (type == 0 || type == device.DeviceModel.Category)
                    {
                        if (device.Model.ToLower().Contains(keyword)
                            || device.DeviceModel.Company.ToLower().Contains(keyword)
                            || device.Manager.ToLower().Contains(keyword)
                            || device.User.FullName.Contains(keyword))
                            continue;
                    }
                    listmodel.RemoveAt(i);
                    i--;
                }


                totalitem = listmodel.Count();
                var listtake = listmodel.Skip((currentpage - 1) * numberinpage).Take(numberinpage);
                var listresult = new List<DataModelDevice>();
                var listappropending = context.Approves.Where(x => x.StatusBorrow == 1 && x.Device.Borrower == null);
                foreach (var item in listtake)
                {
                    var borrowed = item.Count(x => x.Borrower != null);
                    var youborrow = item.Count(x => x.Borrower != null && x.Borrower == username);
                    var pendingapprove = item.Count(x => listappropending.Count(y => y.IDDevice == x.IDDevice) > 0);
                    var available = item.Count(x => x.StatusDevice == 1 && x.Borrower == null && listappropending.Count(y => y.IDDevice == x.IDDevice) == 0);
                    listresult.Add(new DataModelDevice(item.First(), available, borrowed, youborrow, pendingapprove));
                }
                return listresult;
            }
            catch (Exception)
            {
                return new List<DataModelDevice>();
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// Add nhiều device
        /// </summary>
        /// <param name="username"></param>
        /// <param name="model"></param>
        /// <param name="status"></param>
        /// <param name="manager"></param>
        /// <param name="receiver"></param>
        /// <param name="receiverdate"></param>
        /// <param name="numberdevice"></param>
        /// <param name="from"></param>
        /// <param name="region"></param>
        /// <returns></returns>
        public static bool AddMultipleDevice(DatabaseDataContext context, string username, string model, string status, string manager, string receiver, string receiverdate, int numberdevice, string from, string region)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var user = context.DeviceManagers.Single(x => x.UserName == username);
                    if (user == null)
                        return false;
                    var _status = context.Status.Single(x => x.Name.ToLower() == status.ToLower());
                    var _model = context.DeviceModels.Single(x => x.ModelName == model);
                    for (int i = 0; i < numberdevice; i++)
                    {
                        var device = new Device()
                        {
                            StatusDevice = _status.ID,
                            Model = _model.ModelName,
                            Tag = "N/A",
                            IMEI = "N/A",
                            Serial = "N/A",
                            ReceiveDate = Convert.ToDateTime(receiverdate),
                            Receiver = receiver,
                            Manager = manager,
                            From_ = from,
                            Region = region,
                            Version = "N/A",
                            Note = "",
                            Project = "",
                            Cabinet = null
                        };
                        if (i < 9)
                            device.Tag = "#0" + (i + 1);
                        else
                            device.Tag = "#" + (i + 1);
                        context.Devices.InsertOnSubmit(device);
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


        /// <summary>
        /// ngoc.nam 07.06.2015
        /// Cho phep user borrow save note cho device
        /// </summary>
        /// <param name="DeviceID"></param>
        /// <param name="username"></param>
        /// <param name="NoteContent"></param>
        /// <returns></returns>
        public static bool SaveNote(DatabaseDataContext context, int DeviceID, string username, string NoteContent)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var device = context.Devices.SingleOrDefault(x => x.IDDevice == DeviceID && x.Borrower == username);
                    if (device != null)
                    {
                        device.BorrowerNote = NoteContent;
                        context.SubmitChanges();
                        return true;
                    }
                    return false;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
    }
}
