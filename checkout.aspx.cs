using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication8
{
    public partial class Checkout : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindOrder();
        }

        private void BindOrder()
        {
            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null) return;
            rptOrder.DataSource = cart;
            rptOrder.DataBind();

            decimal total = 0;
            foreach (DataRow row in cart.Rows)
                total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);
            lblOrderTotal.Text = total.ToString("N2");
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            DataTable cart = Session["Cart"] as DataTable;
            if (cart == null || cart.Rows.Count == 0)
            {
                lblMsg.Text = "Cart is empty.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtAddress.Text))
            {
                lblMsg.Text = "Please enter shipping address.";
                return;
            }
            if (rblPayment.SelectedIndex == -1)
            {
                lblMsg.Text = "Please select a payment method.";
                return;
            }

            decimal total = 0;
            foreach (DataRow row in cart.Rows)
                total += Convert.ToDecimal(row["Price"]) * Convert.ToInt32(row["Quantity"]);

            // Save order
            int userId = 1; // Replace with actual logged-in user id
            string orderDate = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
            string status = "Placed";
            string address = txtAddress.Text.Trim();
            string payment = rblPayment.SelectedValue;

            int orderId = 0;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                // Insert order_tbl
                string sqlOrder = "INSERT INTO order_tbl (user_id, order_date, total_amount, order_status, shipping_address, payment_method) " +
                                  "OUTPUT INSERTED.order_id VALUES (@user_id, @order_date, @total_amount, @order_status, @shipping_address, @payment_method)";
                using (SqlCommand cmd = new SqlCommand(sqlOrder, con))
                {
                    cmd.Parameters.AddWithValue("@user_id", userId);
                    cmd.Parameters.AddWithValue("@order_date", orderDate);
                    cmd.Parameters.AddWithValue("@total_amount", total);
                    cmd.Parameters.AddWithValue("@order_status", status);
                    cmd.Parameters.AddWithValue("@shipping_address", address);
                    cmd.Parameters.AddWithValue("@payment_method", payment);
                    con.Open();
                    orderId = (int)cmd.ExecuteScalar();
                }

                // Insert order_item
                foreach (DataRow row in cart.Rows)
                {
                    string sqlItem = "INSERT INTO order_item (order_id, product_id, product_name, price, quantity, image) " +
                                     "VALUES (@order_id, @product_id, @product_name, @price, @quantity, @image)";
                    using (SqlCommand cmd = new SqlCommand(sqlItem, con))
                    {
                        cmd.Parameters.AddWithValue("@order_id", orderId);
                        cmd.Parameters.AddWithValue("@product_id", row["ProductID"]);
                        cmd.Parameters.AddWithValue("@product_name", row["ShoeName"]);
                        cmd.Parameters.AddWithValue("@price", row["Price"]);
                        cmd.Parameters.AddWithValue("@quantity", row["Quantity"]);
                        cmd.Parameters.AddWithValue("@image", row["ImagePath"]);
                        cmd.ExecuteNonQuery();
                    }
                }
            }

            // Clear cart and show success
            Session["Cart"] = null;
            lblMsg.Text = "Order placed successfully!";
        }
    }
}
