using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BaiTapLTW
{
    public partial class Home : System.Web.UI.Page
    {
        protected bool isLoggedIn = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedUser"] != null)
            {
                isLoggedIn = true;
            }
        }
    }
}