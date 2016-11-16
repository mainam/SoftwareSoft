using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.HRFolder
{
    public class UserLanguageInfo
    {
        public static bool SaveLanguage(string username, UserLanguage userlanguage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    if (userlanguage.UserName == null)
                        userlanguage.UserName = username;
                    var user = context.Users.Single(x => x.UserName == username);
                    if (userlanguage.UserName != username)
                    {
                        if (!UserInfo.IsAdmin(context,user))
                            return false;
                    }
                    if (userlanguage.ID == 0)
                        context.UserLanguages.InsertOnSubmit(userlanguage);
                    else
                    {
                        var temp = context.UserLanguages.Single(x => x.ID == userlanguage.ID);
                        if (temp.UserName != userlanguage.UserName)
                            throw new Exception();
                        temp.Languageid = userlanguage.Languageid;
                        temp.OtherLanguage = userlanguage.OtherLanguage;
                        temp.Native = userlanguage.Native;
                        temp.ScoreOverall = userlanguage.ScoreOverall;
                        temp.ScoreRead = userlanguage.ScoreRead;
                        temp.ScoreSpeak = userlanguage.ScoreSpeak;
                        temp.ScoreWrite = userlanguage.ScoreWrite;
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


        public static object GetUserLanguage(string username)
        {
            try
            {
                var context = new DatabaseDataContext();
                var data = context.Users.Single(x => x.UserName == username).UserLanguages.Select(x => new
                {
                    x.Languageid,
                    Language = x.Languageid == 1 ? x.OtherLanguage : x.DataLanguage.Name,
                    x.ID,
                    x.Native,
                    x.OtherLanguage,
                    x.ScoreWrite,
                    x.ScoreSpeak,
                    x.ScoreRead,
                    x.ScoreOverall
                });
                return new { Data = data };
            }
            catch (Exception)
            {
                return new { Data = new List<string>() };
            }
        }
        public static bool DelLanguage(string currentusename, string username, int id)
        {
            if (username != currentusename)
            {
                //check admin
            }
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var edu = context.UserLanguages.Single(x => x.ID == id);
                    if (edu.UserName != username)
                        throw new Exception();
                    else
                        context.UserLanguages.DeleteOnSubmit(edu);
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
