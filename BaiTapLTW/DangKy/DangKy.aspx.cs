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
    public partial class DangKy : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirm = txtConfirm.Text.Trim();

            if (password != confirm)
            {
                lblMessage.Text = "Mật khẩu xác nhận không khớp!";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Kiểm tra username đã tồn tại chưa
                string checkSql = "SELECT COUNT(*) FROM Users WHERE Username=@user";
                SqlCommand checkCmd = new SqlCommand(checkSql, conn);
                checkCmd.Parameters.AddWithValue("@user", username);
                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    lblMessage.Text = "Tên đăng nhập đã tồn tại!";
                }
                else
                {
                    // Thêm mới user với Role mặc định là 'user'
                    string insertSql = "INSERT INTO Users (Username, Password, Role) VALUES (@user, @pass, 'user')";
                    SqlCommand insertCmd = new SqlCommand(insertSql, conn);
                    insertCmd.Parameters.AddWithValue("@user", username);
                    insertCmd.Parameters.AddWithValue("@pass", password); // thực tế nên mã hóa mật khẩu

                    int rows = insertCmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                        lblMessage.Text = "Đăng ký thành công! Vui lòng đăng nhập.";
                        Response.Redirect("../DangNhap/Login.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Có lỗi xảy ra, vui lòng thử lại.";
                    }
                }
            }
        }
    }
}