using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace DataAccess.Helper
{
    public class OutlookDotComMail
    {
        public static bool SendMail(string sender, List<string> recipient, List<string> cc, string subject, string message)
        {
            try
            {
                MailMessage mail = new MailMessage();
                foreach (var item in recipient)
                    mail.To.Add(item);
                foreach (var item in cc)
                    mail.CC.Add(item);
                SmtpClient client = new SmtpClient();
                client.Port = 25;
                client.DeliveryMethod = SmtpDeliveryMethod.Network;
                client.UseDefaultCredentials = false;
                client.Host = "203.254.227.15";
                mail.Subject = subject;
                mail.Body = message;
                client.Send(mail);
                return true;

            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}