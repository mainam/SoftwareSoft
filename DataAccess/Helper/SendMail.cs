using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading;
using System.Net.Mail;
using System.Net;
using System.Collections.Specialized;
using System.Text;
using DataAccess.DataConfigFolder;

namespace DataAccess.Helper
{
    //public class SendMailThread
    //{
    //    string recipient;
    //    string subject;
    //    string message;
    //    public SendMailThread(string recipient, string subject, string message)
    //    {
    //        this.recipient = recipient;
    //        this.subject = subject;
    //        this.message = message;
    //    }
    //    public void SendMail()
    //    {
    //        //OutlookDotComMail.SendMail(recipient, subject, message);
    //    }
    //}


    public class SendMail
    {

        public static void send(string from, List<string> listto, List<string> listcc, string subject, string content)
        {
            try
            {
                //SendMailService(from, string.Join(",", listto), string.Join(",", listcc), subject, content);
            }
            catch (System.Net.Mail.SmtpException ex)
            {
            }
            catch (Exception ex)
            {
            }
        }

        static string mailfrom = null;
        public static String MailSystem
        {
            get
            {
                if (mailfrom == null)
                {
                    using (var context = new DatabaseDataContext())
                    {
                        var data = DataConfigInfo.GetDataConfig(context, DataConfigEnum.MailSystem);
                        if (data.Count() > 0)
                            mailfrom = data.First().DataValue;
                        else
                            return "SelSVMC@samsung.com";
                    }
                }
                return mailfrom;
            }
            set
            {
                if (value != null)
                    mailfrom = value;
                else
                    if (mailfrom == null)
                    {
                        mailfrom = "SelSVMC@samsung.com";
                    }
            }
        }



        static string mailservice = null;
        public static String MailService
        {
            get
            {
                if (mailservice == null)
                {
                    using (var context = new DatabaseDataContext())
                    {
                        var data = DataConfigInfo.GetDataConfig(context, DataConfigEnum.MailService);
                        if (data.Count() > 0)
                            mailservice = data.First().DataValue;
                        else
                            return "http://107.113.53.35:9981/SendMail.aspx";
                    }
                }
                return mailservice;
            }
            set
            {
                if (value != null)
                    mailservice = value;
                else
                    if (mailservice == null)
                    {
                        mailservice = "http://107.113.53.35:9981/SendMail.aspx";
                    }
            }
        }


        public static void send(List<string> listto, List<string> listcc, string subject, string content)
        {
            try
            {
                //SendMailService(MailSystem, string.Join(",", listto), string.Join(",", listcc), subject, content);                
            }
            catch (System.Net.Mail.SmtpException ex)
            {
            }
            catch (Exception ex)
            {
            }
        }

        public static void send(List<string> listto, string subject, string content)
        {
            try
            {
                //SendMailService(MailSystem, string.Join(",", listto), "", subject, content);

                //SendMailService("SelSVMC@samsung.com", string.Join(",", user), subject, content);
                //Thread t = new Thread(delegate()
                //{
                //    //user = new List<string>() { "ngoc.nam@samsung.com" };
                //    if (user != null && user.Count != 0)
                //    {
                //        string message = content + "<br><br><br>This email is sent automatical by TMS System.<br>Please do not reply";
                //        MailMessage mail = new MailMessage("TaskManagementSystem@samsung.com", user[0]);
                //        mail.Sender = new MailAddress("TaskManagementSystem@samsung.com");
                //        for (int i = 1; i < user.Count; i++)
                //            mail.To.Add(user[i]);
                //        SmtpClient client = new SmtpClient();
                //        client.Port = 25;
                //        client.DeliveryMethod = SmtpDeliveryMethod.Network;
                //        client.UseDefaultCredentials = false;
                //        client.Host = "203.254.227.15";
                //        mail.Subject = subject;
                //        mail.Body = message;
                //        mail.IsBodyHtml = true;
                //        client.Send(mail);
                //    }
                //});
                //t.Start();
            }
            catch (System.Net.Mail.SmtpException ex)
            {
            }
            catch (Exception ex)
            {
            }
        }

        //SendMailService("ngoc.nam@samsung.com", "ngoc.nam@samsung.com,ngoc.nam2@samsung.com", "dgdbxcvbxcv", "dfgdfgertyert");

        static void SendMailService(string from, string to, string subject, string body)
        {
            //NameValueCollection outgoingQueryString = HttpUtility.ParseQueryString(String.Empty);
            //outgoingQueryString.Add("from", from);
            //outgoingQueryString.Add("to", to);
            //outgoingQueryString.Add("cc", "");
            //outgoingQueryString.Add("subject", subject);
            //outgoingQueryString.Add("body", body);

            //var encoding = new ASCIIEncoding();
            //byte[] data = encoding.GetBytes(outgoingQueryString.ToString());
            //var myRequest = (HttpWebRequest)WebRequest.Create("http://107.113.187.212:9981/SendMail.aspx");
            //myRequest.Method = "POST";
            //myRequest.ContentType = "application/x-www-form-urlencoded";
            //myRequest.ContentLength = data.Length;
            //var newStream = myRequest.GetRequestStream();
            //newStream.Write(data, 0, data.Length);
            //newStream.Close();

            //var response = myRequest.GetResponse();
            //var responseStream = response.GetResponseStream();
            //var responseReader = new StreamReader(responseStream);
            //var result = responseReader.ReadToEnd();

            using (var client = new WebClient())
            {
                NameValueCollection outgoingQueryString = HttpUtility.ParseQueryString(String.Empty);
                outgoingQueryString.Add("from", from);
                outgoingQueryString.Add("to", to);
                outgoingQueryString.Add("cc", "");
                outgoingQueryString.Add("subject", subject);
                outgoingQueryString.Add("body", body);
                WebClient myRequest = new WebClient();
                var response = client.UploadValues(MailService, "POST", outgoingQueryString);
            }

        }

        static void SendMailService(string from, string to, string cc, string subject, string body)
        {
            //NameValueCollection outgoingQueryString = HttpUtility.ParseQueryString(String.Empty);
            //outgoingQueryString.Add("from", from);
            //outgoingQueryString.Add("to", to);
            //outgoingQueryString.Add("cc", "");
            //outgoingQueryString.Add("subject", subject);
            //outgoingQueryString.Add("body", body);

            //var encoding = new ASCIIEncoding();
            //byte[] data = encoding.GetBytes(outgoingQueryString.ToString());
            //var myRequest = (HttpWebRequest)WebRequest.Create("http://107.113.187.212:9981/SendMail.aspx");
            //myRequest.Method = "POST";
            //myRequest.ContentType = "application/x-www-form-urlencoded";
            //myRequest.ContentLength = data.Length;
            //var newStream = myRequest.GetRequestStream();
            //newStream.Write(data, 0, data.Length);
            //newStream.Close();

            //var response = myRequest.GetResponse();
            //var responseStream = response.GetResponseStream();
            //var responseReader = new StreamReader(responseStream);
            //var result = responseReader.ReadToEnd();

            
            using (var client = new WebClient())
            {
                NameValueCollection outgoingQueryString = HttpUtility.ParseQueryString(String.Empty);
                outgoingQueryString.Add("from", from);
                outgoingQueryString.Add("to", to);
                outgoingQueryString.Add("cc", cc);
                outgoingQueryString.Add("subject", subject);
                outgoingQueryString.Add("body", body);
                WebClient myRequest = new WebClient();
                //var response = client.UploadValues("http://107.113.187.212:9981/SendMail.aspx", "POST", outgoingQueryString);
                var response = client.UploadValues(MailService, "POST", outgoingQueryString);
            }

        }
        //public static bool SendMail1(string sender, List<string> recipient, List<string> cc, string subject, string message)
        //{
        //    try
        //    {

        //        //MailMessage mail = new MailMessage();
        //        //mail.From = new MailAddress(sender);

        //        //foreach (var item in recipient)
        //        //    mail.To.Add(item);
        //        //foreach (var item in cc)
        //        //    mail.CC.Add(item);
        //        //SmtpClient client = new SmtpClient();
        //        //client.Port = 25;
        //        //client.DeliveryMethod = SmtpDeliveryMethod.Network;
        //        //client.UseDefaultCredentials = false;
        //        //client.Host = "203.254.227.15";
        //        //mail.Subject = subject;
        //        //mail.Body = message;
        //        //client.Send(mail);
        //        //return true;

        //    }
        //    catch (Exception ex)
        //    {
        //        return false;
        //    }
        //}
    }
}