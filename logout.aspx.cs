using System;
using System.Web.UI;

namespace WebApplication8
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Clear();   
            Session.Abandon(); 

            lblMsg.Text = "You have been logged out.";
            lblMsg.CssClass = "text-success";

            Response.AddHeader("REFRESH", "0.1;URL=login.aspx");
        }
    }
}
