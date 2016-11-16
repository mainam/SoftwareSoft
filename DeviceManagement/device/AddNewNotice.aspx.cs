using DataAccess;
using DataAccess.DeviceFolder;
using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.device
{
    public partial class AddNewNotice : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
            }
        }

        [WebMethod]
        public static string SaveNotice(int IDNotice, string Title, string Content, bool Active)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (DeviceNoticeInfo.SaveNotice(context,IDNotice, Title, Content, username, Active))
                        return new JavaScriptSerializer().Serialize(new { Status = true });
                    return new JavaScriptSerializer().Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }



        public string GetAllUsers()
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    List<User> listAllUsers = UserInfo.GetAll(context);
                    List<string> list = new List<string>();
                    foreach (User user in listAllUsers)
                    {
                        list.Add(user.UserName + "/" + user.FullName);
                    }
                    var jsonSerialiser = new JavaScriptSerializer();
                    string text = jsonSerialiser.Serialize(list);
                    return text;
                }
            }
            catch (Exception)
            {
                return "";
            }
        }

        public string LoadTypeDevice()
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var listtype = CategoryDeviceInfo.GetAll(context);
                    var jsonSerialiser = new JavaScriptSerializer();
                    return jsonSerialiser.Serialize(listtype.Select(x => new { ID = x.ID, Name = x.Name }));
                }
            }
            catch (Exception)
            {
                return "[]";
            }
        }


        [WebMethod]
        public static string editDevice(DataDevice deviceInfo)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    if (deviceInfo.IDDevice != 0)
                    {
                        var devicedata = DeviceInfo.GetByID(context, deviceInfo.IDDevice);
                        if (devicedata != null && devicedata.Manager == username && deviceInfo.Manager == devicedata.Manager && DeviceInfo.UpdateDevice(context, deviceInfo))
                            return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { status = true });
                        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { status = false });
                    }
                    else
                    {
                        var Serials = deviceInfo.Serial.Split('|');
                        var Imei = deviceInfo.IMEI.Split('|');
                        var Tags = deviceInfo.Tag.Split('|');
                        if (Tags.Count() != Imei.Count())
                            throw new Exception();
                        if (Tags.Count() != Serials.Count())
                            throw new Exception();
                        var listdevice = new List<Device>();
                        for (int i = 0; i < Tags.Length; i++)
                        {
                            if (Tags[i].Trim() == "")
                                continue;
                            listdevice.Add(new Device()
                            {
                                Model = deviceInfo.Model,
                                Tag = Tags[i],
                                Project = deviceInfo.Project,
                                Manager = deviceInfo.Manager,
                                Keeper = deviceInfo.Keeper,
                                BorrowDate = Convert.ToDateTime(deviceInfo.BorrowDate),
                                ReturnDate = Convert.ToDateTime(deviceInfo.ReturnDate),
                                StatusDevice = ApproveInfo.getStatusDevice(context, deviceInfo.Status),
                                IMEI = Imei[i],
                                Serial = Serials[i],
                                Region = deviceInfo.Region,
                                Version = deviceInfo.Version,
                                Receiver = deviceInfo.Receiver,
                                From_ = deviceInfo.From,
                                ReceiveDate = Convert.ToDateTime(deviceInfo.ReceiveDate),
                                Borrower = deviceInfo.Borrower,
                                Note = deviceInfo.Note
                            });
                        }
                        if (DeviceInfo.AddDevice(context, listdevice))
                            return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { status = true });
                        return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { status = false });
                    }
                }
            }
            catch (Exception)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { status = false });
            }

        }
    }
}