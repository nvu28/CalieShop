using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace BaiTapCuoiKy
{
    public partial class QuanLySP : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedUser"] == null || Session["UserRole"].ToString() != "admin")
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                LoadSanPham();
            }
        }

        private void LoadSanPham()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT ProductID, Name, Price, ImagePath FROM Products";
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                rptSanPham.DataSource = dt;
                rptSanPham.DataBind();
            }
        }

        protected void btnThem_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = "INSERT INTO Products (Name, Price, ImagePath) VALUES (@Name, @Price, @ImagePath)";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Name", txtTenSP.Text.Trim());
                cmd.Parameters.AddWithValue("@Price", decimal.Parse(txtGia.Text.Trim()));
                cmd.Parameters.AddWithValue("@ImagePath", txtHinhAnh.Text.Trim());

                cmd.ExecuteNonQuery();
            }
            LoadSanPham();
        }

        protected void btnSua_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = "UPDATE Products SET Name=@Name, Price=@Price ,ImagePath=@ImagePath WHERE ProductID=@ProductID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@ProductID", txtMaSP.Text.Trim());
                cmd.Parameters.AddWithValue("@Name", txtTenSP.Text.Trim());
                cmd.Parameters.AddWithValue("@Price", decimal.Parse(txtGia.Text.Trim()));
                cmd.Parameters.AddWithValue("@ImagePath", txtHinhAnh.Text.Trim());


                cmd.ExecuteNonQuery();
            }
            LoadSanPham();
        }

        protected void btnXoa_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                string sql = "DELETE FROM Products WHERE ProductID=@ProductID";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@ProductID", txtMaSP.Text.Trim());

                cmd.ExecuteNonQuery();
            }
            LoadSanPham();
        }

        protected void rptSanPham_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Chon")
            {
                string maSP = e.CommandArgument.ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    string sql = "SELECT ProductID, Name, Price, ImagePath FROM Products WHERE ProductID=@ProductID";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@ProductID", maSP);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        txtMaSP.Text = reader["ProductID"].ToString();
                        txtTenSP.Text = reader["Name"].ToString();
                        txtHinhAnh.Text = reader["ImagePath"].ToString();
                        txtGia.Text = reader["Price"].ToString();
                    }
                }
            }
        }
    }
}
