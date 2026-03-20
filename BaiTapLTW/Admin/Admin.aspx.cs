using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BaiTapLTW
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedUser"] == null || Session["UserRole"].ToString() != "admin")
            {
                Response.Redirect("../DangNhap/Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadDonHang();
            }
        }

        private void LoadDonHang()
        {
            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = @"SELECT d.OrderID, d.UserID, d.CustomerName, d.Phone, d.Email,
                      d.ProductID, p.Name AS TenSP,
                      d.Quantity, d.Price, d.Size, d.OrderDate,
                      (d.Quantity * d.Price) AS TongTien
               FROM DonHang d
               JOIN Products p ON d.ProductID = p.ProductID
               ORDER BY d.OrderDate DESC";

                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptDonHang.DataSource = dt;
                rptDonHang.DataBind();
            }
        }

        protected void rptDonHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int orderId = Convert.ToInt32(e.CommandArgument);
            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                if (e.CommandName == "xacnhan")
                {
                    string sql = "DELETE FROM DonHang WHERE OrderID=@id";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@id", orderId);
                    cmd.ExecuteNonQuery();
                    ScriptManager.RegisterStartupScript(this, this.GetType(),
                        "alert", "alert('Đơn hàng đã xác nhận!');", true);
                }
                else if (e.CommandName == "xoa")
                {
                    string sql = "DELETE FROM DonHang WHERE OrderID=@id";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@id", orderId);
                    cmd.ExecuteNonQuery();
                }
            }

            LoadDonHang(); // refresh lại danh sách
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear(); // xóa session
            Response.Redirect("../TrangChu/Home.aspx"); // quay về trang đăng nhập
        }

    }
}
