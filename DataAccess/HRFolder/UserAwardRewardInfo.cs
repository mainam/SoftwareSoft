using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.HRFolder
{
    public class UserAwardRewardInfo
    {
        public static bool SaveAwardReward(string username, AwardReward userawardreward)
        {
            try
            {

                using (var context = new DatabaseDataContext())
                {
                    if (userawardreward.UserName == null)
                        userawardreward.UserName = username;
                    var user = context.Users.Single(x => x.UserName == username);
                    if (userawardreward.UserName != username)
                    {
                        if (!UserInfo.IsAdmin(context,user))
                            return false;
                    }
                    if (userawardreward.ID == 0)
                        context.AwardRewards.InsertOnSubmit(userawardreward);

                    else
                    {
                        var award = context.AwardRewards.Single(x => x.ID == userawardreward.ID);
                        award.Name = userawardreward.Name;
                        award.IssueDate = userawardreward.IssueDate;
                        award.AwardBy = userawardreward.AwardBy;
                        award.Content = userawardreward.Content;
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
        public static object GetUserAward(string username)
        {
            try
            {
                var context = new DatabaseDataContext();
                var data = context.Users.Single(x => x.UserName == username).AwardRewards.Where(x => x.Type == 1).Select(x => new
                {
                    x.ID,
                    x.Name,
                    x.Content,
                    IssueDate = x.IssueDate.ToString("MM/dd/yyyy"),
                    x.UserName,
                    x.Type,
                    x.AwardBy
                });
                return new { Data = data };
            }
            catch (Exception)
            {
                return new { Data = new List<string>() };
            }
        }

        public static object GetUserReward(string username)
        {
            try
            {
                var context = new DatabaseDataContext();
                var data = context.Users.Single(x => x.UserName == username).AwardRewards.Where(x => x.Type == 2).Select(x => new
                {
                    x.ID,
                    x.Name,
                    x.Content,
                    IssueDate = x.IssueDate.ToString("MM/dd/yyyy"),
                    x.UserName,
                    x.Type,
                    x.AwardBy
                });
                return new { Data = data };
            }
            catch (Exception)
            {
                return new { Data = new List<string>() };
            }
        }

        public static bool DelAwardReward(string currentusename, string username, int id)
        {
            if (username != currentusename)
            {
                //check admin
            }
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var edu = context.AwardRewards.Single(x => x.ID == id);
                    if (edu.UserName != username)
                        throw new Exception();
                    else
                        context.AwardRewards.DeleteOnSubmit(edu);
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
