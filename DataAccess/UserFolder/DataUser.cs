using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.UserFolder
{
    public class DataUser
    {
        public string FullName { get; set; }
        public string SingleID { get; set; }
        public string Gender { get; set; }
        public string GEN { get; set; }
        public string DateOfBirth { get; set; }
        public string PhoneNo { get; set; }
        public int Team { set; get; }
        public string DateJoin { get; set; }
        public int Title { get; set; }
        public int Permission { get; set; }
        public bool Active { get; set; }
        public DataUser() { }
        public DataUser(string fullName, string singleID, string gender, string GEN, string dateOfBirth, string phoneNo, int team, string dateJoin, int title, int permission, bool active)
        {
            this.FullName = fullName;
            this.SingleID = singleID;
            this.Gender = gender;
            this.GEN = GEN;
            this.DateOfBirth = dateOfBirth;
            this.PhoneNo = phoneNo;
            this.Team = team;
            this.DateJoin = dateJoin;
            this.Title = title;
            this.Permission = permission;
            this.Active = active;
        }

        public static bool addUser(DataUser userClass)
        {
            try
            {
                var context = new DatabaseDataContext();
                var user = new User()
                {
                    UserName = userClass.SingleID,
                    Password = Utils.Encryption("abc13579"),
                    TeamID = userClass.Team,
                    JobDescription = "",
                    JobTitleID = userClass.Title,
                    Email = userClass.SingleID + "@samsung.com",
                    PhoneNumber = userClass.PhoneNo,
                    FullName = userClass.FullName,
                    Avatar = userClass.Gender.ToLower() == "male" ? @"~/Images/SEL_Images/Male.png" : @"~/Images/SEL_Images/Female.png",
                    Active = userClass.Active,
                    PermissionId = userClass.Permission,
                    GEN = userClass.GEN,
                    Birthday = Convert.ToDateTime(userClass.DateOfBirth),
                    Gender = userClass.Gender,
                    DateJoiningSEL = Convert.ToDateTime(userClass.DateJoin),
                    ToeicScore = 0,
                    STCLevel = 5,
                    Address = ""
                };
                context.Users.InsertOnSubmit(user);
                context.SubmitChanges();
                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}
