using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace WebApplication8
{
    public partial class WebForm2 : System.Web.UI.Page
    {
     
        string conStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        protected void BindGrid()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM shoes", con))
                    {
                        using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            da.Fill(dt);
                            gvShoes.DataSource = dt;
                            gvShoes.DataBind();
                        }
                    }
                }
                lblMessage.Text = "";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                string name = txtShoeName.Text.Trim();
                string category = ddlCategory.SelectedValue;
                decimal price = decimal.Parse(txtPrice.Text.Trim());
                string imagePath = "";

                if (fuImage.HasFile)
                {
                    string ext = Path.GetExtension(fuImage.FileName).ToLower();
                    if (ext != ".jpg" && ext != ".png" && ext != ".jpeg")
                    {
                        lblMessage.Text = "Only .jpg, .jpeg, .png files allowed.";
                        return;
                    }
                    string fileName = Guid.NewGuid().ToString() + ext;
                    string imagesFolder = "~/images/";
                    string savePath = Server.MapPath(imagesFolder + fileName);
                    fuImage.SaveAs(savePath);
                    imagePath = imagesFolder + fileName;

                }

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    string brand = txtBrand.Text.Trim();
                    string sql = "INSERT INTO shoes (ShoeName, Category, Brand, Price, ImagePath) VALUES (@ShoeName, @Category, @Brand, @Price, @ImagePath)";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@ShoeName", name);
                        cmd.Parameters.AddWithValue("@Category", category);
                        cmd.Parameters.AddWithValue("@Brand", brand);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@ImagePath", imagePath);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }

                }
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Product added successfully!";
                txtShoeName.Text = "";
                txtPrice.Text = "";
                BindGrid();
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        protected void gvShoes_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvShoes.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvShoes_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvShoes.EditIndex = -1;
            BindGrid();
        }

        protected void gvShoes_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvShoes.DataKeys[e.RowIndex].Value);
                string name = ((System.Web.UI.WebControls.TextBox)gvShoes.Rows[e.RowIndex].Cells[1].Controls[0]).Text;
                string category = ((System.Web.UI.WebControls.TextBox)gvShoes.Rows[e.RowIndex].Cells[2].Controls[0]).Text;
                string brand = ((System.Web.UI.WebControls.TextBox)gvShoes.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
                string priceStr = ((System.Web.UI.WebControls.TextBox)gvShoes.Rows[e.RowIndex].Cells[3].Controls[0]).Text;
                decimal price = decimal.Parse(priceStr);

                using (SqlConnection con = new SqlConnection(conStr))
                {
                    string sql = "UPDATE shoes SET ShoeName=@ShoeName, Category=@Category,Brand=@Brand, Price=@Price WHERE ShoeID=@ShoeID";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@ShoeName", name);
                        cmd.Parameters.AddWithValue("@Category", category);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@ShoeID", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                gvShoes.EditIndex = -1;
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Product updated successfully!";
                BindGrid();
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }

        protected void gvShoes_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(gvShoes.DataKeys[e.RowIndex].Value);
                using (SqlConnection con = new SqlConnection(conStr))
                {
                    string sql = "DELETE FROM shoes WHERE ShoeID=@ShoeID";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@ShoeID", id);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Product deleted successfully!";
                BindGrid();
            }
            catch (Exception ex)
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Error: " + ex.Message;
            }
        }
    }
}
