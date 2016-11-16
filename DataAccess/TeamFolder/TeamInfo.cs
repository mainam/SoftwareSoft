using DataAccess.UserFolder;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.TeamFolder
{
    public enum TeamLever
    {
        Group = 1,
        Part = 2,
        Team = 3
    }

    public class Support
    {
        public int team;
        public double supporting;
        public double supported;

        public Support(int team, double supporting, double supported)
        {
            this.team = team;
            this.supporting = supporting;
            this.supported = supported;
        }
    }

    public class DailyArrangeDetail
    {
        public string Name { get; set; }
        public double ID { get; set; }

        double _NumInvProject;
        public double NumInvProject
        {
            get
            {
                return Math.Round(_NumInvProject, 2);
            }
            set
            {
                _NumInvProject = value;
            }
        }
        double _NumEducation;
        public double NumEducation
        {
            get
            {
                return Math.Round(_NumEducation, 2);
            }
            set
            {
                _NumEducation = value;
            }
        }
        double _NumManage;
        public double NumManage
        {
            get
            {
                return Math.Round(_NumManage, 2);
            }
            set
            {
                _NumManage = value;
            }
        }
        double _NumOnLeave;
        public double NumOnLeave
        {
            get
            {
                return Math.Round(_NumOnLeave, 2);
            }
            set
            {
                _NumOnLeave = value;
            }
        }
        double _NumOtherTask;
        public double NumOtherTask
        {
            get
            {
                return Math.Round(_NumOtherTask, 2);
            }
            set
            {
                _NumOtherTask = value;
            }
        }
        public int TotalMembers;
        double _NumInCharge;
        public double NumInCharge
        {
            get
            {
                return Math.Round(_NumInCharge, 2);
            }
            set
            {
                _NumInCharge = value;
            }
        }
        double _NumSupporting;
        public double NumSupporting
        {
            get
            {
                return Math.Round(_NumSupporting, 2);
            }
            set
            {
                _NumSupporting = value;
            }
        }
        double _NumSupported;
        public double NumSupported
        {
            get
            {
                return Math.Round(_NumSupported, 2);
            }
            set
            {
                _NumSupported = value;
            }
        }

        public List<DailyArrangeDetail> Childs;


        public DailyArrangeDetail()
        {
            this.ID = 0;
            this.Name = "";
            this.NumInvProject = 0;
            this.NumEducation = 0;
            this.NumOnLeave = 0;
            this.TotalMembers = 0;
            this.NumInCharge = 0;
            this.Childs = new List<DailyArrangeDetail>();
            this.NumSupporting = 0;
            this.NumSupported = 0;
            this.NumManage = 0;
        }

        public DailyArrangeDetail(int ID, string Name, double NumInvProject, double NumEducation, double NumOnLeave, int TotalMembers, double NumInCharge,
                            double NumSupporting, double NumSupported, double NumManage, double NumOtherTask)
        {
            this.ID = ID;
            this.Name = Name;
            this.NumInvProject = NumInvProject;
            this.NumEducation = NumEducation;
            this.NumOnLeave = NumOnLeave;
            this.TotalMembers = TotalMembers;
            this.NumInCharge = NumInCharge;
            this.Childs = new List<DailyArrangeDetail>();
            this.NumSupporting = NumSupporting;
            this.NumSupported = NumSupported;
            this.NumManage = NumManage;
        }
    }



    public class TeamDetail
    {
        public string name { get; set; }
        double _numberInvolveProject;
        public double numberInvolveProject
        {
            get
            {
                return Math.Round(_numberInvolveProject, 2);
            }
            set
            {
                _numberInvolveProject = value;
            }
        }
        double _numberEducation;
        public double numberEducation
        {
            get
            {
                return Math.Round(_numberEducation, 2);
            }
            set
            {
                _numberEducation = value;
            }
        }
        double _numberOnLeave;
        public double numberOnLeave
        {
            get
            {
                return Math.Round(_numberOnLeave, 2);
            }
            set
            {
                _numberOnLeave = value;
            }
        }
        public double id { get; set; }
        public int totalMembers;
        double _numberInCharge;
        public double numberInCharge
        {
            get
            {
                return Math.Round(_numberInCharge, 2);
            }
            set
            {
                _numberInCharge = value;
            }
        }

        public List<TeamDetail> children;
        public Boolean canEdit;
        double _numberSupporting;
        public double numberSupporting
        {
            get
            {
                return Math.Round(_numberSupporting, 2);
            }
            set
            {
                _numberSupporting = value;
            }
        }
        double _numberSupported;
        public double numberSupported
        {
            get
            {
                return Math.Round(_numberSupported, 2);
            }
            set
            {
                _numberSupported = value;
            }
        }

        double _numberManage;
        public double numberManage
        {
            get
            {
                return Math.Round(_numberManage, 2);
            }
            set
            {
                _numberManage = value;
            }
        }


        public TeamDetail()
        {
            this.id = 0;
            this.name = "";
            this.numberInvolveProject = 0;
            this.numberEducation = 0;
            this.numberOnLeave = 0;
            this.totalMembers = 0;
            this.numberInCharge = 0;
            this.children = new List<TeamDetail>();
            this.numberSupporting = 0;
            this.numberSupported = 0;
            this.numberManage = 0;
        }

        public TeamDetail(int id, string name, double numberInvolveProject, double numberEducation, double numberOnLeave, Boolean canEdit, int totalMembers, double numberInCharge,
                            double numberSupporting, double numberSupported, double numberManage)
        {
            this.id = id;
            this.name = name;
            this.numberInvolveProject = numberInvolveProject;
            this.numberEducation = numberEducation;
            this.numberOnLeave = numberOnLeave;
            this.canEdit = canEdit;
            this.totalMembers = totalMembers;
            this.numberInCharge = numberInCharge;
            this.children = new List<TeamDetail>();
            this.numberSupporting = numberSupporting;
            this.numberSupported = numberSupported;
            this.numberManage = numberManage;
        }
    }

    public class TeamHierarchy
    {
        public string name;
        public List<TeamHierarchy> subTeams;
        public Dictionary<string, string> members;

        public TeamHierarchy()
            : this("", new List<TeamHierarchy>(), new Dictionary<string, string>())
        {

        }

        public TeamHierarchy(string name, List<TeamHierarchy> subTeams, Dictionary<string, string> members)
        {
            this.name = name;
            this.subTeams = subTeams;
            this.members = members;
        }
    }

    public class TeamInfo
    {
        public string id;
        public string name;
        public string value;
        public int selected;
        public int expaned;
        public int show;
        public int isleader;
        public List<TeamInfo> chils;

        /// <summary>
        /// lấy ra danh sách tất cả các team
        /// </summary>
        /// <returns></returns>
        public static List<Team> GetAll(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.Teams.ToList();
            }
            catch (Exception)
            {
                return new List<Team>();
            }
        }

        //public static List<Support> supportList;

        //public TeamInfo()
        //{
        //    supportList = new List<Support>();
        //}

        /// <summary>
        /// ngoc.nam
        /// </summary>
        /// <returns></returns>
        public static string GetJsonAllTeam(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var text = new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(GetTeamChild(context, null));
                return text;
            }
            catch (Exception)
            {
                return "";
            }
        }

        /// <summary>
        /// ngoc.nam
        /// </summary>
        /// <returns></returns>
        public static TeamInfo GetAllTeam(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return GetTeamChild(context, null);
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        /// ngoc.nam
        /// </summary>
        /// <param name="context"></param>
        /// <param name="team"></param>
        /// <returns></returns>
        public static TeamInfo GetTeamChild(DatabaseDataContext context, Team team)
        {
            var result = new TeamInfo();
            if (team != null)
            {
                result = new TeamInfo()
                {
                    id = "team_" + team.TeamID,
                    name = team.TeamName,
                    value = team.TeamID.ToString(),
                    selected = 0,
                    show = 1,
                    expaned = 0,
                    isleader = 0,
                    chils = new List<TeamInfo>()
                };
                var listuser = UserInfo.GetByTeam(team);

                foreach (var x in listuser)
                {
                    result.chils.Add(new TeamInfo()
                    {
                        chils = new List<TeamInfo>(),
                        id = "user_" + x.UserName,
                        name = x.FullName,
                        value = x.UserName,
                        selected = 0,
                        show = 1,
                        isleader = (team.Leader != null && team.Leader == x.UserName) ? 1 : 0,
                        expaned = 0
                    });
                }
            }
            else
            {
                result = new TeamInfo()
                {
                    id = "root",
                    name = "root",
                    value = "root",
                    selected = 0,
                    show = 1,
                    expaned = 0,
                    isleader = 0,
                    chils = new List<TeamInfo>()
                };
            }
            var listchild = context.Teams.ToList().FindAll(x => ((x.TeamParent == null && team == null) || (x.TeamParent != null && team != null && x.TeamParent.Value == team.TeamID)));
            var teamname = "";
            foreach (var item in listchild)
            {
                if (item.TeamName.Trim() != "")
                {
                    if (teamname.Trim() != "")
                        teamname += " - ";
                    teamname += item.TeamName;
                }
                var temp = GetTeamChild(context, item);
                if (temp.name != "")
                    result.chils.Add(temp);
            }
            if (result.name.Trim() == "")
            {
                if (result.chils.Count == 1)
                    return result.chils[0];
                result.name = teamname;
            }
            return result;
        }

        ///// <summary>
        ///// ngoc.nam 04.04.2015
        ///// lây ra 1 team theo id
        ///// </summary>
        ///// <param name="id"></param>
        ///// <returns></returns>
        //public static Team GetByID(DatabaseDataContext, int id)
        //{
        //    try
        //    {
        //        var context = new DatabaseDataContext();
        //        return context.Teams.Single(x => x.TeamID == id);
        //    }
        //    catch (Exception)
        //    {
        //        return null;
        //    }
        //}

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// lây ra 1 team theo id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public static Team GetByID(DatabaseDataContext context, int id)
        {
            try
            {
                //var context = new DatabaseDataContext();
                return context.Teams.Single(x => x.TeamID == id);
            }
            catch (Exception)
            {
                return null;
            }
        }

       



        //public static TeamDetail getDataWorkArrangement(DatabaseDataContext context, Team currentTeam, int level, string username, int? permission, Boolean ascendentEditted, DateTime date, ref Boolean canEdit, ref Boolean support, bool ShowAllProject)
        //{
        //    try
        //    {
        //        //var context = new DatabaseDataContext();
        //        TeamDetail result;
        //        TeamDetail childResult;
        //        Team team;

        //        if (level < 3)
        //        {
        //            if (currentTeam == null)
        //            {
        //                supportList = new List<Support>();
        //                result = new TeamDetail(-1, "root", 0, 0, 0, false, 0, 0, 0, 0, 0);
        //                team = null;
        //            }
        //            else
        //            {
        //                if (!ascendentEditted)
        //                {
        //                    if (permission == 3 || (permission == 2 && username == currentTeam.Leader))
        //                    {
        //                        ascendentEditted = true;
        //                        canEdit = true;
        //                    }
        //                }
        //                result = new TeamDetail(currentTeam.TeamID, currentTeam.TeamName, 0, 0, 0, ascendentEditted, 0, 0, 0, 0, 0);
        //                team = currentTeam;
        //            }

        //            result.totalMembers += team == null ? 0 : team.Users.Where(x => x.Active).Count();
        //            result.numberManage += team == null ? 0 : team.OnLeave_Edus.Where(x => x.Type == 2 && x.DateOnleave.Date == date).Sum(x => x.ManDate);
        //            result.numberInCharge += result.numberManage;

        //            var listchils = new List<Team>();
        //            if (team != null)
        //                listchils = team.Teams.ToList();
        //            foreach (Team child in listchils)
        //            {
        //                childResult = TeamInfo.getDataWorkArrangement(context, child, level + 1, username, permission, ascendentEditted, date, ref canEdit, ref support, ShowAllProject);
        //                result.children.Add(childResult);

        //                result.numberInvolveProject += childResult.numberInvolveProject;
        //                result.numberEducation += childResult.numberEducation;
        //                result.numberOnLeave += childResult.numberOnLeave;
        //                result.totalMembers += childResult.totalMembers;
        //                result.numberInCharge += childResult.numberInCharge;
        //                result.numberManage += childResult.numberManage;
        //            }
        //        }
        //        else
        //        {
        //            if (!ascendentEditted)
        //            {
        //                if (permission == 3 || (permission == 2 && username == currentTeam.Leader))
        //                {
        //                    ascendentEditted = true;
        //                    canEdit = true;
        //                }
        //            }

        //            result = new TeamDetail(currentTeam.TeamID, currentTeam.TeamName, 0, 0, 0, ascendentEditted, 0, 0, 0, 0, 0);
        //            List<User> teamUsers = currentTeam.Users.Where(x => x.Active).ToList();

        //            result.totalMembers += teamUsers.Count;

        //            var totalmandate = teamUsers.SelectMany(x => x.Assigns).Where(x => x.DailyArrange.DateArrange.Date == date).Sum(x => x.ManDate);

        //            result.numberInCharge += totalmandate;

        //            //for (int i = 0; i < teamUsers.Count; i++)
        //            //{
        //            //    var temp = context.Assigns.Where(x => x.AssignedTo == teamUsers[i].UserName
        //            //                                && x.DailyArrange.DateArrange.Date == date);
        //            //    if (temp.Count() > 0)
        //            //    {
        //            //        result.numberInCharge += temp.Sum(x => x.ManDate);
        //            //    }

        //            //}
        //            var listprojects = currentTeam.Project_Teams.Select(pt => pt.Project).Where(p => p.Status.Equals(GlobalProject.ProjectStatus.Ongoing.ToString()));
        //            foreach (Project p in listprojects)
        //            {


        //                childResult = new TeamDetail(p.ProjectId, p.ProjectName, 0, 0, 0, ascendentEditted, 0, 0, 0, 0, 0);
        //                foreach (MainCategory mc in p.MainCategories)
        //                {
        //                    foreach (MainTestItem mti in mc.MainTestItems)
        //                    {
        //                        foreach (SubTestItem sti in mti.SubTestItems)
        //                        {
        //                            foreach (Feature feature in sti.Features)
        //                            {
        //                                foreach (DailyArrange da in feature.DailyArranges)
        //                                {
        //                                    if (da.DateArrange.Date == date)
        //                                    {
        //                                        foreach (Assign assign in da.Assigns)
        //                                        {
        //                                            childResult.numberInvolveProject += assign.ManDate;

        //                                            // Must check
        //                                            int testerTeam = assign.User.TeamID;
        //                                            if (currentTeam.TeamID != testerTeam)
        //                                            {
        //                                                support = true;
        //                                                CheckSupport(context, currentTeam.TeamID, testerTeam, assign.ManDate);
        //                                            }
        //                                        }
        //                                    }
        //                                }
        //                            }
        //                        }
        //                    }
        //                }

        //                if (childResult.numberInvolveProject != 0 || ShowAllProject)
        //                {
        //                    result.numberInvolveProject += childResult.numberInvolveProject;
        //                    result.children.Add(childResult);
        //                }
        //            }

        //            foreach (OnLeave_Edu leaveEdu in currentTeam.OnLeave_Edus)
        //            {
        //                if (((DateTime)leaveEdu.DateOnleave).Date == date)
        //                {
        //                    int type = leaveEdu.Type;
        //                    if (type == 1)
        //                    {
        //                        result.numberOnLeave += leaveEdu.ManDate;
        //                        result.numberInCharge += leaveEdu.ManDate;
        //                    }
        //                    else if (type == 0)
        //                    {
        //                        result.numberEducation += leaveEdu.ManDate;
        //                        result.numberInCharge += leaveEdu.ManDate;
        //                    }
        //                    else if (type == 2)
        //                    {
        //                        result.numberManage += leaveEdu.ManDate;
        //                        result.numberInCharge += leaveEdu.ManDate;
        //                    }
        //                }
        //            }
        //        }

        //        if (currentTeam == null)
        //        {
        //            GetSupport(result, support);
        //        }
        //        return result;
        //    }
        //    catch (Exception)
        //    {
        //        return null;
        //    }
        //}

        /// <summary>
        /// ngoc.nam
        /// </summary>
        /// <param name="root"></param>
        /// <param name="support"></param>
        public static void GetSupport(DailyArrangeDetail root, Boolean support, List<Support> supportList)
        {
            if (support)
            {
                foreach (Support s in supportList)
                {
                    DailyArrangeDetail temp = findTeamDetail(root, s.team);
                    temp.NumSupported += s.supported;
                    temp.NumSupporting += s.supporting;
                }
            }
        }

        //public static void GetSupport(TeamDetail root, Boolean support)
        //{
        //    if (support)
        //    {
        //        foreach (Support s in supportList)
        //        {
        //            TeamDetail temp = findTeamDetail(root, s.team);
        //            temp.numberSupported += s.supported;
        //            temp.numberSupporting += s.supporting;
        //        }
        //    }
        //}

        //public static TeamDetail findTeamDetail(TeamDetail u, int id)
        //{
        //    if (u.id == id)
        //    {
        //        return u;
        //    }

        //    foreach (TeamDetail v in u.children)
        //    {
        //        TeamDetail temp = findTeamDetail(v, id);
        //        if (temp != null)
        //        {
        //            return temp;
        //        }
        //    }
        //    return null;
        //}
        /// <summary>
        /// ngoc.nam
        /// </summary>
        /// <param name="u"></param>
        /// <param name="id"></param>
        /// <returns></returns>
        public static DailyArrangeDetail findTeamDetail(DailyArrangeDetail u, int id)
        {
            if (u.ID == id)
            {
                return u;
            }

            foreach (var v in u.Childs)
            {
                DailyArrangeDetail temp = findTeamDetail(v, id);
                if (temp != null)
                {
                    return temp;
                }
            }
            return null;
        }

        public static void CheckSupport(DatabaseDataContext context, int supportedTeam, int supportingTeam, double mandate, List<Support> supportList)
        {
            try
            {
                if (supportedTeam == supportingTeam)
                {
                    return;
                }

                if (supportList == null)
                {
                    supportList = new List<Support>();
                }

                int? lowestCommonParent = findLowestCommonParentTeam(context, supportingTeam, supportedTeam);

                List<int> parentsSupporting = new List<int>();
                parentTeamsTo(context, lowestCommonParent, supportingTeam, ref parentsSupporting);
                foreach (int support in parentsSupporting)
                {
                    supportList.Add(new Support(support, mandate, 0));
                }

                List<int> parentsSupported = new List<int>();
                parentTeamsTo(context, lowestCommonParent, supportedTeam, ref parentsSupported);
                foreach (int supported in parentsSupported)
                {
                    supportList.Add(new Support(supported, 0, mandate));
                }

                //supportList.Add(new Support(supportedTeam, 0, mandate));
                //supportList.Add(new Support(supportingTeam, mandate, 0));

                //var supported = context.Teams.Single(x => x.TeamID == supportedTeam);
                //var supporting = context.Teams.Single(x => x.TeamID == supportingTeam);

                //checkSupport(context, supported.TeamParent ?? -1,
                //                supporting.TeamParent ?? -1, mandate);
            }
            catch
            {
                return;
            }
        }

        public static int? findLowestCommonParentTeam(DatabaseDataContext context, int supportingTeam, int supportedTeam)
        {
            try
            {
                // var context = new DatabaseDataContext();
                List<int> parentsOfTeam1 = new List<int>();
                parentTeamsTo(context, null, supportingTeam, ref parentsOfTeam1);

                int? lowestCommonParent = findParentInList(context, supportedTeam, parentsOfTeam1);

                return lowestCommonParent;
            }
            catch
            {
                return null;
            }
        }

        //public static void parentTeams(DatabaseDataContext context, int? team, ref List<int> result)
        //{
        //    if (team == null)
        //    {
        //        return;
        //    }
        //    else
        //    {
        //        result.Add(team?? -1);
        //    }
        //    parentTeams(context, context.Teams.Single(t => t.TeamID == team).TeamParent, ref result);
        //}

        public static void parentTeamsTo(DatabaseDataContext context, int? target, int? team, ref List<int> result)
        {
            if (team == target)
            {
                return;
            }
            else
            {
                result.Add(team ?? -1);
            }
            parentTeamsTo(context, target, context.Teams.Single(t => t.TeamID == team).TeamParent, ref result);
        }

        public static int? findParentInList(DatabaseDataContext context, int? team, List<int> otherTeamParents)
        {
            if (team == null)
            {
                return null;
            }
            else
            {
                if (otherTeamParents.Contains(team ?? -1))
                {
                    return team;
                }
                return findParentInList(context, context.Teams.Single(t => t.TeamID == team).TeamParent, otherTeamParents);
            }
        }

        public static int getLevelOfTeamId(DatabaseDataContext context, int? currentId, int? idToMatch, int level)
        {
            if (currentId == idToMatch)
            {
                return level;
            }
            foreach (Team child in context.Teams.ToList().FindAll(x => x.TeamParent.Equals(currentId)))
            {
                int ret = getLevelOfTeamId(context, child.TeamID, idToMatch, level + 1);
                if (ret > 0)
                {
                    return ret;
                }
            }
            return 0;

        }

        public static bool AddTeam(DatabaseDataContext context, int? parentId, TeamDetail teamDetail)
        {
            try
            {
                //var context = new DatabaseDataContext();
                int level = getLevelOfTeamId(context, null, parentId, 0);

                if (level < 4)
                {
                    Team team = new Team();
                    team.TeamName = teamDetail.name;
                    team.TeamParent = parentId;

                    context.Teams.InsertOnSubmit(team);
                    context.SubmitChanges();
                    return true;
                }

                context.SubmitChanges();
                return false;
            }
            catch (Exception)
            {
                return false;
            }
        }
     
        public static void editTeamTree(DatabaseDataContext context, TeamDetail u, int level)
        {
            if (level == 0)
            {
                //do nothing
            }
            else if (level < 4)
            {
                Team team = context.Teams.Single(x => x.TeamID == u.id);
                team.TeamName = u.name;
            }
            else
            {
                //Nothing
            }

            if (level < 5)
            {
                foreach (TeamDetail child in u.children)
                {
                    editTeamTree(context, child, level + 1);
                }
            }
        }

        public static Boolean edit(DatabaseDataContext context, TeamDetail teamDetail)
        {
            try
            {
                //var context = new DatabaseDataContext();
                editTeamTree(context, teamDetail, 0);
                context.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }
        }


        /// <summary>
        /// ngt.hieu 04.04.2015
        /// lấy ra tất cả các team trả về dictionary
        /// </summary>
        /// <returns></returns>
        public static Dictionary<string, string> getAllTeamsDictionary(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var result = context.Teams.ToDictionary(t => t.TeamID.ToString(), t => t.TeamName);
                return result;
            }
            catch
            {
                return null;
            }
        }


        /// <summary>
        /// ngt.hieu 04.04.2015
        /// lấy ra tât cả các team level3
        /// </summary>
        /// <returns></returns>
        public static List<Team> getAllLv3Teams(DatabaseDataContext context)
        {
            try
            {
                //ar context = new DatabaseDataContext();
                var result = context.Teams.SelectMany(t => t.Teams).SelectMany(t => t.Teams).Where(x => x.TeamName.Trim() != "").ToList();
                return result;
            }
            catch
            {
                return null;
            }
        }

        /// <summary>
        /// ngt.hieu 04.04.2015
        /// lấy ra tât cả các team level3
        /// </summary>
        /// <returns></returns>
        public static Dictionary<string, string> getAllLv3TeamsDictionary(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var result = context.Teams.SelectMany(t => t.Teams).SelectMany(t => t.Teams).
                                ToDictionary(t => t.TeamID.ToString(), t => t.TeamName);
                return result;
            }
            catch
            {
                return null;
            }
        }

        

        #region hieu---- dang làm dở
        public static TeamHierarchy buildTeamHierarchy(DatabaseDataContext context, Team currentTeam)
        {
            TeamHierarchy result = new TeamHierarchy();

            if (currentTeam == null)
            {
                result.name = "root";
                result.members = new Dictionary<string, string>();
                var temp1 = context.Teams.Where(t => t.Team1 == null);
                var temp2 = temp1.Select(t => buildTeamHierarchy(context, t)).ToList();
                result.subTeams = temp2;
            }
            else
            {
                result.name = currentTeam.TeamName;
                result.members = currentTeam.Users.ToDictionary(u => u.UserName, u => u.FullName);
                var temp1 = context.Teams.Where(t => t.Team1.Equals(currentTeam));
                var temp2 = temp1.Select(t => buildTeamHierarchy(context, t)).ToList();
                result.subTeams = temp2;
            }


            return result;
        }

        public static TeamHierarchy getTeamHierarchy(DatabaseDataContext context)
        {
            try
            {
                //var context = new DatabaseDataContext();
                TeamHierarchy result = buildTeamHierarchy(context, null);
                return result;
            }
            catch
            {
                return null;
            }
        }
        #endregion


        /// <summary>
        /// ngoc.nam 21/03/2015
        /// get Part
        /// </summary>
        /// <param name="team"></param>
        /// <returns></returns>
        public static Team GetTeamType(Team team, TeamLever teamlevel)
        {
            try
            {
                if (team.LevelTeam == (int)teamlevel)
                    return team;
                if (team.TeamParent == null)
                    return null;
                return GetTeamType(team.Team1, teamlevel);
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        /// ngoc.nam 24/04/2015
        /// get Part, Group
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>
        public static List<Team> GetAllTeamType(DatabaseDataContext context, TeamLever teamlevel)
        {
            try
            {
                // var context = new DatabaseDataContext();
                return context.Teams.Where(x => x.LevelTeam != null && x.LevelTeam == (int)teamlevel).ToList();
            }
            catch (Exception)
            {
                return new List<Team>();
            }
        }

        /// <summary>
        /// ngoc.nam 24/04/2015
        /// get Part, Group
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>
        public static List<Team> GetAllTeamType(TeamLever teamlevel, DatabaseDataContext context)
        {
            try
            {
                return context.Teams.Where(x => x.LevelTeam != null && x.LevelTeam == (int)teamlevel).ToList();
            }
            catch (Exception)
            {
                return new List<Team>();
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// get Part
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>
        public static Team GetTeamType(DatabaseDataContext context, int teamid, TeamLever teamlevel)
        {
            try
            {
                //var context = new DatabaseDataContext();
                var team = context.Teams.Single(x => x.TeamID == teamid);
                return GetTeamType(team, teamlevel);
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// get Part
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>
        public static Team GetTeamType(User user, TeamLever teamlevel)
        {
            try
            {
                var part1 = GetTeamType(user.Team, teamlevel);
                if (part1 == null)
                {
                    foreach (var item in user.Teams)
                    {
                        var temp = GetTeamType(item, teamlevel);
                        if (temp != null)
                            return temp;
                    }
                }
                return part1;
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        /// ngoc.nam 21/03/2015
        /// get Part
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>
        public static Team GetTeamType(DatabaseDataContext context, string username, TeamLever teamlevel)
        {
            try
            {
                //  var context = new DatabaseDataContext();
                var user = context.Users.Single(x => x.UserName == username);
                return GetTeamType(user, teamlevel);
            }
            catch (Exception)
            {
                return null;
            }
        }

        /// <summary>
        /// ngoc.nam 03042015
        /// </summary>
        /// <param name="listTeam"></param>
        /// <param name="team"></param>
        /// <returns></returns>

        public static bool InTree(List<Team> listTeam, int team)
        {
            try
            {
                return listTeam.SingleOrDefault(x => x.TeamID == team) != null;
            }
            catch (Exception)
            {
                return false;
            }
        }


        /// <summary>
        /// ngoc.nam 04.04.2015
        /// kiểm tra 1 user có thuộc 1 team
        /// </summary>
        /// <param name="user"></param>
        /// <param name="team"></param>
        /// <returns></returns>
        public static bool InTree(DatabaseDataContext context, string username, int teamid)
        {
            try
            {
                //  using (var context = new DatabaseDataContext())
                {
                    var team = context.Teams.SingleOrDefault(x => x.TeamID == teamid);
                    return InTree(username, team);
                }
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// kiểm tra 1 user có thuộc 1 team
        /// </summary>
        /// <param name="user"></param>
        /// <param name="team"></param>
        /// <returns></returns>
        public static bool InTree(DatabaseDataContext context, User user, int teamid)
        {
            try
            {
                // using (var context = new DatabaseDataContext())
                {
                    var team = context.Teams.SingleOrDefault(x => x.TeamID == teamid);
                    return InTree(user, team);
                }
            }
            catch (Exception)
            {
                return false;
            }
        }
        /// <summary>
        /// ngoc.nam 04.04.2015
        /// kiểm tra 1 user có thuộc 1 team
        /// </summary>
        /// <param name="user"></param>
        /// <param name="team"></param>
        /// <returns></returns>
        public static bool InTree(User user, Team team)
        {
            try
            {
                return GetTeamInTree(team).SelectMany(x => x.Users).SingleOrDefault(x => x.UserName == user.UserName) != null;
            }
            catch (Exception)
            {
                return false;
            }
        }
        /// <summary>
        /// ngoc.nam 04.04.2015
        /// kiểm tra 1 user có thuộc 1 team
        /// </summary>
        /// <param name="user"></param>
        /// <param name="team"></param>
        /// <returns></returns>
        public static bool InTree(string username, Team team)
        {
            try
            {
                return GetTeamInTree(team).SelectMany(x => x.Users).SingleOrDefault(x => x.UserName == username) != null;
            }
            catch (Exception)
            {
                return false;
            }
        }

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// lấy ra các team con
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>
        public static List<Team> GetTeamByParent(Team teamparent)
        {
            try
            {
                return teamparent.Teams.ToList();
            }
            catch (Exception)
            {
                return new List<Team>();
            }
        }

        /// <summary>
        /// ngoc.nam 04.04.2015
        /// lấy ra các team con
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>
        public static List<Team> GetTeamByParent(DatabaseDataContext context, int teamid)
        {
            try
            {
                //DatabaseDataContext context = new DatabaseDataContext();
                var team = context.Teams.Single(x => x.TeamID == teamid);
                return GetTeamByParent(team);
            }
            catch (Exception)
            {
                return new List<Team>();
            }
        }

        /// <summary>
        /// ngoc.nam 040415
        /// lấy các team con trong 1 team cho trước
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>

        //public static List<int> GetTeamInTree(Team team)
        //{
        //    try
        //    {
        //        var listteam = new List<int>();
        //        Stack<Team> steam = new Stack<Team>();
        //        steam.Push(team);
        //        while (steam.Count != 0)
        //        {
        //            var id = steam.Pop();
        //            if (!listteam.Contains(id.TeamID))
        //            {
        //                listteam.Add(id.TeamID);
        //                var lc = id.Teams.ToList();
        //                lc.ForEach(x => steam.Push(x));
        //            }
        //        }
        //        return listteam;
        //    }
        //    catch (Exception)
        //    {
        //        return new List<int>();
        //    }
        //}

        //public static List<Team> GetTeamInTree(Team team)
        //{
        //    try
        //    {
        //        var listteam = new List<Team>();
        //        Stack<Team> steam = new Stack<Team>();
        //        steam.Push(team);
        //        while (steam.Count != 0)
        //        {
        //            var id = steam.Pop();
        //            if (!listteam.Contains(id))
        //            {
        //                listteam.Add(id);
        //                var lc = id.Teams.ToList();
        //                lc.ForEach(x => steam.Push(x));
        //            }
        //        }
        //        return listteam;
        //    }
        //    catch (Exception)
        //    {
        //        return new List<Team>();
        //    }
        //}

        /// <summary>
        /// ngoc.nam 040415
        /// lấy các team con trong 1 team cho trước
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>
        public static List<Team> GetTeamInTree(Team team)
        {
            try
            {
                var listteam = new List<Team>();
                Stack<Team> steam = new Stack<Team>();
                steam.Push(team);
                while (steam.Count != 0)
                {
                    var id = steam.Pop();
                    if (!listteam.Contains(id))
                    {
                        listteam.Add(id);
                        var lc = id.Teams.ToList();
                        lc.ForEach(x => steam.Push(x));
                    }
                }
                return listteam;
            }
            catch (Exception)
            {
                return new List<Team>();
            }
        }



        /// <summary>
        /// ngoc.nam 040415
        /// lấy các team con trong 1 team cho trước
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>
        public static List<Team> GetTeamInTree(DatabaseDataContext context, int teamid)
        {
            try
            {
                var team = TeamInfo.GetByID(context, teamid);
                return GetTeamInTree(team);
            }
            catch (Exception)
            {
                return new List<Team>();
            }
        }



        /// <summary>
        /// ngoc.nam 040415
        /// lấy các user trong cay team
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>
        public static List<User> GetAllUserInTreeTeam(DatabaseDataContext context, int teamid)
        {
            try
            {
                var team = TeamInfo.GetByID(context, teamid);
                return GetTeamInTree(team).SelectMany(x => x.Users).Distinct().ToList();
            }
            catch (Exception)
            {
                return new List<User>();
            }
        }


        /// <summary>
        /// ngoc.nam 040415
        /// lấy các user trong cay team
        /// </summary>
        /// <param name="teamid"></param>
        /// <returns></returns>
        public static List<User> GetAllUserInTreeTeam(Team team)
        {
            try
            {
                return GetTeamInTree(team).SelectMany(x => x.Users).Distinct().ToList();
            }
            catch (Exception)
            {
                return new List<User>();
            }
        }

        /// <summary>
        /// ngoc.nam 04042015
        /// get level của 1 team
        /// </summary>
        /// <param name="team"></param>
        /// <returns></returns>
        public static int GetLevel(Team team)
        {
            try
            {
                var teamtemp = team;
                int level = 0;
                while (teamtemp != null)
                {
                    level++;
                    teamtemp = teamtemp.Team1;
                }
                return level;
            }
            catch (Exception)
            {
                return 1;
            }
        }

        //////////////////////////////
        public static List<Team> GetAllTeamByLevel(DatabaseDataContext context, Team teamparent, int currentlevel, int maxlevel)
        {
            try
            {
                var listresult = new List<Team>();
                if (currentlevel > maxlevel)
                    return new List<Team>();
                List<Team> listchild = null;
                if (teamparent == null)
                {
                    //var context = new DatabaseDataContext();
                    listchild = context.Teams.Where(x => x.TeamParent == null).ToList();
                    if (maxlevel == 0)
                        return listchild.ToList();
                }

                else
                    listchild = teamparent.Teams.ToList();

                if (currentlevel == maxlevel)
                    return listchild;

                foreach (var item in listchild)
                    listresult.AddRange(GetAllTeamByLevel(context, item, currentlevel + 1, maxlevel));

                return listresult;
            }
            catch (Exception)
            {
                return new List<Team>();
            }
        }

        }
}
