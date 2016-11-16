using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccess.Helper
{
    public class SSO
    {
        public static Dictionary<string, string> GetSSOInfo(string EncryptionData)
        {
            try
            {
                var st = EncryptionData.Split(';');
                var strNewDataList = st[0];
                var strMD5SecureKey = st[1];
                var strKeyFolder = st[2];
                EPTRAYUTILLib.Util a = new EPTRAYUTILLib.Util();
                var key = "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCfLkZ0LtMe+lY9yIaPMn2U/p+D4dlx4boLoUTg4qvK56am67vPwgSYTFUCFhaBDk1NHCVt0MCE515Qzcese+porpyDw9shjW6KQ1gFSJNwYFTFym44hUPx4VkLJ/eHNXVz5Eov74RV0sUYd8IBWV3T+Vx89/Dl9nomSPuIvgTZMQIDAQAB";
                var userinfo = a.DecryptDataList(key, strMD5SecureKey, strNewDataList);
                Dictionary<string, string> data = new Dictionary<string, string>();
                var array = userinfo.Split(';').ToList();
                array.ForEach(x =>
                {
                    var team = x.Split('=');
                    if (team.Count() == 2)
                    {
                        data.Add(team[0], team[1]);
                    }
                });
                return data;
            }
            catch (Exception)
            {
                return new Dictionary<string, string>();
            }
        }

        public enum EnumSSO
        {
            EP_RETURNCODE,
            EP_LOGINID,
            EP_COMPID,
            EP_SOCIALID,
            EP_DEPTID,
            EP_GRDID,
            EP_SECID,
            EP_GRPLST,
            EP_PASSWORD,
            EP_MAILHOST,
            EP_SABUN,
            EP_LANG,
            EP_LOCALE,
            EP_USERDN,
            EP_USERLEVEL,
            EP_USERSTATUS,
            EP_COMPTEL,
            EP_DM,
            EP_SORGID,
            EP_BUSID,
            EP_REGID,
            EP_MAIL,
            EP_USERID,
            EP_PRIVLST,
            EP_STRHTTP,
            EP_DCOMP,
            EP_USERLOCATION,
            EP_ICODE,
            EP_ROLEID,
            EP_SERVICECODE,
            EP_DCOMPCODE,
            EP_TIMEZONE,
            EP_EPFTP,
            EP_LISTCOUNT,
            EP_WEBEDITOR,
            EP_RETURNURL,
            EP_CHPWD,
            EP_SERVICELEVEL,
            EP_ATTACHSIZE,
            EP_NATIVEYN,
            EP_MAILRECPTCNT,
            EP_SUMMERTIMEYN,
            EP_RELOGINYN,
            EP_OMINUSEYN,
            EP_PASSWORDUSEYN,
            EP_LEVELAWARE,
            EP_MESSAGECODE,
            EP_USERNAME,
            EP_COMPNAME,
            EP_DEPTNAME,
            EP_GRDNAME,
            EP_SORGNAME,
            EP_BUSNAME, EP_REGNAME,
            EP_USERNAME_EN,
            EP_NICKNAME,
            EP_COMPNAME_EN,
            EP_DEPTNAME_EN,
            EP_GRDNAME_EN,
            EP_SORGNAME_EN,
            EP_PREFERREDLANGUAGE,
            EP_MCODE,
            EP_SCREENSIZE,
            EP_MOBILE,
            EP_BASE64YN,
            EP_COMPRESSYN,
            EP_GLOBALPOSITION,
            EP_DOMAIN,
            EP_LCDM,
            EP_LIGHTTRAYYN,
            EP_LOGINIP,
            EP_COMPCONFIG,
            EP_ZOOMSIZE,
            EP_ADMINORGID,
            EP_BOARDFLAG,
            EP_VOIPNUMBER,
            EP_LOGINTIMEFORMIS,
            EP_HEADERSKIN,
            EP_NEWWINYN,
            EP_SKINID,
            EP_UNREAD,
            EP_MYDMSINFO,
            EP_MAILSECUREIMG,
            EP_CACHEPATH,
            EP_MYSINGLEVERSION,
            EP_WORKDMSURL,
            EP_GSOPORTALURL,
            EP_LOGINPOSITION,
            EP_OCSCODE,
            EP_TEXTFONT,
            EP_TEXTSIZE,
            EP_TEXTPANE,
            EP_VOIPSTATUS,
            EP_PAGENAVIGATION,
            EP_COUNTRYKO,
            EP_COUNTRYEN,
            EP_REGIONKO,
            EP_REGIONEN,
            EP_OUTLOOKUSER,
            EP_ATTACHPOSITION,
            EP_MOBILEDESKUSER,
            EP_UNREADEX,
            EP_SSOTOKEN,
            EP_PUSHTYPE
        }
    }
}
