using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace BaiTapLTW
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                // Lấy cả UserID và Role
                string sql = "SELECT UserID, Role FROM Users WHERE Username=@user AND Password=@pass";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@user", username);
                cmd.Parameters.AddWithValue("@pass", password);

                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    int userId = reader.GetInt32(0);
                    string role = reader.GetString(1);

                    // Lưu vào Session
                    Session["UserName"] = username;
                    Session["LoggedUser"] = userId;
                    Session["UserRole"] = role;

                    // Điều hướng theo role
                    if (role == "admin")
                        Response.Redirect("../Admin/Admin.aspx");
                    else
                        Response.Redirect("../TrangChu/Home.aspx");
                }
                else
                {
                    lblMessage.Text = "Tên đăng nhập hoặc mật khẩu không đúng!";
                }
            }
        }
    }
}
