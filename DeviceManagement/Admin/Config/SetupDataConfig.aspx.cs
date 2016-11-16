using DataAccess;
using DataAccess.DataConfigFolder;
using DataAccess.Helper;
using DataAccess.UserFolder;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.Admin.Config
{
    public partial class SetupDataConfig : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var list = Enum.GetNames(typeof(DataConfigEnum)).ToList();
            list.Insert(0, "==ALL==");
            cbListTypeEnumSearch.DataSource = list;
            cbListTypeEnumSearch.DataBind();
        }

        [WebMethod]
        public static String LoadData(string keyword, string datakey, int numberinpage, int currentpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    string data = "";
                    var list = DataConfigInfo.GetAll(context).OrderBy(x => x.DataKey).ThenBy(x => x.ID).ToList();
                    if (String.IsNullOrWhiteSpace(datakey))
                        datakey = "";
                    datakey = datakey.Trim();
                    datakey = datakey.ToLower();
                    if (datakey != "" && datakey != "==all==")
                    {

                        list = list.FindAll(x => x.DataKey.Trim().ToLower() == datakey);
                    }

                    if (String.IsNullOrWhiteSpace(keyword))
                    {
                        data = Converts.Serialize(new
                        {
                            Status = true,
                            Data = list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList().Select(x => new
                            {
                                ApplyDate = x.ApplyDate.ToString("dd/MM/yyyy"),
                                x.DataKey,
                                x.DataValue,
                                x.ID

                            }),
                            TotalItem = list.Count()
                        });
                    }
                    else
                    {
                        if (datakey != "" && datakey != "==all==")
                        {
                            list = list.FindAll(x => x.DataValue.ToLower().Trim().Contains(keyword));
                        }
                        else
                        {
                            list = list.FindAll(x => x.DataValue.ToLower().Trim().Contains(keyword) || x.DataKey.Trim().ToLower().Contains(keyword));
                        }
                        data = Converts.Serialize(new
                        {
                            Status = true,
                            Data = list.Skip((currentpage - 1) * numberinpage).Take(numberinpage).ToList().Select(x => new
                            {
                                ApplyDate = x.ApplyDate.ToString("dd/MM/yyyy"),
                                x.DataKey,
                                x.DataValue,
                                x.ID
                            }),
                            TotalItem = list.Count()
                        });
                    }
                    return data;
                }
            }
            catch (Exception e)
            {
                return Converts.Serialize(new { Status = false });
            }

        }

        public static void DataConfigChange(DataConfig config)
        {
            var dataconfigenum = Converts.ToEnum<DataConfigEnum>(config.DataKey);
            switch (dataconfigenum)
            {
                case DataConfigEnum.MailSystem:
                    SendMail.MailSystem = null;
                    break;
                case DataConfigEnum.subjectemail:
                    break;
                case DataConfigEnum.localhost:
                    break;
                case DataConfigEnum.AllowTeamLeaderBorrowDevice:
                    break;
                case DataConfigEnum.AllowTransferAllMember:
                    break;
                case DataConfigEnum.MailService:
                    SendMail.MailService = null;
                    break;
                default:
                    break;
            }
        }

        [WebMethod]
        public static String Delete(int id)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var _user = HttpContext.Current.User.Identity.Name;
                    var user = context.Users.SingleOrDefault(x => x.UserName == _user);
                    if (user == null || !UserInfo.IsAdmin(context, user))
                        throw new Exception();

                    var config = context.DataConfigs.SingleOrDefault(x => x.ID == id);
                    if (config != null)
                    {
                        context.DataConfigs.DeleteOnSubmit(config);
                        context.SubmitChanges();
                        DataConfigChange(config);
                        return Converts.Serialize(new { Status = true });

                    }

                    return Converts.Serialize(new { Status = false });
                }
            }
            catch (Exception)
            {
                return Converts.Serialize(new { Status = false });
            }
        }

        [WebMethod]
        public static String DeleteMultipleID(List<int> ListID)
        {
            try
            {
                if (ListID == null || ListID.Count == 0)
                    throw new Exception();
                using (var context = new DatabaseDataContext())
                {
                    var _user = HttpContext.Current.User.Identity.Name;
                    var user = context.Users.SingleOrDefault(x => x.UserName == _user);
                    if (user == null || !UserInfo.IsAdmin(context, user))
                        throw new Exception();
                    var list = context.DataConfigs.Where(x => ListID.Contains(x.ID));
                    if (list.Count() != ListID.Count)
                        return Converts.Serialize(new { Status = false });

                    context.DataConfigs.DeleteAllOnSubmit(list);
                    context.SubmitChanges();

                    foreach (var item in list)
                    {
                        DataConfigChange(item);
                    }
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