using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using System.Data.SqlClient;
using System.Configuration;

namespace BaiTapLTW
{
    public partial class SanPham : System.Web.UI.Page
    {
        protected bool isLoggedIn = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedUser"] != null) 
            {
                isLoggedIn = true;
            }
            if (!IsPostBack)
            {
                string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = "SELECT ProductID, Name, Price, ImagePath FROM Products";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    conn.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    rptProducts.DataSource = dr;
                    rptProducts.DataBind();
                }
            }
        }
        protected void btnAddToCart_Command(object sender, CommandEventArgs e)
        {
            if (Session["LoggedUser"] == null)
            {
                Response.Redirect("../DangNhap/Login.aspx");
                return;
            }
            int userId = (int)Session["LoggedUser"];
            int productId = Convert.ToInt32(e.CommandArgument);

            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Kiểm tra sản phẩm đã có trong giỏ chưa
         
                string checkSql = "SELECT Quantity FROM Cart WHERE ProductID = @id";
                SqlCommand checkCmd = new SqlCommand(checkSql, conn);
                checkCmd.Parameters.AddWithValue("@id", productId);

                object result = checkCmd.ExecuteScalar();

                if (result != null)
                {
                    string updateSql = "UPDATE Cart SET Quantity = Quantity + 1 WHERE UserID=@uid AND ProductID=@pid";
                    SqlCommand updateCmd = new SqlCommand(updateSql, conn);
                    updateCmd.Parameters.AddWithValue("@uid", userId);
                    updateCmd.Parameters.AddWithValue("@pid", productId);
                    updateCmd.ExecuteNonQuery();
                }
                else
                {
                    string insertSql = "INSERT INTO Cart (UserID, ProductID, Quantity) VALUES (@uid, @pid, 1)";
                    SqlCommand insertCmd = new SqlCommand(insertSql, conn);
                    insertCmd.Parameters.AddWithValue("@uid", userId);
                    insertCmd.Parameters.AddWithValue("@pid", productId);
                    insertCmd.ExecuteNonQuery();
                }
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(),
       "alert", "alert('Đã thêm sản phẩm vào giỏ hàng thành công!');", true);


        }

    }
}