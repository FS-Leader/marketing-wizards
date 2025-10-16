using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;

namespace WebApplication8
{
    public partial class AdminOrders : System.Web.UI.Page
    {
        string conStr = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindOrders();
        }

        private void BindOrders()
        {
            DataTable dtOrders = new DataTable();
            using (SqlConnection con = new SqlConnection(conStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM order_tbl ORDER BY order_id DESC", con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dtOrders);
                    }
                }
            }

            // Add OrderItems column to dtOrders if not exists (before the loop)
            if (!dtOrders.Columns.Contains("OrderItems"))
                dtOrders.Columns.Add("OrderItems", typeof(object));

            // For each order, fetch its items
            foreach (DataRow order in dtOrders.Rows)
            {
                DataTable dtItems = new DataTable();
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT oi.*, s.Brand FROM order_item oi LEFT JOIN shoes s ON oi.product_id = s.ShoeID WHERE oi.order_id=@order_id", con))
                    {
                        cmd.Parameters.AddWithValue("@order_id", order["order_id"]);
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            da.Fill(dtItems);
                        }
                    }
                }
                order["OrderItems"] = dtItems; // Use the correct column name
            }

            rptOrders.DataSource = dtOrders;
            rptOrders.DataBind();
        }


        protected void rptOrders_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "DeleteItem")
            {
                int orderItemId = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    using (SqlCommand cmd = new SqlCommand("DELETE FROM order_item WHERE order_item_id=@id", con))
                    {
                        cmd.Parameters.AddWithValue("@id", orderItemId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                lblMsg.Text = "Order item deleted.";
                BindOrders();
            }
        }
    }
}
