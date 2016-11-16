using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.HRFolder
{
    public class UserCertificationInfo
    {

        public static bool SaveCertification(string username, UserCertification usercertification)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    if (usercertification.UserName == null)
                        usercertification.UserName = username;
                    var user = context.Users.Single(x => x.UserName == username);
                    if (usercertification.UserName != username)
                    {
                        if (!UserInfo.IsAdmin(context,user))
                            return false;
                    }
                    if (usercertification.ID == 0)
                        context.UserCertifications.InsertOnSubmit(usercertification);

                    else
                    {
                        var temp = context.UserCertifications.Single(x => x.ID == usercertification.ID);
                        if (temp.UserName != usercertification.UserName)
                            throw new Exception();
                        temp.DataCertificationID = usercertification.DataCertificationID;
                        temp.LicenseNo = usercertification.LicenseNo;
                        temp.IssuedBy = usercertification.IssuedBy;
                        temp.IssueDate = usercertification.IssueDate;
                        temp.Grade = usercertification.Grade;
                        temp.Expiration = usercertification.Expiration;
                        temp.OtherDataCertification = usercertification.OtherDataCertification;
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

        public static bool DelCertification(string currentusename, string username, int id)
        {
            if (username != currentusename)
            {
                //check admin
            }
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var edu = context.UserCertifications.Single(x => x.ID == id);
                    if (edu.UserName != username)
                        throw new Exception();
                    else
                        context.UserCertifications.DeleteOnSubmit(edu);
                    context.SubmitChanges();
                    return true;
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        public static object GetUserCertification(string username)
        {
            try
            {
                var context = new DatabaseDataContext();
                var data = context.Users.Single(x => x.UserName == username).UserCertifications.Select(x => new
                {
                    x.DataCertificationID,
                    Certification = x.DataCertificationID == 1 ? x.OtherDataCertification : x.DataCertification.Name,
                    x.ID,
                    IssueDate = x.IssueDate.ToString("MM/dd/yyyy"),
                    x.IssuedBy,
                    x.LicenseNo,
                    Expiration = x.Expiration == null ? "" : x.Expiration.Value.ToString("MM/dd/yyyy"),
                    x.Grade,
                    x.OtherDataCertification
                });
                return new { Data = data };
            }
            catch (Exception)
            {
                return new { Data = new List<string>() };
            }
        }
    }
}
