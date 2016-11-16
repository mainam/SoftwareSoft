using DataAccess.Helper;
using DataAccess.LogFolder;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.DeviceFolder
{
    public class ApproveInfo
    {
        public enum TypeApprove
        {
            ApproveBorrow = 1,
            ApproveKeep = 2
        }

        public enum StatusApproval
        {
            Pending, Approved, Reject
        }
        public enum StatusDevice
        {
            Loss, Broken, Good
        }
        public enum StatusBorrow
        {
            Pending, Borrowing, Returned,
            Cancel, Reject
        }

        // return all approve info
        //public static List<ApproveInfo> getAll()
        //{
        //    try
        //    {
        //        var context = new DatabaseDataContext();
        //        List<Approve> listApprove = context.Approves.ToList();
        //        return listApprove.Select(x => new ApproveInfo(x.IDApprove, x.IDDevice, x.Device.Tag, x.Device.Model, x.SubmitDate.ToShortDateString(), x.StartDate.ToShortDateString(), x.EndDate.ToShortDateString(), x.UserBorrow + "/" + x.User2.Name, x.Manager + "/" + x.User21.Name, x.Keeper + "/" + x.User22.Name, x.StatusApproval1.Name, x.StatusApproval.Name, x.Reason, x.StatusBorrow1.Name, x.Status.Name)).ToList();
        //    }
        //    catch (Exception)
        //    {
        //        return null;
        //    }
        //}


        // Get my approval
        /// <summary>
        /// ngoc.nam 11/05/2014
        /// Get List Approval
        /// </summary>
        /// <param name="username"></param>
        /// <param name="type"></param>
        /// <param name="keyword"></param>
        /// <param name="currentpage"></param>
        /// <param name="numberinpage"></param>
        /// <param name="status"></param>
        /// <param name="totalitem"></param>
        /// <param name="typeApprove"></param>
        /// <returns></returns>
        public static List<DataApprove> GetListApproval(DatabaseDataContext context, string username, int type, string keyword, int currentpage, int numberinpage, string status, ref int totalitem, TypeApprove typeApprove)
        {
            try
            {
                //var context = new DatabaseDataContext();

                //var listApprove = context.Approves.Where(x => (x.TypeApprove == (int)typeApprove && x.Device.DeviceModel.Category == type || type == 0) && (x.Manager == username && x.AllowShowManager && x.Borrower == null) || (x.Borrower == username && x.AllowShowKeeper)).Distinct().OrderByDescending(x => x.SubmitDate);
                var listApprove = context.Approves.Where(x => (x.Device.DeviceModel.Category == type || type == 0) && (x.Manager == username && x.AllowShowManager && x.Borrower == null) || (x.Borrower == username && x.AllowShowKeeper) || username == null).Distinct().OrderByDescending(x => x.SubmitDate);
                var listresult = new List<Approve>();
                foreach (var item in listApprove)
                {
                    if (item.Device.Model.ToLower().Contains(keyword)
                        || item.Device.Tag.ToLower().Contains(keyword)
|| item.Device.Serial.ToLower().Contains(keyword)
                        || item.Device.IMEI.ToLower().Contains(keyword)
                        || item.Device.DeviceModel.CategoryDevice.Name.ToLower().Contains(keyword)
                        || item.Status.Name.ToLower().Contains(keyword)
                        || item.Device.Model.ToLower().Contains(keyword)
                        || item.UserBorrow.ToLower().Contains(keyword)
                        || item.User.FullName.ToLower().Contains(keyword))
                    {
                        if (status == "All")
                        {
                            listresult.Add(item);
                        }
                        else
                        {
                            if (status == item.StatusBorrow1.Name)
                                listresult.Add(item);
                        }
                    }
                }

                var list = new List<DataApprove>();
                totalitem = listresult.Count();
                foreach (Approve x in listresult)
                {
                    string borrower = "";
                    if (x.Borrower != null) borrower = x.Borrower + "/" + x.User2.FullName;
                    DataApprove approveInfo = new DataApprove(x.IDApprove, x.IDDevice, x.Device.DeviceModel.CategoryDevice.Name, x.Device.Tag, x.Device.Model, x.Device.IMEI, x.Device.Serial, x.SubmitDate.ToShortDateString(), x.StartDate.ToShortDateString(), x.EndDate.ToShortDateString(), x.UserBorrow + "/" + x.User.FullName, x.Manager + "/" + x.User1.FullName, borrower, x.StatusApproval.Name, x.StatusApproval1.Name, x.Reason, x.StatusBorrow1.Name, x.Status.Name, x.AllowShowKeeper, x.AllowShowManager);
                    list.Add(approveInfo);
                }
                return list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
            }
            catch (Exception)
            {
                return new List<DataApprove>();
            }
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="username"></param>
        /// <param name="type"></param>
        /// <param name="keyword"></param>
        /// <param name="currentpage"></param>
        /// <param name="numberinpage"></param>
        /// <param name="status"></param>
        /// <param name="totalitem"></param>
        /// <param name="typeApprove"></param>
        /// <returns></returns>
        public static List<object> GetListApproval2(DatabaseDataContext context, string username, int type, string keyword, int currentpage, int numberinpage, ref int totalitem, TypeApprove typeApprove)
        {
            try
            {
                //var context = new DatabaseDataContext();

                var listApprove = context.Approves.Where(x => x.StatusBorrow == 1 && (x.Device.DeviceModel.Category == type || type == 0) && ((x.Manager == username && x.AllowShowManager && x.Borrower == null) || (x.Borrower == username && x.AllowShowKeeper))).Distinct().OrderByDescending(x => x.SubmitDate);

                var listgroup = listApprove.GroupBy(x => new { x.UserBorrow, x.Device.Model }).ToList();

                if (!string.IsNullOrWhiteSpace(keyword))
                {
                    for (int i = 0; i < listgroup.Count; i++)
                    {
                        var item = listgroup[i].First();
                        if (!(item.Device.Model.ToLower().Contains(keyword)
                       || item.Device.DeviceModel.CategoryDevice.Name.ToLower().Contains(keyword)
                       || item.UserBorrow.ToLower().Contains(keyword)
                       || item.User.FullName.ToLower().Contains(keyword)))
                        {
                            listgroup.RemoveAt(i);
                            i--;
                        }
                    }
                }

                return listgroup.Skip((currentpage - 1) * numberinpage).Take(numberinpage).Select(x => (new { ID = x.First().UserBorrow + x.First().Device.Model, x.First().Device.Model, Type = x.First().Device.DeviceModel.CategoryDevice.Name, Count = x.Count(), x.First().User.UserName, x.First().User.FullName }) as object).ToList();

                //var list = new List<ApproveInfo>();
                //totalitem = listresult.Count();
                //foreach (Approve x in listresult)
                //{
                //    string borrower = "";
                //    if (x.Borrower != null) borrower = x.Borrower + "/" + x.User2.FullName;
                //    ApproveInfo approveInfo = new ApproveInfo(x.IDApprove, x.IDDevice, x.Device.DeviceModel.CategoryDevice.Name, x.Device.Tag, x.Device.Model, x.Device.IMEI, x.Device.Serial, x.SubmitDate.ToShortDateString(), x.StartDate.ToShortDateString(), x.EndDate.ToShortDateString(), x.UserBorrow + "/" + x.User.FullName, x.Manager + "/" + x.User1.FullName, borrower, x.StatusApproval.Name, x.StatusApproval1.Name, x.Reason, x.StatusBorrow1.Name, x.Status.Name, x.AllowShowKeeper, x.AllowShowManager);
                //    list.Add(approveInfo);
                //}
                //return list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
            }
            catch (Exception)
            {
                return new List<object>();
            }
        }

        public static void GetActionApproval(DatabaseDataContext context, string username, List<DataApprove> listApprove2, ref List<int> AllowApproval, ref List<int> AllowRemove, TypeApprove typeApprove)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var listApprove = context.Approves.Where(x => x.Manager == username && x.Borrower == null || x.Borrower == username).Distinct();
                foreach (var item in listApprove2)
                {
                    var approve = context.Approves.Single(y => y.IDApprove == item.IDApprove);
                    bool allowapproval = false, allowremove = false;
                    CheckStatusApproval(username, approve, ref allowremove, ref allowapproval, ApproveInfo.TypeApprove.ApproveBorrow);
                    if (allowremove) AllowRemove.Add(approve.IDApprove);
                    if (allowapproval) AllowApproval.Add(approve.IDApprove);
                }
            }
            catch (Exception)
            {
                AllowApproval = new List<int>();
                AllowRemove = new List<int>();
            }
        }

        public static void CheckStatusApproval(string username, Approve approval, ref bool allowremove, ref bool allowapproval, TypeApprove typeApprove)
        {
            StatusApproval statusmanagerapproval = Converts.ToEnum<StatusApproval>(approval.StatusApproval.Name);
            StatusApproval statuskeeperapproval = Converts.ToEnum<StatusApproval>(approval.StatusApproval1.Name);
            StatusBorrow statusborrow = Converts.ToEnum<StatusBorrow>(approval.StatusBorrow1.Name);
            allowapproval = allowremove = false;
            bool ismanager = approval.Manager.Equals(username);
            switch (statusborrow)
            {
                case StatusBorrow.Pending:
                    if (ismanager)
                    {
                        allowapproval = true;
                        break;
                    }
                    else
                    {
                        switch (statuskeeperapproval)
                        {
                            case StatusApproval.Pending:
                                allowapproval = true;
                                break;
                            case StatusApproval.Approved:
                            case StatusApproval.Reject:
                                allowremove = true;
                                break;
                        }
                    }
                    break;
                case StatusBorrow.Returned:
                case StatusBorrow.Cancel:
                case StatusBorrow.Reject:
                    allowremove = true;
                    break;
            }
        }

        // Approve list ID
        public static bool Approve(DatabaseDataContext context, string approver, string userborrow, string modelname, int numberdevice, List<int> listselected)
        {
            try
            {

                //using (var context = new DatabaseDataContext())
                {
                    if (listselected.Count > numberdevice || numberdevice <= 0)
                        throw new Exception();

                    var user = context.Users.Single(x => x.UserName == approver);

                    var statuspendingborrow = getStatusBorrow(context, StatusBorrow.Pending.ToString());
                    var statusrejectborrow = getStatusBorrow(context, StatusBorrow.Reject.ToString());
                    var statusborrowing = getStatusBorrow(context, StatusBorrow.Borrowing.ToString());
                    var statusreturned = getStatusBorrow(context, StatusBorrow.Returned.ToString());

                    var statusapproval = getStatusApproval(context, StatusApproval.Approved.ToString());
                    var statusreject = getStatusApproval(context, StatusApproval.Reject.ToString());

                    var listtempapprove = new List<Approve>();


                    var model = context.DeviceModels.SingleOrDefault(x => x.ModelName == modelname);
                    if (model == null) throw new Exception();

                    var listdevice = model.Devices.Where(x => x.StatusDevice == 1 && ((x.Borrower == null && x.Manager == approver) || (x.Borrower != null && x.Borrower == approver)));
                    var listnewdevice = listdevice.Where(x => listselected.Contains(x.IDDevice)).ToList();

                    var listapprove = listdevice.SelectMany(x => x.Approves).Where(x => x.UserBorrow == userborrow && ((x.Borrower == null && x.Manager == approver) || (x.Borrower != null && x.Borrower == approver)) && x.StatusBorrow == statuspendingborrow).GroupBy(x => x.IDDevice).Select(x => x.First()).ToList();

                    if (listnewdevice.Count() != listselected.Count() || listapprove.Count() < listnewdevice.Count())
                        throw new Exception();

                    var ListReject = new List<Approve>();

                    for (int i = 0; i < listnewdevice.Count; i++)
                    {
                        Device newDevice = listnewdevice[i];
                        var approve = listapprove[i];
                        //Nếu chuyển device
                        if (listnewdevice[i] != listapprove[i].Device)
                        {
                            //kiem tra xem device hiện tại mình đang mượn hay không
                            if (approve.Device.Borrower == approver || (approve.Device.Borrower == null && approve.Device.Manager == approver))
                            {
                                //lưu lại tất cả approve peding của device mới
                                var temp = newDevice.Approves.Where(x => x.StatusBorrow == statuspendingborrow).ToList();

                                //lưu lại device hiện tại.
                                var device = approve.Device;

                                //1. gán approve cho device mới.
                                approve.Device = newDevice;
                                approve.IDDevice = newDevice.IDDevice;

                                //duyệt qua các approve pending của device mới.
                                foreach (var item in temp)
                                {
                                    //gán cho device hiện tại
                                    item.IDDevice = newDevice.IDDevice;
                                    item.Device = device;
                                }
                            }
                            //new device hiện tại đã cho mượn rồi
                            else
                            {
                                // the them tất cả những request peing của device mới vào danh sách reject;
                                ListReject = newDevice.Approves.Where(x => x.StatusBorrow == statuspendingborrow).ToList();
                            }
                        }
                        // Nếu không chuyển device
                        else
                        {
                            //nếu device hiện tại mình không mượn hoặc không phải là manager
                            if ((approve.Device.Borrower == null && approve.Device.Manager != approver) || (approve.Device.Borrower != null && approve.Device.Borrower != approver))
                            {
                                ////thi reject request
                                //approve.StatusKeeper = approve.StatusManager = statusreject;
                                //approve.StatusBorrow = statusrejectborrow;
                                //context.SubmitChanges();

                                ////send mail
                                //var mailcontent1 = BuildMailSendRequest(approve.User, user, "Your request has been rejected because it was borrowed by another person", "Please do let me know if you need more information( " + user.Email + ")", new List<Device>() { approve.Device });
                                //var listcc1 = approve.Device.DeviceModel.CategoryDevice.CCEmailBorrows.Distinct().Select(x => x.User.Email).ToList();
                                //listcc1.Add(user.Email);
                                //listcc1.Distinct();
                                //SendMail.send(
                                //    new List<string>() { approve.User.Email }, listcc1,
                                //    string.Format("[SELSVMC]Notice: Request has been rejected"), mailcontent1);
                                return false;
                            }
                            //ngươc lai 
                            else
                            {

                            }
                            {
                                //add tất cả những request peding khác vào list reject
                                ListReject = approve.Device.Approves.Where(x => x.StatusBorrow == statuspendingborrow && x.IDApprove != approve.IDApprove).ToList();
                            }
                        }


                        //tien hành cho mượn device 
                        LogTransferDeviceInfo.Insert(approve.Device.IDDevice, approve.Device.Model, approve.Device.Tag, approve.Device.IMEI, approve.Device.IMEI, approve.Device.Manager, approve.Device.Borrower == null ? approve.Device.Manager : approve.Device.Borrower, approve.UserBorrow, DateTime.Now, approve.Device.Status.Name, approve.Device.Borrower == null ? TypeTransferDevice.borrow_from_manager : TypeTransferDevice.borrow_form_user);

                        approve.StatusManager = statusapproval;
                        approve.StatusKeeper = statusapproval;
                        approve.StatusBorrow = statusborrowing;
                        approve.Device.Borrower = approve.Device.Keeper = approve.UserBorrow;
                        approve.Device.BorrowDate = approve.StartDate;
                        approve.Device.NewKeeper = null;
                        approve.Device.KeepDate = null;
                        approve.Device.TransferDate = null;
                        approve.Device.ReturnDate = approve.EndDate;

                        //return tất cả những borrow trước đó.
                        var tmp = approve.Device.Approves.Where(y => y.StatusBorrow == statusborrowing && y.IDApprove != approve.IDApprove);
                        foreach (var y in tmp)
                            y.StatusBorrow = statusreturned;

                    }

                    //reject tat ca nhung approve khong hop le

                    foreach (var item in ListReject)
                    {
                        item.StatusKeeper = item.StatusManager = statusreject;
                        item.StatusBorrow = statusrejectborrow;
                    }

                    context.SubmitChanges();

                    //send mail approve
                    var mailcontent2 = BuildMailSendRequest(listapprove.First().User, user, "Your request have been approved a device with information as below", "Please contact " + (user.Gender.ToLower() == "male" ? "Mr " : "Ms ") + user.UserName + " to get device", listnewdevice);

                    var listcc2 = listnewdevice.SelectMany(x => x.DeviceModel.CategoryDevice.CCEmailBorrows).Select(y => y.User.Email).Distinct().ToList();
                    listcc2.AddRange(listapprove.Select(x => x.User1.Email));
                    listcc2.Add(user.Email);
                    listcc2 = listcc2.Distinct().ToList();
                    SendMail.send(
                        new List<string>() { listapprove.First().User.Email }, listcc2,
                        string.Format("[SELSVMC]Notice: Request borrow device from {0} (Approved) ", listapprove.First().User.FullName), mailcontent2);

                    //send mail reject
                    var listuserreject = ListReject.GroupBy(x => new { x.UserBorrow });

                    foreach (var item in listuserreject)
                    {
                        mailcontent2 = BuildMailSendRequest(item.First().User, user, "Your request has been rejected because it was borrowed by another person", "Please do let me know if you need more information( " + user.Email + ")", item.Select(x => x.Device).Distinct().ToList());
                        var listcc = item.SelectMany(x => x.Device.DeviceModel.CategoryDevice.CCEmailBorrows).Select(x => x.User.Email).Distinct().ToList();
                        listcc.Add(user.Email);
                        listcc = listcc.Distinct().ToList();
                        SendMail.send(
                            new List<string>() { item.First().User.Email }, listcc,
                            string.Format("[SELSVMC]Notice: Request has been rejected"), mailcontent2);
                    }
                    return true;



                    //    var approve = context.Approves.SingleOrDefault(x => x.IDApprove == IDApprove && x.StatusBorrow == statuspendingborrow && x.IDDevice == IDDevice && (x.Borrower.Equals(IDApprover) || (x.Borrower == null && x.Manager.Equals(IDApprover))));
                    //    if (approve == null)
                    //        return false;

                    //    Device newDevice = null;
                    //    //Nếu chuyển device
                    //    if (NewIDDevice != IDDevice)
                    //    {
                    //        newDevice = approve.Device.DeviceModel.Devices.SingleOrDefault(x => x.IDDevice == NewIDDevice && x.StatusDevice == 1);
                    //        //neu device moi minh khong muon thi return
                    //        if (!(newDevice != null && newDevice.Borrower != null && newDevice.Borrower.Equals(IDApprover) || (newDevice.Borrower == null && newDevice.Manager.Equals(IDApprover))))
                    //            return false;

                    //        //kiem tra xem device hiện tại mình đang mượn hay không
                    //        if (approve.Device.Borrower == IDApprover || (approve.Device.Borrower == null && approve.Device.Manager == IDApprover))
                    //        {
                    //            //lưu lại tất cả approve peding của device mới
                    //            var temp = newDevice.Approves.Where(x => x.StatusBorrow == statuspendingborrow).ToList();

                    //            //lưu lại device hiện tại.
                    //            var device = approve.Device;

                    //            //1. gán approve cho device mới.
                    //            approve.Device = newDevice;
                    //            approve.IDDevice = NewIDDevice;

                    //            //duyệt qua các approve pending của device mới.
                    //            foreach (var item in temp)
                    //            {
                    //                //gán cho device hiện tại
                    //                item.IDDevice = IDDevice;
                    //                item.Device = device;
                    //            }
                    //        }
                    //        //new device hiện tại đã cho mượn rồi
                    //        else
                    //        {
                    //            // the them tất cả những request peing của device mới vào danh sách reject;
                    //            ListReject = newDevice.Approves.Where(x => x.StatusBorrow == statuspendingborrow).ToList();
                    //        }
                    //    }
                    //    // Nếu không chuyển device
                    //    else
                    //    {
                    //        //nếu device hiện tại mình không mượn hoặc không phải là manager
                    //        if ((approve.Device.Borrower == null && approve.Device.Manager != IDApprover) || (approve.Device.Borrower != null && approve.Device.Borrower != IDApprover))
                    //        {
                    //            //thi reject request
                    //            approve.StatusKeeper = approve.StatusManager = statusreject;
                    //            approve.StatusBorrow = statusrejectborrow;
                    //            context.SubmitChanges();

                    //            //send mail
                    //            var mailcontent1 = BuildMailSendRequest(approve.User, user, "Your request has been rejected because it was borrowed by another person", "Please do let me know if you need more information( " + user.Email + ")", new List<Device>() { approve.Device });
                    //            var listcc1 = approve.Device.DeviceModel.CategoryDevice.CCEmailBorrows.Distinct().Select(x => x.User.Email).ToList();
                    //            listcc1.Add(user.Email);
                    //            listcc1.Distinct();
                    //            SendMail.send(
                    //                new List<string>() { approve.User.Email }, listcc1,
                    //                string.Format("[SELSVMC]Notice: Request has been rejected"), mailcontent1);
                    //            return false;
                    //        }
                    //        //ngươc lai 
                    //        else
                    //        {
                    //            //add tất cả những request peding khác vào list reject
                    //            ListReject = approve.Device.Approves.Where(x => x.StatusBorrow == statuspendingborrow && x.IDApprove != IDApprove).ToList();
                    //        }
                    //    }


                    //    //tien hành cho mượn device 
                    //    approve.StatusManager = statusapproval;
                    //    approve.StatusKeeper = statusapproval;
                    //    approve.StatusBorrow = statusborrowing;
                    //    approve.Device.Borrower = approve.Device.Keeper = approve.UserBorrow;
                    //    approve.Device.BorrowDate = approve.StartDate;
                    //    approve.Device.NewKeeper = null;
                    //    approve.Device.KeepDate = null;
                    //    approve.Device.TransferDate = null;
                    //    approve.Device.ReturnDate = approve.EndDate;

                    //    //return tất cả những borrow trước đó.
                    //    var tmp = approve.Device.Approves.Where(y => y.StatusBorrow == statusborrowing && y.IDApprove != IDApprove);
                    //    foreach (var y in tmp)
                    //        y.StatusBorrow = statusreturned;

                    //    //reject tat ca nhung approve khong hop le
                    //    foreach (var item in ListReject)
                    //    {
                    //        item.StatusKeeper = item.StatusManager = statusreject;
                    //        item.StatusBorrow = statusrejectborrow;
                    //    }

                    //    context.SubmitChanges();

                    //    //send mail approve
                    //    var mailcontent2 = BuildMailSendRequest(approve.User, user, "Your request have been approved a device with information as below", "Please contact " + (user.Gender.ToLower() == "male" ? "Mr " : "Ms ") + user.UserName + " to get device", new List<Device> { approve.Device });
                    //    var listcc2 = approve.Device.DeviceModel.CategoryDevice.CCEmailBorrows.Distinct().Select(x => x.User.Email).ToList();
                    //    listcc2.Add(approve.User1.Email);
                    //    listcc2.Add(user.Email);
                    //    listcc2 = listcc2.Distinct().ToList();
                    //    SendMail.send(
                    //        new List<string>() { approve.User.Email }, listcc2,
                    //        string.Format("[SELSVMC]Notice: Request borrow device from {0} (Approved) ", approve.User.FullName), mailcontent2);

                    //    //send mail reject
                    //    var listuserreject = ListReject.GroupBy(x => new { x.UserBorrow }).Select(x => x.First());

                    //    foreach (var item in listuserreject)
                    //    {
                    //        mailcontent2 = BuildMailSendRequest(item.User, user, "Your request has been rejected because it was borrowed by another person", "Please do let me know if you need more information( " + user.Email + ")", new List<Device> { item.Device });
                    //        var listcc = item.Device.DeviceModel.CategoryDevice.CCEmailBorrows.Distinct().Select(x => x.User.Email).ToList();
                    //        listcc.Add(user.Email);
                    //        listcc.Distinct();
                    //        SendMail.send(
                    //            new List<string>() { item.User.Email }, listcc,
                    //            string.Format("[SELSVMC]Notice: Request has been rejected"), mailcontent2);
                    //    }
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }


        // Approve list ID
        public static bool Approve(DatabaseDataContext context, int IDApprove, int IDDevice, int NewIDDevice, string IDApprover)
        {
            try
            {

                //using (var context = new DatabaseDataContext())
                {
                    var user = context.Users.Single(x => x.UserName == IDApprover);

                    var statuspendingborrow = getStatusBorrow(context, StatusBorrow.Pending.ToString());
                    var statusrejectborrow = getStatusBorrow(context, StatusBorrow.Reject.ToString());
                    var statusborrowing = getStatusBorrow(context, StatusBorrow.Borrowing.ToString());
                    var statusreturned = getStatusBorrow(context, StatusBorrow.Returned.ToString());

                    var statusapproval = getStatusApproval(context, StatusApproval.Approved.ToString());
                    var statusreject = getStatusApproval(context, StatusApproval.Reject.ToString());

                    var listtempapprove = new List<Approve>();

                    List<Approve> ListReject = new List<Approve>();

                    var approve = context.Approves.SingleOrDefault(x => x.IDApprove == IDApprove && x.StatusBorrow == statuspendingborrow && x.IDDevice == IDDevice && (x.Borrower.Equals(IDApprover) || (x.Borrower == null && x.Manager.Equals(IDApprover))));
                    if (approve == null)
                        return false;

                    Device newDevice = null;
                    //Nếu chuyển device
                    if (NewIDDevice != IDDevice)
                    {
                        newDevice = approve.Device.DeviceModel.Devices.SingleOrDefault(x => x.IDDevice == NewIDDevice && x.StatusDevice == 1);
                        //neu device moi minh khong muon thi return
                        if (!(newDevice != null && newDevice.Borrower != null && newDevice.Borrower.Equals(IDApprover) || (newDevice.Borrower == null && newDevice.Manager.Equals(IDApprover))))
                            return false;

                        //kiem tra xem device hiện tại mình đang mượn hay không
                        if (approve.Device.Borrower == IDApprover || (approve.Device.Borrower == null && approve.Device.Manager == IDApprover))
                        {
                            //lưu lại tất cả approve peding của device mới
                            var temp = newDevice.Approves.Where(x => x.StatusBorrow == statuspendingborrow).ToList();

                            //lưu lại device hiện tại.
                            var device = approve.Device;

                            //1. gán approve cho device mới.
                            approve.Device = newDevice;
                            approve.IDDevice = NewIDDevice;

                            //duyệt qua các approve pending của device mới.
                            foreach (var item in temp)
                            {
                                //gán cho device hiện tại
                                item.IDDevice = IDDevice;
                                item.Device = device;
                            }
                        }
                        //new device hiện tại đã cho mượn rồi
                        else
                        {
                            // the them tất cả những request peing của device mới vào danh sách reject;
                            ListReject = newDevice.Approves.Where(x => x.StatusBorrow == statuspendingborrow).ToList();
                        }
                    }
                    // Nếu không chuyển device
                    else
                    {
                        //nếu device hiện tại mình không mượn hoặc không phải là manager
                        if ((approve.Device.Borrower == null && approve.Device.Manager != IDApprover) || (approve.Device.Borrower != null && approve.Device.Borrower != IDApprover))
                        {
                            //thi reject request
                            approve.StatusKeeper = approve.StatusManager = statusreject;
                            approve.StatusBorrow = statusrejectborrow;
                            context.SubmitChanges();

                            //send mail
                            var mailcontent1 = BuildMailSendRequest(approve.User, user, "Your request has been rejected because it was borrowed by another person", "Please do let me know if you need more information( " + user.Email + ")", new List<Device>() { approve.Device });
                            var listcc1 = approve.Device.DeviceModel.CategoryDevice.CCEmailBorrows.Distinct().Select(x => x.User.Email).ToList();
                            listcc1.Add(user.Email);
                            listcc1.Distinct();
                            SendMail.send(
                                new List<string>() { approve.User.Email }, listcc1,
                                string.Format("[SELSVMC]Notice: Request has been rejected"), mailcontent1);
                            return false;
                        }
                        //ngươc lai 
                        else
                        {
                            //add tất cả những request peding khác vào list reject
                            ListReject = approve.Device.Approves.Where(x => x.StatusBorrow == statuspendingborrow && x.IDApprove != IDApprove).ToList();
                        }
                    }


                    //tien hành cho mượn device 
                    LogTransferDeviceInfo.Insert(approve.Device.IDDevice, approve.Device.Model, approve.Device.Tag, approve.Device.IMEI, approve.Device.IMEI, approve.Device.Manager, approve.Device.Borrower == null ? approve.Device.Manager : approve.Device.Borrower, approve.UserBorrow, DateTime.Now, approve.Device.Status.Name, approve.Device.Borrower == null ? TypeTransferDevice.borrow_from_manager : TypeTransferDevice.borrow_form_user);

                    approve.StatusManager = statusapproval;
                    approve.StatusKeeper = statusapproval;
                    approve.StatusBorrow = statusborrowing;
                    approve.Device.Borrower = approve.Device.Keeper = approve.UserBorrow;
                    approve.Device.BorrowDate = approve.StartDate;
                    approve.Device.NewKeeper = null;
                    approve.Device.KeepDate = null;
                    approve.Device.TransferDate = null;
                    approve.Device.ReturnDate = approve.EndDate;

                    //return tất cả những borrow trước đó.
                    var tmp = approve.Device.Approves.Where(y => y.StatusBorrow == statusborrowing && y.IDApprove != IDApprove);
                    foreach (var y in tmp)
                        y.StatusBorrow = statusreturned;

                    //reject tat ca nhung approve khong hop le
                    foreach (var item in ListReject)
                    {
                        item.StatusKeeper = item.StatusManager = statusreject;
                        item.StatusBorrow = statusrejectborrow;
                    }

                    context.SubmitChanges();

                    //send mail approve
                    var mailcontent2 = BuildMailSendRequest(approve.User, user, "Your request have been approved a device with information as below", "Please contact " + (user.Gender.ToLower() == "male" ? "Mr " : "Ms ") + user.UserName + " to get device", new List<Device> { approve.Device });
                    var listcc2 = approve.Device.DeviceModel.CategoryDevice.CCEmailBorrows.Distinct().Select(x => x.User.Email).ToList();
                    listcc2.Add(approve.User1.Email);
                    listcc2.Add(user.Email);
                    listcc2 = listcc2.Distinct().ToList();
                    SendMail.send(
                        new List<string>() { approve.User.Email }, listcc2,
                        string.Format("[SELSVMC]Notice: Request borrow device from {0} (Approved) ", approve.User.FullName), mailcontent2);

                    //send mail reject
                    var listuserreject = ListReject.GroupBy(x => new { x.UserBorrow }).Select(x => x.First());

                    foreach (var item in listuserreject)
                    {
                        mailcontent2 = BuildMailSendRequest(item.User, user, "Your request has been rejected because it was borrowed by another person", "Please do let me know if you need more information( " + user.Email + ")", new List<Device> { item.Device });
                        var listcc = item.Device.DeviceModel.CategoryDevice.CCEmailBorrows.Distinct().Select(x => x.User.Email).ToList();
                        listcc.Add(user.Email);
                        listcc.Distinct();
                        SendMail.send(
                            new List<string>() { item.User.Email }, listcc,
                            string.Format("[SELSVMC]Notice: Request has been rejected"), mailcontent2);
                    }
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        // Approve list ID
        public static bool Approve(DatabaseDataContext context, int[] IDApprove, string IDApprover, TypeApprove typeApprove)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var user = context.Users.Single(x => x.UserName == IDApprover);
                var listapproval = context.Approves.Where(x => IDApprove.Contains(x.IDApprove) && (x.Borrower.Equals(IDApprover) || x.Manager.Equals(IDApprover)));

                var statuspendingborrow = getStatusBorrow(context, StatusBorrow.Pending.ToString());
                var statusrejectborrow = getStatusBorrow(context, StatusBorrow.Reject.ToString());
                var statusborrowing = getStatusBorrow(context, StatusBorrow.Borrowing.ToString());
                var statusreturned = getStatusBorrow(context, StatusBorrow.Returned.ToString());

                var statusapproval = getStatusApproval(context, StatusApproval.Approved.ToString());
                var statusreject = getStatusApproval(context, StatusApproval.Reject.ToString());
                var listtempapprove = new List<Approve>();

                List<Approve> ListReject = new List<Approve>();
                List<Approve> ListApprove = new List<Approve>();

                foreach (var approve in listapproval)
                {
                    if (approve.Device.Borrower != null && approve.Device.Borrower != IDApprover)
                    {
                        approve.StatusKeeper = approve.StatusManager = statusreject;
                        approve.StatusBorrow = statusrejectborrow;
                        ListReject.Add(approve);
                        continue;
                    }
                    if (approve.Borrower != null && approve.Borrower != IDApprover)
                    {
                        approve.StatusKeeper = approve.StatusManager = statusreject;
                        approve.StatusBorrow = statusrejectborrow;
                        ListReject.Add(approve);
                        continue;
                    }

                    if (approve.StatusBorrow != statuspendingborrow)
                        continue;


                    approve.StatusManager = statusapproval;
                    approve.StatusKeeper = statusapproval;

                    if (approve.Borrower != null)
                    {
                        var tmp = approve.Device.Approves.Where(y => y.UserBorrow.Equals(approve.Borrower) && y.StatusBorrow == statusborrowing);
                        foreach (var y in tmp)
                            y.StatusBorrow = statusreturned;
                    }

                    var listapprovepending = approve.Device.Approves.Where(y => y.IDApprove != approve.IDApprove && y.StatusBorrow == statuspendingborrow);
                    ListReject.AddRange(listapprovepending);

                    foreach (var item in listapprovepending)
                    {
                        item.StatusKeeper = item.StatusManager = statusreject;
                        item.StatusBorrow = statusrejectborrow;
                    }

                    LogTransferDeviceInfo.Insert(approve.Device.IDDevice, approve.Device.Model, approve.Device.Tag, approve.Device.IMEI, approve.Device.IMEI, approve.Device.Manager, approve.Device.Borrower == null ? approve.Device.Manager : approve.Device.Borrower, approve.UserBorrow, DateTime.Now, approve.Device.Status.Name, approve.Device.Borrower == null ? TypeTransferDevice.borrow_from_manager : TypeTransferDevice.borrow_form_user);
                    approve.StatusBorrow = statusborrowing;
                    approve.Device.Borrower = approve.Device.Keeper = approve.UserBorrow;
                    approve.Device.BorrowDate = approve.StartDate;
                    approve.Device.NewKeeper = null;
                    approve.Device.KeepDate = null;
                    approve.Device.TransferDate = null;
                    approve.Device.ReturnDate = approve.EndDate;
                    ListApprove.Add(approve);
                }

                context.SubmitChanges();

                var listuser = ListApprove.GroupBy(x => x.UserBorrow);
                foreach (var item in listuser)
                {
                    var listdevice = item.Select(x => x.Device).ToList();
                    var mailcontent = BuildMailSendRequest(item.First().User, user, "Your request have been approved " + item.Count() + (item.Count() > 1 ? " devices" : " device") + " with information as below", "Please contact " + (user.Gender.ToLower() == "male" ? "Mr " : "Ms ") + user.UserName + " to get these devices", listdevice);
                    var listcc = listdevice.SelectMany(x => x.DeviceModel.CategoryDevice.CCEmailBorrows).Distinct().Select(x => x.User.Email).ToList();
                    listcc.AddRange(item.Select(x => x.User1.Email));
                    listcc.AddRange(item.Where(x => x.User2 != null).Select(x => x.User2.Email));
                    listcc.Distinct();
                    SendMail.send(
                        new List<string>() { item.First().User.Email }, listcc,
                        string.Format("[SELSVMC]Notice: Request borrow device from {0} (Approved) ", item.First().User.FullName), mailcontent);
                }

                var listuserreject = ListReject.Where(x => listapproval.SingleOrDefault(y => y.UserBorrow == x.UserBorrow && y.IDDevice == x.IDDevice) == null).GroupBy(x => new { x.IDDevice, x.UserBorrow }).Select(x => x.First()).GroupBy(x => x.UserBorrow);

                foreach (var item in listuserreject)
                {
                    var listdevice = item.Select(x => x.Device).ToList();
                    var mailcontent = BuildMailSendRequest(item.First().User, user, "Your request has been rejected because it was borrowed by another person", "Please do let me know if you need more information( " + user.Email + ")", listdevice);
                    var listcc = listdevice.SelectMany(x => x.DeviceModel.CategoryDevice.CCEmailBorrows).Distinct().Select(x => x.User.Email).ToList();
                    listcc.Add(user.Email);
                    listcc.Distinct();
                    SendMail.send(
                        new List<string>() { item.First().User.Email }, listcc,
                        string.Format("[SELSVMC]Notice: Request has been rejected"), mailcontent);
                }
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        // Reject list ID
        public static bool Reject(DatabaseDataContext context, int[] IDApprove, string IDApprover, TypeApprove typeApprove)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var user = context.Users.Single(x => x.UserName == IDApprover);
                var listapproval = context.Approves.Where(x => IDApprove.Contains(x.IDApprove) && (x.Borrower.Equals(IDApprover) || x.Manager.Equals(IDApprover)));

                var statuspendingborrow = getStatusBorrow(context, StatusBorrow.Pending.ToString());
                var statusrejectborrow = getStatusBorrow(context, StatusBorrow.Reject.ToString());

                var statuspendingapproval = getStatusApproval(context, StatusApproval.Pending.ToString());
                var statusreject = getStatusApproval(context, StatusApproval.Reject.ToString());
                var ListReject = new List<Approve>();

                foreach (var x in listapproval)
                {
                    if (x.StatusBorrow != statuspendingborrow)
                        continue;

                    if (x.Borrower == null)
                    {
                        x.StatusManager = statusreject;
                        x.StatusKeeper = statusreject;
                    }
                    else
                    {
                        if (x.Borrower == IDApprover)
                        {
                            if (x.StatusKeeper != statuspendingapproval)
                                continue;
                            x.StatusKeeper = statusreject;
                        }
                        if (x.Manager == IDApprover)
                        {
                            if (x.StatusManager != statuspendingapproval)
                                continue;
                            x.StatusManager = statusreject;
                        }
                    }
                    if (x.StatusManager == statusreject || x.StatusKeeper == statusreject)
                    {
                        x.StatusBorrow = statusrejectborrow;
                        ListReject.Add(x);
                    }
                }
                context.SubmitChanges();

                var listuserreject = ListReject.GroupBy(x => new { x.IDDevice, x.UserBorrow }).Select(x => x.First()).GroupBy(x => x.UserBorrow);

                foreach (var item in listuserreject)
                {
                    var listdevice = item.Select(x => x.Device).ToList();
                    var mailcontent = BuildMailSendRequest(item.First().User, user, "Your request has been rejected " + item.Count() + (item.Count() > 1 ? " devices" : " device") + " with information as bellow", "Please do let me know if you need more information( " + user.Email + ")", listdevice);
                    var listcc = listdevice.SelectMany(x => x.DeviceModel.CategoryDevice.CCEmailBorrows).Distinct().Select(x => x.User.Email).ToList();
                    listcc.Add(user.Email);
                    listcc.Distinct();
                    SendMail.send(
                        new List<string>() { item.First().User.Email }, listcc,
                        string.Format("[SELSVMC]Notice: Request has been rejected"), mailcontent);
                }

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }
        // Reject list ID

        public static bool DeleteApprove(DatabaseDataContext context, List<int> IDApprove, string username, TypeApprove typeApprove)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var statuscancel = getStatusBorrow(context, StatusBorrow.Cancel.ToString());
                var statuspending = getStatusBorrow(context, StatusBorrow.Pending.ToString());
                var statusreturned = getStatusBorrow(context, StatusBorrow.Returned.ToString());
                var statusreject = getStatusBorrow(context, StatusBorrow.Reject.ToString());
                var statusborrowing = getStatusBorrow(context, StatusBorrow.Borrowing.ToString());

                var listapproval = context.Approves.Where(x => IDApprove.Contains(x.IDApprove));

                var listdelete = new List<Approve>();
                foreach (var x in listapproval)
                {
                    if (x.StatusBorrow == statusborrowing || x.StatusBorrow == statuspending)
                        return false;
                    if (username != x.UserBorrow && x.Borrower != username && x.Manager != username)
                        return false;

                    if (username.Equals(x.Manager) || username.Equals(x.Borrower))
                    {
                        x.AllowShowManager = false;
                        x.AllowShowKeeper = false;
                    }
                    if (username.Equals(x.UserBorrow))
                        x.AllowShowUserBorrow = false;

                    if (x.AllowShowKeeper == false && x.AllowShowManager == false && x.AllowShowUserBorrow == false)
                        listdelete.Add(x);
                }
                if (listdelete.Count > 0)
                    context.Approves.DeleteAllOnSubmit(listdelete);
                context.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        // return all approve from user borrow
        public static List<DataApprove> GetListRequest(DatabaseDataContext context, string username, int type, string keyword, int currentpage, int numberinpage, string status, ref int totalitem, ref List<int> AllowCancel, ref List<int> AllowDelete, TypeApprove typeApprove)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var statuspending = getStatusBorrow(context, StatusBorrow.Pending.ToString());
                List<DataApprove> list = new List<DataApprove>();
                var listApprove = context.Approves.Where(x => (x.Device.DeviceModel.Category == type || type == 0) && x.UserBorrow == username && x.AllowShowUserBorrow == true).OrderByDescending(x => x.SubmitDate);

                var listresult = new List<Approve>();
                foreach (var item in listApprove)
                {
                    if (item.Device.Model.ToLower().Contains(keyword)
                        || item.Device.Tag.ToLower().Contains(keyword)
                        || item.Device.Serial.ToLower().Contains(keyword)
                        || item.Device.IMEI.ToLower().Contains(keyword)
                        || item.Device.DeviceModel.CategoryDevice.Name.ToLower().Contains(keyword)
                        || item.Status.Name.ToLower().Contains(keyword)
                        || item.Manager.ToLower().Contains(keyword)
                        || item.User1.FullName.ToLower().Contains(keyword)
                        || (item.Borrower != null && item.User2.UserName.ToLower().Contains(keyword))
                        || (item.Borrower != null && item.User2.FullName.ToLower().Contains(keyword)))
                    {

                        if (status == "All")
                        {
                            listresult.Add(item);
                        }
                        else
                        {
                            if (status == item.StatusBorrow1.Name)
                                listresult.Add(item);
                        }
                    }
                }

                totalitem = listresult.Count();

                var temp = listresult.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList();
                foreach (var x in temp)
                {
                    string keeper = "";
                    if (x.Borrower != null)
                        keeper = x.Borrower + "/" + x.User2.FullName;
                    else
                        keeper = x.Manager + "/" + x.User1.FullName;
                    DataApprove approveInfo = new DataApprove(x.IDApprove, x.IDDevice, x.Device.DeviceModel.CategoryDevice.Name, x.Device.Tag, x.Device.Model, x.Device.IMEI, x.Device.Serial, x.SubmitDate.ToShortDateString(), x.StartDate.ToShortDateString(), x.EndDate.ToShortDateString(), x.UserBorrow + "/" + x.User.FullName, keeper, keeper, x.Borrower == null ? x.StatusApproval.Name : x.StatusApproval1.Name, x.StatusApproval1.Name, x.Reason, x.StatusBorrow1.Name, x.Status.Name, x.AllowShowKeeper, x.AllowShowManager);
                    list.Add(approveInfo);

                    if (x.StatusBorrow == statuspending)
                        AllowCancel.Add(x.IDApprove);
                    else if (x.StatusBorrow1.Name == StatusBorrow.Reject.ToString()
                        || x.StatusBorrow1.Name == StatusBorrow.Returned.ToString()
                        || x.StatusBorrow1.Name == StatusBorrow.Cancel.ToString())
                        AllowDelete.Add(x.IDApprove);

                }
                return list;
            }
            catch (Exception)
            {

                return null;
            }
        }
        // return all approve from user borrow

        public static List<int> getIDByPending(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                List<Approve> listApprove = context.Approves.Where(x => x.StatusBorrow == getStatusBorrow(context, StatusBorrow.Pending.ToString())).ToList();
                return listApprove.Select(x => x.IDDevice).ToList();
            }
            catch (Exception)
            {

                return null;
            }
        }

        public static bool CancelApproval(DatabaseDataContext context, List<int> listIDApproval, string username, TypeApprove typeApprove)
        {
            var pending = getStatusBorrow(context, StatusBorrow.Pending.ToString());
            var cancel = getStatusBorrow(context, StatusBorrow.Cancel.ToString());
            try
            {
                //var context = new DatabaseDataContext();
                var listapproval = context.Approves.Where(x => listIDApproval.Contains(x.IDApprove));
                foreach (var item in listapproval)
                {
                    if (item.StatusBorrow != pending || item.UserBorrow != username)
                        return false;
                    item.StatusBorrow = cancel;
                }
                context.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }


        //public static List<Approve> returnList(List<DataApprove> listApprove, TypeApprove typeApprove)
        //{
        //    try
        //    {
        //        //var context = new DatabaseDataContext();
        //        List<Approve> list = new List<Approve>();
        //        foreach (DataApprove x in listApprove)
        //        {
        //            string borrower = null;
        //            if (x.Borrower != "") borrower = x.Borrower.Split('/')[0];
        //            Approve approve = new Approve()
        //            {
        //                IDDevice = x.IDDevice,
        //                SubmitDate = DateTime.Now,
        //                StartDate = Convert.ToDateTime(x.StartDate),
        //                EndDate = Convert.ToDateTime(x.EndDate),
        //                UserBorrow = x.UserBorrow.Split('/')[0],
        //                Manager = x.Manager.Split('/')[0],
        //                Borrower = borrower,
        //                StatusManager = getStatusApproval(x.StatusManager),
        //                StatusKeeper = getStatusApproval(x.StatusKeeper),
        //                Reason = x.Reason,
        //                StatusBorrow = getStatusBorrow(x.StatusBorrow),
        //                StatusDevice = getStatusDevice(x.StatusDevice),
        //                AllowShowKeeper = x.AllowShowKeeper,
        //                AllowShowManager = x.AllowShowManager
        //            };
        //            list.Add(approve);
        //        }
        //        return list;
        //        //return listApprove.Select(x => new Approve() { IDDevice = x.IDDevice, SubmitDate = Convert.ToDateTime(x.SubmitDate), StartDate = Convert.ToDateTime(x.StartDate), EndDate = Convert.ToDateTime(x.EndDate), UserBorrow = x.UserBorrow.Split('/')[0], Manager = x.Manager.Split('/')[0], Borrower = x.Borrower.Split('/')[0], StatusManager = getStatusApproval(x.StatusManager), StatusKeeper = getStatusApproval(x.StatusKeeper), Reason = x.Reason, StatusBorrow = getStatusBorrow(x.StatusBorrow), StatusDevice = getStatusDevice(x.StatusDevice) }).ToList();
        //    }
        //    catch (Exception)
        //    {
        //        return null;
        //    }
        //}

        //public static int getStatusApproval(DatabaseDataContext context,string status)
        //{
        //    try
        //    {
        //        //using (var context = new DatabaseDataContext())
        //        {
        //            return context.StatusApprovals.Single(x => x.Name.Equals(status)).ID;
        //        }
        //    }
        //    catch (Exception)
        //    {
        //        return -1;
        //    }
        //}
        public static int getStatusApproval(DatabaseDataContext context, string status)
        {
            try
            {
                return context.StatusApprovals.Single(x => x.Name.Equals(status)).ID;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        //public static int getStatusBorrow(DatabaseDataContext context,string status)
        //{
        //    try
        //    {
        //        //using (var context = new DatabaseDataContext())
        //        {
        //            return context.StatusBorrows.Single(x => x.Name.Equals(status)).ID;
        //        }
        //    }
        //    catch (Exception)
        //    {
        //        return -1;
        //    }
        //}

        public static int getStatusBorrow(DatabaseDataContext context, string status)
        {
            try
            {
                return context.StatusBorrows.Single(x => x.Name.Equals(status)).ID;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        //public static int getStatusDevice(DatabaseDataContext context,string status)
        //{
        //    try
        //    {
        //        //using (var context = new DatabaseDataContext())
        //        {
        //            return context.Status.Single(x => x.Name.Equals(status)).ID;
        //        }
        //    }
        //    catch (Exception)
        //    {
        //        return -1;
        //    }
        //}

        public static int getStatusDevice(DatabaseDataContext context, string status)
        {
            try
            {
                return context.Status.Single(x => x.Name.Equals(status)).ID;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public static bool AddNewApproval(DatabaseDataContext context, List<int> listid, string username, DateTime from, DateTime to, string reason, TypeApprove typeApprove)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var listdevice = context.Devices.Where(x => listid.Contains(x.IDDevice));
                var user = context.Users.Single(x => x.UserName == username);
                var listapprovedevice = context.Approves.Where(x => listid.Contains(x.IDDevice));
                var listapproval = new List<Approve>();
                var pendingaproval = getStatusApproval(context, StatusApproval.Pending.ToString());
                var pendingborrow = getStatusApproval(context, StatusBorrow.Pending.ToString());
                var listdevicetemp = new List<Device>();
                foreach (var x in listdevice)
                {
                    if (x.Borrower == username) continue;
                    if (x.Approves.Count(y => y.StatusBorrow == pendingborrow) != 0)
                        continue;
                    listdevicetemp.Add(x);
                    var approval = new Approve()
                    {
                        IDDevice = x.IDDevice,
                        Reason = reason,
                        StartDate = from,
                        EndDate = to,
                        SubmitDate = DateTime.Now,
                        AllowShowKeeper = true,
                        AllowShowManager = x.Borrower == null ? true : false,
                        AllowShowUserBorrow = true,
                        UserBorrow = username,
                        Borrower = x.Borrower,
                        Manager = x.Manager,
                        StatusManager = pendingaproval,
                        StatusKeeper = pendingaproval,
                        StatusBorrow = pendingborrow,
                        StatusDevice = x.StatusDevice,
                        TypeApprove = (int)typeApprove


                    };
                    listapproval.Add(approval);
                }
                context.Approves.InsertAllOnSubmit(listapproval);
                context.SubmitChanges();

                var listborrower = listdevicetemp.GroupBy(x => x.Borrower);
                foreach (var item in listborrower)
                {
                    if (item.First().Borrower != null)
                    {
                        var mailcontent = BuildMailSendRequest(item.First().User3, user, "I want to borrow " + item.Count() + (item.Count() > 1 ? " devices" : " device") + " with information as bellow", "Please approve for me.", item.ToList());
                        SendMail.send(
                            new List<string>() { item.First().User3.Email },
                            new List<string>() { user.Email, item.First().User.Email },
                            string.Format("[SELSVMC] Request borrow device from {0}", user.FullName), mailcontent);
                    }
                    else
                    {
                        var listmanager = item.GroupBy(x => x.Manager);
                        foreach (var item2 in listmanager)
                        {
                            var mailcontent = BuildMailSendRequest(item2.First().User, user, "I want to borrow " + +item2.Count() + (item2.Count() > 1 ? " devices" : " device") + " with information as below", "Please approve for me.", item2.ToList());
                            SendMail.send(
                                new List<string>() { item2.First().User.Email },
                                new List<string>() { user.Email },
                                string.Format("[SELSVMC] Request borrow device from {0}", user.FullName), mailcontent);
                        }
                    }

                }

                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static bool AddNewApproval(DatabaseDataContext context, int NumberDevice, string ModelID, string Manager, string username, DateTime startDate, DateTime endDate, string Reason, TypeApprove typeApprove)
        {
            try
            {
                //using (var context = new DatabaseDataContext())
                {
                    var user = context.Users.Single(x => x.UserName == username);
                    var manager = context.Users.Single(x => x.UserName == Manager);
                    var pendingaproval = getStatusApproval(context, StatusApproval.Pending.ToString());
                    var pendingborrow = getStatusApproval(context, StatusBorrow.Pending.ToString());

                    var model = context.DeviceModels.Single(x => x.ModelName == ModelID);
                    var listavailable = model.Devices.Where(x => x.StatusDevice == 1 && x.Manager == Manager && x.Borrower == null && x.Approves.Count(y => y.StatusBorrow == 1 && y.StatusBorrow == 2) == 0).OrderBy(x => x.Manager).ToList();
                    if (listavailable.Count() < NumberDevice)
                        return false;
                    var listapproval = new List<Approve>();
                    for (int i = 0; i < NumberDevice; i++)
                    {
                        var approve = new Approve()
                        {
                            AllowShowKeeper = true,
                            AllowShowUserBorrow = true,
                            AllowShowManager = true,
                            Borrower = listavailable[i].Borrower,
                            EndDate = endDate,
                            StartDate = startDate,
                            Reason = Reason,
                            IDDevice = listavailable[i].IDDevice,
                            Manager = listavailable.First().Manager,
                            StatusKeeper = pendingaproval,
                            StatusManager = pendingaproval,
                            StatusBorrow = pendingborrow,
                            StatusDevice = listavailable[i].StatusDevice,
                            UserBorrow = username,
                            SubmitDate = DateTime.Now,
                            TypeApprove = (int)typeApprove
                        };
                        listapproval.Add(approve);
                    }
                    context.Approves.InsertAllOnSubmit(listapproval);
                    context.SubmitChanges();
                    var listmanager = listavailable.Take(NumberDevice).GroupBy(x => x.Manager);
                    foreach (var item in listmanager)
                    {
                        var mailcontent = BuildMailSendRequest(item.First().User, user, "I want to borrow " + +item.Count() + (item.Count() > 1 ? " devices" : " device") + " with information as below", "Please approve for me.", item.ToList());
                        SendMail.send(
                            new List<string>() { manager.Email },
                            new List<string>() { user.Email },
                            string.Format("[SELSVMC] Request borrow device from {0}", user.FullName),
                            mailcontent);
                    }
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }



        public static List<object> GetInformationSameModel(DatabaseDataContext context, string username, string ModelName, int IDDevice)
        {
            try
            {

                //using (var context = new DatabaseDataContext())
                {
                    var listreturn = new List<object>();
                    var model = context.DeviceModels.Single(x => x.ModelName == ModelName);
                    var listdevicesamemodel = model.Devices.Where(x => x.StatusDevice == 1 && (x.Borrower == username || (x.Borrower == null && x.Manager == username)));
                    bool hasDevice = false;
                    foreach (var item in listdevicesamemodel)
                    {
                        if (!hasDevice && item.IDDevice == IDDevice)
                            hasDevice = true;
                        listreturn.Add(new { Tag = string.Format("[Tag: {0}] - [IMEI: {1}] - [Serial: {2}]", item.Tag, item.IMEI, item.Serial), item.IDDevice });
                    }
                    if (!hasDevice && IDDevice != 0)
                        return new List<object>();
                    else
                        return listreturn;
                }
            }
            catch (Exception)
            {
                return new List<object>();
            }
        }


        public static string BuildMailSendRequest(User to, User sender, string RequestBody, string RequestFooter, List<Device> listdevice)
        {
            StringBuilder strbuilder = new StringBuilder();
            strbuilder.Append("<style>");
            strbuilder.Append("table tr td, table tr th { border: 1px solid black; } ");
            strbuilder.Append("th{text-align: center;padding-top: 5px;padding-bottom: 4px;background-color: #A7C942;color: #fff;}");
            strbuilder.Append("tr.alt td {color: #000; background-color: #EAF2D3;}");

            strbuilder.Append("</style>");
            strbuilder.Append(string.Format("Dear {0},<br><br>", to.FullName));
            strbuilder.Append(RequestBody + ": <br><br>");
            strbuilder.Append("<table style='width: 500px; border-collapse: collapse;'><tr>");
            strbuilder.Append("<th>ModelName</td>");
            strbuilder.Append("<th>Type</td>");
            strbuilder.Append("<th>Tag</td>");
            strbuilder.Append("<th>Status</td>");
            strbuilder.Append("<th>Serial</td>");
            strbuilder.Append("<th>IMEI</td></tr>");
            int i = 0;
            foreach (var item2 in listdevice)
            {
                strbuilder.Append("<tr class='" + (i % 2 == 0 ? "alt" : "") + "'>");
                strbuilder.Append("<td>");
                strbuilder.Append(item2.DeviceModel.ModelName);
                strbuilder.Append("</td>");
                strbuilder.Append("<td>");
                strbuilder.Append(item2.DeviceModel.CategoryDevice.Name);
                strbuilder.Append("</td>");
                strbuilder.Append("<td>");
                strbuilder.Append(item2.Tag);
                strbuilder.Append("</td>");
                strbuilder.Append("<td>");
                strbuilder.Append(item2.Status.Name);
                strbuilder.Append("</td>");
                strbuilder.Append("<td>");
                strbuilder.Append(item2.Serial);
                strbuilder.Append("</td>");
                strbuilder.Append("<td>");
                strbuilder.Append(item2.IMEI);
                strbuilder.Append("</td>");
                strbuilder.Append("</tr>");
            }
            strbuilder.Append("</table><br>");
            strbuilder.Append(RequestFooter + "<br><br>");
            strbuilder.Append("Yours sincerely,<br>" + sender.FullName);
            return strbuilder.ToString();

        }

    }
}
