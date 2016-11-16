using ClosedXML.Excel;
using DataAccess;
using DataAccess.DeviceFolder;
using DataAccess.DeviceFolder.InventoryFolder;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SoftwareStore.device.AjaxProcess
{
    public partial class Export : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var type = Request.QueryString["Type"];
            var inventoryid = Request.QueryString["InventoryID"];
            var username = HttpContext.Current.User.Identity.Name;
            using (var context = new DatabaseDataContext())
            {
                switch (type)
                {
                    case "devicemanagement":
                        ExportListAllDeviceManagement(context, username);
                        break;
                    case "listalldevice":
                        ExportListAllDevice(context, username);
                        break;
                    case "deviceinteam":
                        ExportDeviceInTeam(context, username);
                        break;

                    case "returndevice":
                        ExportListNeedReturn(context, username);
                        break;
                    case "listdeviceborrowing":
                        ExportMyBorrowing(context, username);
                        break;
                    case "listdevicekeeping":
                        ExportListDeviceKeeping(context, username);
                        break;
                    case "inventoryform":
                        ExportInventoryForm(context, int.Parse(inventoryid));
                        break;
                    case "listdevicepending":
                        ExportListDevicePending(context);
                        break;
                    case "resultinventory":
                        var typeexport = Request.QueryString["typeexport"];
                        ExportResultInventory(context, int.Parse(inventoryid), typeexport);
                        break;
                    default:
                        break;
                }
            }
        }


        private void ExportDeviceInTeam(DatabaseDataContext context, string username)
        {

            using (XLWorkbook wb = new XLWorkbook())
            {
                var listAllDevice = DeviceInfo.GetListDeviceInTeam(context, username);

                var sheetname = "DATA DEVICE";
                var dt = new DataTable(sheetname);
                dt.Columns.AddRange(new DataColumn[12] { new DataColumn("No"), new DataColumn("Type"), new DataColumn("Tag"), new DataColumn("Model Name"), new DataColumn("Version"), new DataColumn("Manager"), new DataColumn("Borrower"), new DataColumn("Keeper"), new DataColumn("Status"), new DataColumn("IMEI"), new DataColumn("S/N"), new DataColumn("Note") });
                var i = 0;
                var temp = listAllDevice.OrderByDescending(x => x.Type).ThenBy(x => x.Model).ThenBy(x => x.Borrower);
                foreach (var item2 in temp)
                {
                    dt.Rows.Add(++i, item2.Type, item2.Tag, item2.Model, item2.Version, item2.FullNameManager, item2.FullNameBorrower, item2.FullNameKeeper, item2.Status, item2.IMEI, item2.Serial, item2.Note);
                }
                wb.Worksheets.Add(dt);


                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=ListDeviceInTeam_" + DateTime.Now.ToString("dd/MM/yyyy") + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }

        }



        private void ExportListAllDeviceManagement(DatabaseDataContext context, string username)
        {

            using (XLWorkbook wb = new XLWorkbook())
            {
                List<DataDevice> listAllDevice = DeviceInfo.GetAllDeviceManagement(context, username);

                var sheetname = "DATA DEVICE";
                var dt = new DataTable(sheetname);
                dt.Columns.AddRange(new DataColumn[12] { new DataColumn("No"), new DataColumn("Type"), new DataColumn("Tag"), new DataColumn("Model Name"), new DataColumn("Version"), new DataColumn("Borrower"), new DataColumn("Borrow Date"), new DataColumn("Return Date"), new DataColumn("Status"), new DataColumn("IMEI"), new DataColumn("S/N"), new DataColumn("Note") });
                var i = 0;
                var temp = listAllDevice.OrderByDescending(x => x.Type).ThenBy(x => x.Model).ThenBy(x => x.Borrower);
                foreach (var item2 in temp)
                {
                    dt.Rows.Add(++i, item2.Type, item2.Tag, item2.Model, item2.Version, item2.Borrower, item2.BorrowDate, item2.ReturnDate, item2.Status, item2.IMEI, item2.Serial, item2.Note);
                }
                wb.Worksheets.Add(dt);


                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=ListDeviceManagement_" + DateTime.Now.ToString("dd/MM/yyyy") + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }

        }

        private void ExportListAllDevice(DatabaseDataContext context, string username)
        {

            using (XLWorkbook wb = new XLWorkbook())
            {
                List<DataDevice> listAllDevice = DeviceInfo.GetAllDeviceAllowBorrow(context, username, new List<int>());

                var sheetname = "DATA DEVICE";
                var dt = new DataTable(sheetname);
                dt.Columns.AddRange(new DataColumn[12] { new DataColumn("No"), new DataColumn("Type"), new DataColumn("Tag"), new DataColumn("Model Name"), new DataColumn("Version"), new DataColumn("Manager"), new DataColumn("Borrower"), new DataColumn("Keeper"), new DataColumn("Status"), new DataColumn("IMEI"), new DataColumn("S/N"), new DataColumn("Note") });
                var i = 0;
                var temp = listAllDevice.OrderByDescending(x => x.Type).ThenBy(x => x.Model).ThenBy(x => x.Borrower);
                foreach (var item2 in temp)
                {
                    dt.Rows.Add(++i, item2.Type, item2.Tag, item2.Model, item2.Version, item2.FullNameManager, item2.FullNameBorrower, item2.FullNameKeeper, item2.Status, item2.IMEI, item2.Serial, item2.Note);
                }
                wb.Worksheets.Add(dt);


                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=ListAllDevice_" + DateTime.Now.ToString("dd/MM/yyyy") + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }

        }


        private void ExportListNeedReturn(DatabaseDataContext context, string username)
        {

            using (XLWorkbook wb = new XLWorkbook())
            {
                var listAllDevice = DeviceInfo.GetListDeviceNeedReturn(context, username);

                var sheetname = "DATA DEVICE";
                var dt = new DataTable(sheetname);
                dt.Columns.AddRange(new DataColumn[12] { new DataColumn("No"), new DataColumn("Type"), new DataColumn("Tag"), new DataColumn("Model Name"), new DataColumn("Version"), new DataColumn("Borrower"), new DataColumn("Borrow Date"), new DataColumn("Return Date"), new DataColumn("Status"), new DataColumn("IMEI"), new DataColumn("S/N"), new DataColumn("Note") });
                var i = 0;
                var temp = listAllDevice.OrderByDescending(x => x.Type).ThenBy(x => x.Model).ThenBy(x => x.Borrower);
                foreach (var item2 in temp)
                {
                    dt.Rows.Add(++i, item2.Type, item2.Tag, item2.Model, item2.Version, item2.Borrower, item2.BorrowDate, item2.ReturnDate, item2.Status, item2.IMEI, item2.Serial, item2.Note);
                }
                wb.Worksheets.Add(dt);


                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=ListDeviceNeedReturn_" + DateTime.Now.ToString("dd/MM/yyyy") + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }

        }


        private void ExportResultInventory(DatabaseDataContext context, int inventoryid, string type)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                var listinventory = InventoryInfo.GetListDeviceInventory(context, inventoryid);

                if (type == "normal")
                {
                    var sheetname = "DATA INVENTORY";
                    var dt = new DataTable(sheetname);
                    dt.Columns.AddRange(new DataColumn[9] { new DataColumn("No"), new DataColumn("Type"), new DataColumn("Tag"), new DataColumn("Model Name"), new DataColumn("Borrower"), new DataColumn("Borrow Date"), new DataColumn("Note"), new DataColumn("Status Confirm"), new DataColumn("Signature") });
                    var i = 0;
                    var temp = listinventory.OrderByDescending(x => x.Device.DeviceModel.Category).ThenBy(x => x.Device.Model).ThenBy(x => x.Borrower);
                    foreach (var item2 in temp)
                    {
                        dt.Rows.Add(++i, item2.Device.DeviceModel.CategoryDevice.Name, item2.Device.Tag, item2.Device.Model, item2.Borrower, item2.BorrowDate != null ? item2.BorrowDate.Value.ToString("dd/MM/yyyy") : "", item2.Reason, InventoryInfo.GetStatus(item2), "");
                    }
                    wb.Worksheets.Add(dt);
                }
                else
                {
                    var list1 = listinventory.GroupBy(x => x.Device.Model);
                    int gbtype = 1;
                    switch (type)
                    {
                        case "exportbyborrower":
                            list1 = listinventory.GroupBy(x => x.Borrower);
                            gbtype = 2;
                            break;
                        case "exportbycategory":
                            list1 = listinventory.GroupBy(x => x.Device.DeviceModel.Category.ToString());
                            gbtype = 3;
                            break;
                        case "exportbystatusconfirm":
                            list1 = listinventory.GroupBy(x => x.ConfirmStatus.ToString());
                            gbtype = 4;
                            break;
                        case "normal":
                            gbtype = 5;
                            break;
                    }

                    var listdatatable = new List<DataTable>();
                    foreach (var item in list1)
                    {
                        var sheetname = "SheetName" + DateTime.Now.ToString("dd_MM_yyyy").Replace("/", "_").Replace("\\", "_").Replace("?", "_").Replace("*", "_").Replace("[", "_").Replace("]", "_");
                        switch (gbtype)
                        {
                            case 1:
                                sheetname = item.First().Device.Model;
                                break;
                            case 2:
                                sheetname = item.First().User.UserName + "_" + item.First().User.FullName;
                                break;
                            case 3:
                                sheetname = item.First().Device.DeviceModel.CategoryDevice.Name;
                                break;
                            case 4:
                                sheetname = InventoryInfo.GetStatus(item.First());
                                break;
                        }
                        sheetname = sheetname.Replace("/", "_").Replace("\\", "_").Replace("?", "_").Replace("*", "_").Replace("[", "_").Replace("]", "_");
                        if (sheetname.Length > 31) sheetname = sheetname.Substring(0, 30);
                        var dt = new DataTable(sheetname);
                        dt.Columns.AddRange(new DataColumn[9] { new DataColumn("No"), new DataColumn("Type"), new DataColumn("Tag"), new DataColumn("Model Name"), new DataColumn("Borrower"), new DataColumn("Borrow Date"), new DataColumn("Note"), new DataColumn("Status Confirm"), new DataColumn("Signature") });
                        var i = 0;
                        var temp = item.OrderByDescending(x => x.Device.DeviceModel.Category);
                        foreach (var item2 in temp)
                        {
                            dt.Rows.Add(++i, item2.Device.DeviceModel.CategoryDevice.Name, item2.Device.Tag, item2.Device.Model, item2.Borrower, item2.BorrowDate != null ? item2.BorrowDate.Value.ToString("dd/MM/yyyy") : "", item2.Reason, InventoryInfo.GetStatus(item2), "");
                        }
                        wb.Worksheets.Add(dt);
                    }
                }

                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=Inventory_" + inventoryid + "_" + DateTime.Now.ToString("dd/MM/yyyy") + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }

        }


        private void ExportListDevicePending(DatabaseDataContext context)
        {

            using (XLWorkbook wb = new XLWorkbook())
            {

                var listAllDevice = DeviceInfo.GetListDeviceTransferPending(context);

                var sheetname = "DATA DEVICE";
                var dt = new DataTable(sheetname);
                dt.Columns.AddRange(new DataColumn[13] { new DataColumn("No"), new DataColumn("Type"), new DataColumn("Tag"), new DataColumn("Model Name"), new DataColumn("Version"), new DataColumn("Transfer To"), new DataColumn("Transfer Date"), new DataColumn("Borrower"), new DataColumn("Keep Date"), new DataColumn("Status"), new DataColumn("IMEI"), new DataColumn("S/N"), new DataColumn("Note") });
                var i = 0;
                var temp = listAllDevice.OrderByDescending(x => x.Type).ThenBy(x => x.Model).ThenBy(x => x.Borrower);
                foreach (var item2 in temp)
                {
                    dt.Rows.Add(++i, item2.Type, item2.Tag, item2.Model, item2.Version, item2.NewKeeper, item2.TransferDate, item2.FullNameBorrower, item2.KeepDate, item2.Status, item2.IMEI, item2.Serial, item2.Note);
                }
                wb.Worksheets.Add(dt);


                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=ListDevicePending_" + DateTime.Now.ToString("dd/MM/yyyy") + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }

        }

        private void ExportListDeviceKeeping(DatabaseDataContext context, string username)
        {

            using (XLWorkbook wb = new XLWorkbook())
            {

                var listAllDevice = DeviceInfo.GetListDeviceKeeping(context, username);

                var sheetname = "DATA DEVICE";
                var dt = new DataTable(sheetname);
                dt.Columns.AddRange(new DataColumn[11] { new DataColumn("No"), new DataColumn("Type"), new DataColumn("Tag"), new DataColumn("Model Name"), new DataColumn("Version"), new DataColumn("Borrower"), new DataColumn("Keep Date"), new DataColumn("Status"), new DataColumn("IMEI"), new DataColumn("S/N"), new DataColumn("Note") });
                var i = 0;
                var temp = listAllDevice.OrderByDescending(x => x.Type).ThenBy(x => x.Model).ThenBy(x => x.Borrower);
                foreach (var item2 in temp)
                {
                    dt.Rows.Add(++i, item2.Type, item2.Tag, item2.Model, item2.Version, item2.FullNameBorrower, item2.KeepDate, item2.Status, item2.IMEI, item2.Serial, item2.Note);
                }
                wb.Worksheets.Add(dt);


                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=ListDeviceKeeping_" + DateTime.Now.ToString("dd/MM/yyyy") + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }

        }

        private void ExportMyBorrowing(DatabaseDataContext context, string username)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                var mydevice = DeviceInfo.GetListDeviceBorrowing(context, username).GroupBy(x => x.Model);
                var listdatatable = new List<DataTable>();
                foreach (var item in mydevice)
                {
                    var model = item.First().Model;
                    var sheetname = model.Replace("/", "_").Replace("\\", "_").Replace("?", "_").Replace("*", "_").Replace("[", "_").Replace("]", "_");
                    if (sheetname.Length > 31) sheetname = sheetname.Substring(0, 30);
                    var dt = new DataTable(sheetname);
                    dt.Columns.AddRange(new DataColumn[9] { new DataColumn("No"), new DataColumn("Type"), new DataColumn("Tag"), new DataColumn("Model Name"), new DataColumn("Borrower"), new DataColumn("Borrow Date"), new DataColumn("Keeper"), new DataColumn("Keep Date"), new DataColumn("Signature") });
                    var i = 0;
                    var temp = item.OrderByDescending(x => x.Type);
                    foreach (var item2 in temp)
                    {
                        dt.Rows.Add(++i, item2.Type, item2.Tag, item2.Model, item2.FullNameBorrower, item2.BorrowDate != null ? item2.BorrowDate : "", item2.FullNameKeeper, item2.KeepDate != null ? item2.KeepDate : "", "");
                    }
                    wb.Worksheets.Add(dt);
                }

                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=MyDeviceBorrowing_" + DateTime.Now.ToString("dd/MM/yyyy") + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }

        }


        private void ExportInventoryForm(DatabaseDataContext context, int inventoryid)
        {
            using (XLWorkbook wb = new XLWorkbook())
            {
                var listinventory = InventoryInfo.ExportFormInventory(context, inventoryid);
                var listdatatable = new List<DataTable>();
                var listuser = listinventory.GroupBy(x => x.Borrower);
                foreach (var item in listuser)
                {
                    var user = item.First().User;
                    var sheetname = user.UserName + "_" + user.FullName;
                    sheetname = sheetname.Replace("/", "_").Replace("\\", "_").Replace("?", "_").Replace("*", "_").Replace("[", "_").Replace("]", "_");
                    if (sheetname.Length > 31) sheetname = sheetname.Substring(0, 30);
                    var dt = new DataTable(sheetname);
                    dt.Columns.AddRange(new DataColumn[7] { new DataColumn("No"), new DataColumn("Type"), new DataColumn("Tag"), new DataColumn("Model Name"), new DataColumn("Borrower"), new DataColumn("Borrow Date"), new DataColumn("Signature") });
                    var i = 0;
                    var temp = item.OrderByDescending(x => x.Device.DeviceModel.CategoryDevice.Name).ThenBy(x => x.Device.Model);
                    foreach (var item2 in temp)
                    {
                        dt.Rows.Add(++i, item2.Device.DeviceModel.CategoryDevice.Name, item2.Device.Tag, item2.Device.DeviceModel.ModelName, item2.User.UserName + "/" + item2.User.FullName, item2.BorrowDate != null ? item2.BorrowDate.Value.ToShortDateString() : "");
                    }
                    wb.Worksheets.Add(dt);
                }

                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=Inventory_" + DateTime.Now.ToString("dd/MM/yyyy") + ".xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }

        }


    }
}