using DataAccess;
using DataAccess.Db.Product.ProductDbFull;
using DataAccess.SendMailFolder;
using DataAccess.UserFolder;
using DataAccess.UtilFolder;
using System;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace SoftwareStore.Admin.SanPham
{
    public partial class DangSanPham : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var username = HttpContext.Current.User.Identity.Name;
                if (!UserInfo.IsAdmin(username))
                {
                    Response.Redirect("/home/error404.html");
                    return;
                }

                int id = Converts.ToInt(Request.QueryString["id"], 0);
                if (id == 0)
                    btnXoa.Visible = true;
                else
                    btnXoa.Visible = false;

                cbListCategory.DataSource = CategoryInfo.getCategory(0);
                cbListCategory.DataTextField = "Name";
                cbListCategory.DataValueField = "Id";
                cbListCategory.DataBind();

                cbListStatus.DataSource = SoftwareStatusInfo.getAll();
                cbListStatus.DataTextField = "Name";
                cbListStatus.DataValueField = "Id";
                cbListStatus.DataBind();


            }
            catch (Exception)
            {
                Response.Redirect("/home/error404.html");

            }

        }

        [WebMethod]
        public static string Save(int id, string ten, decimal gia, int baohanh, int giamgia, int chuyenmuc, int status, String fileUrl, String avatarUrl, String motasanpham)
        {
            try
            {
                using (var context = new ProductDbFullDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    var user = context.tbUsers.SingleOrDefault(x => x.UserName.Equals(username));
                    if (user == null)
                    {
                        throw new Exception("Đăng nhập đế sử dụng");
                    }
                    if (user.TypeUser == 2)
                    {
                        throw new Exception("Bạn không có quyền sử dụng chức năng này");
                    }
                    if (id != 0)
                    {
                        var sanpham = context.tbSoftwares.SingleOrDefault(x => x.Id == id);
                        if (sanpham == null)
                            throw new Exception("Không tìm thấy thông tin sản phẩm trong hệ thống");
                        if (sanpham.UpBy != username && user.TypeUser != 1)
                            throw new Exception("Bạn không có quyền sử dụng chức năng này");
                        sanpham.Name = ten;
                        sanpham.Price = gia;
                        sanpham.Link = fileUrl;
                        sanpham.ImageUrl = avatarUrl;
                        sanpham.Description = sanpham.ShortDescription = motasanpham;
                        sanpham.Status = status;
                        sanpham.NumberGuaranteeDate = baohanh;
                        sanpham.Discount = giamgia;
                        if(status==2)
                        {
                            sanpham.CloseDate = DateTime.Now;
                        }
                        else
                        {
                            sanpham.CloseDate = null;                        
                        }
                        sanpham.CategoryId = chuyenmuc;
                        context.SubmitChanges();                   
                    }
                    else
                    {
                        var sanpham = new DataAccess.Db.Product.ProductDbFull.tbSoftware()
                        {
                            CategoryId=chuyenmuc,
                            Description=motasanpham,
                            Discount=giamgia,
                            ShortDescription=motasanpham,
                            Link=fileUrl,
                            ImageUrl=avatarUrl,
                            Price=gia,
                            UpBy=username,
                            Status=status,
                            NumberGuaranteeDate=baohanh,
                            Name=ten,
                            CloseDate= DateTime.Now                            
                        };
                        if (status != 2)
                            sanpham.CloseDate = null;
                        context.SubmitChanges();
                    }

                    return new JavaScriptSerializer().Serialize(new { Status = true });
                }
            }
            catch (Exception e)
            {
                return new System.Web.Script.Serialization.JavaScriptSerializer().Serialize(new { Status = false, Data = e.Message });
            }
        }

        [WebMethod]
        public static string LoadData(string keyword, int page, int numberinpage)
        {
            try
            {
                using (var context = new DatabaseDataContext())
                {
                    var username = HttpContext.Current.User.Identity.Name;
                    int totalitem = 0;
                    var data = LogSendMailServiceInfo.GetAll(context, keyword, page, numberinpage, username, ref totalitem);
                    var text = new JavaScriptSerializer().Serialize(new { Status = true, TotalItem = totalitem, Data = data.Select(x => new { x.CC, x.Content, Date = x.Date.ToString(), x.From, x.ID, x.To, x.UserName, x.Subject }) });
                    return text;
                }
            }
            catch (Exception)
            {
                return new JavaScriptSerializer().Serialize(new { Status = false });
            }
        }
    }
}