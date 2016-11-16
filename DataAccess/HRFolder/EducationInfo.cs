using DataAccess.UserFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.HRFolder
{
    public class EducationInfo
    {
        //public static List<>
        public static bool SaveEducation(string username, UserEducation usereducation)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    if (usereducation.UserName == null)
                        usereducation.UserName = username;
                    var user = context.Users.Single(x => x.UserName == username);
                    if (usereducation.UserName != username)
                    {
                        if (!UserInfo.IsAdmin(context,user))
                            return false;
                    }
                    if (usereducation.ID == 0)
                        context.UserEducations.InsertOnSubmit(usereducation);
                    else
                    {
                        var temp = context.UserEducations.Single(x => x.ID == usereducation.ID);
                        if (temp.UserName != usereducation.UserName)
                            throw new Exception();
                        temp.MajorID = usereducation.MajorID;
                        temp.OtherMajor = usereducation.OtherMajor;
                        temp.Enteredat = usereducation.Enteredat;
                        temp.Graduated = usereducation.Graduated;
                        temp.OtherUniversity = usereducation.OtherUniversity;
                        temp.UniversityID = usereducation.UniversityID;
                        temp.EducationLevel = usereducation.EducationLevel;
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

        public static object GetUserEducation(string username)
        {
            try
            {
                var context = new DatabaseDataContext();
                var data = context.Users.Single(x => x.UserName == username).UserEducations.Select(x => new
                {
                    x.ID,
                    x.EducationLevel,
                    Education = x.EducationLevel1.Level,
                    Enteredat = x.Enteredat.ToString("MM/dd/yyyy"),
                    Graduated = x.Graduated.ToString("MM/dd/yyyy"),
                    x.OtherUniversity,
                    x.UniversityID,
                    University = x.UniversityID != 1 ? x.University.Name : x.OtherUniversity,
                    x.OtherMajor,
                    x.MajorID,
                    Major = x.MajorID != 1 ? x.Major.Name : x.OtherMajor
                });
                return new { Data = data };
            }
            catch (Exception)
            {
                return new { Data = new List<string>() };
            }
        }

        public static bool DelEducation(string currentusename, string username, int id)
        {
            if (username != currentusename)
            {
                //check admin
            }
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var edu = context.UserEducations.Single(x => x.ID == id);
                    if (edu.UserName != username)
                        throw new Exception();
                    else
                        context.UserEducations.DeleteOnSubmit(edu);
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
