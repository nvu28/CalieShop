using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace BaiTapLTW
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedUser"] == null)
            {
                Response.Redirect("../DangNhap/Login.aspx");
                return;
            }
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = @"SELECT c.ProductID, p.Name, p.Price, p.ImagePath, c.Quantity
                       FROM Cart c
                       JOIN Products p ON c.ProductID = p.ProductID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                rptCart.DataSource = dr;
                rptCart.DataBind();
                conn.Close();
            }

            // Tính tổng tiền
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sqlTotal = @"SELECT SUM(p.Price * c.Quantity) 
                            FROM Cart c JOIN Products p ON c.ProductID = p.ProductID";
                SqlCommand cmdTotal = new SqlCommand(sqlTotal, conn);
                conn.Open();
                object result = cmdTotal.ExecuteScalar();
                lblTotal.Text = result != DBNull.Value ? ((decimal)result).ToString("N0") + " ₫" : "0 ₫";
            }
        }

        protected void btnIncrease_Command(object sender, CommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);
            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = "UPDATE Cart SET Quantity = Quantity + 1 WHERE ProductID = @id";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@id", productId);
                cmd.ExecuteNonQuery();
            }
            LoadCart(); // refresh lại dữ liệu trong UpdatePanel
        }

        protected void btnDecrease_Command(object sender, CommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);
            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = "UPDATE Cart SET Quantity = CASE WHEN Quantity > 1 THEN Quantity - 1 ELSE Quantity END WHERE ProductID = @id";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@id", productId);
                cmd.ExecuteNonQuery();
            }
            LoadCart();
        }
        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            int userId = (int)Session["LoggedUser"];
            string name = txtName.Text.Trim();
            string phone = txtPhone.Text.Trim();
            string email = txtEmail.Text.Trim();
            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();


                foreach (RepeaterItem ri in rptCart.Items)
                {
                    HiddenField hfSize = (HiddenField)ri.FindControl("hfSize");
                    string size = hfSize != null ? hfSize.Value : "M";
                    if (string.IsNullOrEmpty(size))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(),
                            "alert", "alert('Vui lòng chọn size cho tất cả sản phẩm!');", true);
                        return;
                    }

                    TextBox txtQty = (TextBox)ri.FindControl("txtQty");
                    int qty = int.Parse(txtQty.Text);

                    HiddenField hfProductID = (HiddenField)ri.FindControl("hfProductID");
                    int productId = int.Parse(hfProductID.Value);
                    // Insert từng sản phẩm trong giỏ vào bảng DonHang


                    string sqlPrice = "SELECT Price FROM Products WHERE ProductID=@pid";
                    SqlCommand cmdPrice = new SqlCommand(sqlPrice, conn);
                    cmdPrice.Parameters.AddWithValue("@pid", productId);
                    decimal price = (decimal)cmdPrice.ExecuteScalar();

                    string insertOrder = @"INSERT INTO DonHang(UserID, CustomerName, Phone, Email, ProductID, Quantity, Size, Price, OrderDate)
                       VALUES(@uid, @name, @phone, @email, @pid, @qty, @size, @price, GETDATE())";

                    SqlCommand cmdOrder = new SqlCommand(insertOrder, conn);
                    cmdOrder.Parameters.AddWithValue("@uid", userId);
                    cmdOrder.Parameters.AddWithValue("@name", name);
                    cmdOrder.Parameters.AddWithValue("@phone", phone);
                    cmdOrder.Parameters.AddWithValue("@email", email);
                    cmdOrder.Parameters.AddWithValue("@pid", productId);
                    cmdOrder.Parameters.AddWithValue("@qty", qty);
                    cmdOrder.Parameters.AddWithValue("@size", size);
                    cmdOrder.Parameters.AddWithValue("@price", price);
                    cmdOrder.ExecuteNonQuery();
                }

                // Xóa giỏ hàng sau khi đặt
                string deleteCart = "DELETE FROM Cart WHERE UserID=@uid";
                SqlCommand cmdDelete = new SqlCommand(deleteCart, conn);
                cmdDelete.Parameters.AddWithValue("@uid", userId);
                cmdDelete.ExecuteNonQuery();
            }

            LoadCart();

            // Thông báo + redirect sau 3 giây
            string script = "alert('Đặt hàng thành công!');" +
                            "setTimeout(function(){ window.location='../SanPham/SanPham.aspx'; }, 3000);";
            ScriptManager.RegisterStartupScript(this, this.GetType(),
                "redirect", script, true);
        }
    
        }
    }
