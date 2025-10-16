using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication8
{
    public partial class Login : System.Web.UI.Page
    {
        string s = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        SqlConnection con;
        SqlCommand cmd;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void clear()
        {
            txtEmail.Text = "";
            txtPassword.Text = "";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session.Clear();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtEmail.Text) || string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblMsg.Text = "Enter email and password.";
                lblMsg.CssClass = "text-danger";
                return;
            }

            try
            {
                getcon();

                cmd = new SqlCommand("SELECT Id, Name FROM dbo.Users WHERE Email=@Email AND Password=@Password", con);
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Text);

                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        Session["UserId"] = rdr.GetInt32(0);
                        Session["Name"] = rdr.GetString(1);
                        Session["Email"] = txtEmail.Text.Trim();

                        Response.Redirect("index.aspx");
                    }
                    else
                    {
                        lblMsg.Text = "Invalid email or password.";
                        lblMsg.CssClass = "text-danger";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
                lblMsg.CssClass = "text-danger";
            }
            finally
            {
                if (con != null && con.State == ConnectionState.Open)
                {
                    con.Close();
                }
            }
        }
    }
}
