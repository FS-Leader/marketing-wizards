using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication8
{
    public partial class Shoes : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindShoes();
            }
        }

        private void BindShoes()
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM shoes", con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        // Filter for Men
                        DataView dvMen = new DataView(dt);
                        dvMen.RowFilter = "Category = 'Men'";
                        rptMenShoes.DataSource = dvMen;
                        rptMenShoes.DataBind();

                        // Filter for Women
                        DataView dvWomen = new DataView(dt);
                        dvWomen.RowFilter = "Category = 'Women'";
                        Repeater1.DataSource = dvWomen;
                        Repeater1.DataBind();
                    }
                }
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            int productId = Convert.ToInt32((sender as System.Web.UI.WebControls.Button).CommandArgument);

            // Fetch product details from DB
            DataTable dt = new DataTable();
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM shoes WHERE ShoeID=@ShoeID", con))
                {
                    cmd.Parameters.AddWithValue("@ShoeID", productId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
            }
            if (dt.Rows.Count == 0) return;
            DataRow dr = dt.Rows[0];

            // Get or create cart
            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null)
            {
                cart = new DataTable();
                cart.Columns.Add("ProductID", typeof(int));
                cart.Columns.Add("ShoeName", typeof(string));
                cart.Columns.Add("Brand", typeof(string));
                cart.Columns.Add("Price", typeof(decimal));
                cart.Columns.Add("Quantity", typeof(int));
                cart.Columns.Add("ImagePath", typeof(string));
            }

            // Check if already in cart
            DataRow[] found = cart.Select("ProductID=" + productId);
            if (found.Length > 0)
                found[0]["Quantity"] = Convert.ToInt32(found[0]["Quantity"]) + 1;
            else
                cart.Rows.Add(
                    dr["ShoeID"],
                    dr["ShoeName"],
                    dr["Brand"],
                    dr["Price"],
                    1,
                    dr["ImagePath"]
                );

            Session["Cart"] = cart;
            // Redirect to cart page
            Response.Redirect("cart.aspx");
        }
    }
}
