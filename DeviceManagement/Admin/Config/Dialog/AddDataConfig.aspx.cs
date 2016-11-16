using DataAccess;
using DataAccess.DataConfigFolder;
using DataAccess.UtilFolder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.Admin.Config.Dialog
{
    public partial class AddDataConfig : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            cbListTypeEnum.DataSource = Enum.GetNames(typeof(DataConfigEnum)).ToList();
            cbListTypeEnum.DataBind();
        }

        [WebMethod]
        public static string AddNewDataConfig(int id, string datakey, string datavalue)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    DataConfig dataconfig;
                    if(id==0)
                    {
                        dataconfig = new DataConfig()
                        {
                            ApplyDate = DateTime.Now,
                            DataKey = datakey,
                            DataValue = datavalue
                        };
                        context.DataConfigs.InsertOnSubmit(dataconfig);
                    }
                    else
                    {
                        dataconfig = context.DataConfigs.SingleOrDefault(x => x.ID == id && x.DataKey == datakey);
                        if (dataconfig == null)
                            throw new Exception();

                        dataconfig.DataValue = datavalue;
                    }
                    context.SubmitChanges();
                    SetupDataConfig.DataConfigChange(dataconfig);
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