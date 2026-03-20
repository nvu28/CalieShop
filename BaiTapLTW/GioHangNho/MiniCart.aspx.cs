using System;
using System.Data.SqlClient;
using System.Configuration;

namespace BaiTapLTW
{
    public partial class MiniCart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["pid"] != null)
                {
                    int productId = Convert.ToInt32(Request.QueryString["pid"]);
                    LoadProduct(productId);
                }
            }
        }

        private void LoadProduct(int productId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT Name, Price FROM Products WHERE ProductID=@id";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@id", productId);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblTenSP.Text = dr["Name"].ToString();
                    lblGia.Text = ((decimal)dr["Price"]).ToString("N0") + " ₫";
                }
            }
        }

        protected void btnXacNhan_Click(object sender, EventArgs e)
        {
            string size = Request.QueryString["size"];
            int userId = Convert.ToInt32(Session["UserID"]);
            int productId = Convert.ToInt32(Request.QueryString["pid"]);
            int soLuong = int.Parse(txtSoLuong.Text);
            string ten = txtTen.Text.Trim();
            string sdt = txtSdt.Text.Trim();
            string email = txtEmail.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = @"INSERT INTO DonHang(UserID, CustomerName, Phone, Email, ProductID, Quantity, Price, Size, OrderDate)
               SELECT @userId, @ten, @sdt, @email, ProductID, @qty, Price, @size, GETDATE()
               FROM Products WHERE ProductID=@pid";

                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@userId", userId);
                cmd.Parameters.AddWithValue("@ten", ten);
                cmd.Parameters.AddWithValue("@sdt", sdt);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@pid", productId);
                cmd.Parameters.AddWithValue("@qty", soLuong);
                cmd.Parameters.AddWithValue("@size", size ?? (object)DBNull.Value);
                cmd.ExecuteNonQuery();

            }

            ClientScript.RegisterStartupScript(this.GetType(),
         "alert", "alert('Đặt hàng thành công!'); setTimeout(function(){ window.location='SanPham.aspx'; }, 3000);", true);

        }
    }
}
