using System;
using System.Data;
using System.Web.UI.WebControls;

namespace WebApplication8
{
    public partial class Cart : System.Web.UI.Page
    {
        private DataTable GetCartData()
        {
            if (Session["Cart"] == null)
            {
                var dt = new DataTable();
                dt.Columns.Add("ProductID", typeof(int));
                dt.Columns.Add("ShoeName", typeof(string));
                dt.Columns.Add("Brand", typeof(string));
                dt.Columns.Add("Price", typeof(decimal));
                dt.Columns.Add("Quantity", typeof(int));
                dt.Columns.Add("ImagePath", typeof(string));
                Session["Cart"] = dt;
            }
            return (DataTable)Session["Cart"];
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindCart();
        }

        private void BindCart()
        {
            var dt = GetCartData();
            rptCart.DataSource = dt;
            rptCart.DataBind();

            int itemCount = 0;
            decimal subtotal = 0;
            foreach (DataRow row in dt.Rows)
            {
                int qty = Convert.ToInt32(row["Quantity"]);
                decimal price = Convert.ToDecimal(row["Price"]);
                subtotal += price * qty;
                itemCount += qty;
            }

            decimal gst = subtotal * 0.05m; // 5% GST
            decimal total = subtotal + gst;

            lblCartCount.Text = itemCount.ToString();
            lblSubtotal.Text = subtotal.ToString("N0");
            lblTax.Text = gst.ToString("N0");
            lblTotal.Text = total.ToString("N0");
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                var cart = GetCartData();
                DataRow[] found = cart.Select("ProductID=" + productId);
                if (found.Length > 0)
                    cart.Rows.Remove(found[0]);
                Session["Cart"] = cart;
                BindCart();
            }
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            Session["Cart"] = null;
            BindCart();
        }
        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("checkout.aspx");
        }

    }
}
