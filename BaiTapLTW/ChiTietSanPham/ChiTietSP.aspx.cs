using System;
using System.Data.SqlClient;
using System.Configuration;

namespace BaiTapLTW
{
    public partial class ChiTietSP : System.Web.UI.Page
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
                if (Request.QueryString["id"] != null)
                {
                    int productId = Convert.ToInt32(Request.QueryString["id"]);
                    LoadProductDetail(productId);
                }
            }
        }

        private void LoadProductDetail(int productId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT Name, Price, ImagePath FROM Products WHERE ProductID=@id";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@id", productId);
                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblName.Text = dr["Name"].ToString();
                    lblPrice.Text = ((decimal)dr["Price"]).ToString("N0") + " ₫";
                    imgProduct.ImageUrl = dr["ImagePath"].ToString();
                    lblProductID.Text = productId.ToString();
                    
                }
            }
        }


        // 👉 Xử lý nút "Thêm vào giỏ hàng"
        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["LoggedUser"] == null)
            {
                Response.Redirect("../DangNhap/Login.aspx");
                return;
            }

            int userId = (int)Session["UserID"];
            int productId = Convert.ToInt32(Request.QueryString["id"]);

            string connStr = ConfigurationManager.ConnectionStrings["BTLTWConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                string checkSql = "SELECT Quantity FROM Cart WHERE UserID=@uid AND ProductID=@pid";
                SqlCommand checkCmd = new SqlCommand(checkSql, conn);
                checkCmd.Parameters.AddWithValue("@uid", userId);
                checkCmd.Parameters.AddWithValue("@pid", productId);

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
                    string insertSql = "INSERT INTO Cart(UserID, ProductID, Quantity) VALUES(@uid, @pid, 1)";
                    SqlCommand insertCmd = new SqlCommand(insertSql, conn);
                    insertCmd.Parameters.AddWithValue("@uid", userId);
                    insertCmd.Parameters.AddWithValue("@pid", productId);
                    insertCmd.ExecuteNonQuery();
                }
            }

            ClientScript.RegisterStartupScript(this.GetType(),
                "alert", "alert('Đã thêm sản phẩm vào giỏ hàng!');", true);
        }

        // 👉 Xử lý nút "Mua ngay"
        protected void btnBuyNow_Click(object sender, EventArgs e)
        {
            string size = hfSize.Value;
            int productId = Convert.ToInt32(Request.QueryString["id"]);

            if (string.IsNullOrEmpty(size))
            {
                // Nếu chưa chọn size thì báo lỗi
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Vui lòng chọn size trước khi mua!');", true);
                return;
            }

            Response.Redirect("../GioHangNho/MiniCart.aspx?pid=" + productId + "&size=" + size);
        }

    }
}
