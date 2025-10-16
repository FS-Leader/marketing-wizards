




<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admindas.aspx.cs" Inherits="WebApplication8.WebForm2" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Admin Dashboard - RKLUXfeet</title>
    <link rel="stylesheet" href="tmp/styles.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .admin-container { max-width: 900px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 16px rgba(0,0,0,0.08); padding: 32px; }
        .admin-title { font-size: 2rem; font-weight: 600; margin-bottom: 24px; color: #222; }
        .admin-form-row { display: flex; gap: 16px; margin-bottom: 16px; }
        .admin-form-group { flex: 1; display: flex; flex-direction: column; }
        .admin-form-group label { font-weight: 500; margin-bottom: 6px; }
        .admin-form-group input, .admin-form-group select { padding: 8px 10px; border: 1px solid #ccc; border-radius: 4px; }
        .admin-form-actions { margin-top: 12px; }
        .admin-table { width: 100%; border-collapse: collapse; margin-top: 32px; }
        .admin-table th, .admin-table td { padding: 10px 12px; border-bottom: 1px solid #eee; text-align: left; }
        .admin-table th { background: #f7f7f7; }
        .admin-table img { width: 60px; height: 60px; object-fit: cover; border-radius: 6px; }
        .btn { padding: 7px 18px; border: none; border-radius: 4px; font-weight: 500; cursor: pointer; }
        .btn-primary { background: #222; color: #fff; }
        .btn-danger { background: #e74c3c; color: #fff; }
        .btn-secondary { background: #f1f1f1; color: #222; }
        .message-success { color: #27ae60; font-weight: 500; }
        .message-error { color: #e74c3c; font-weight: 500; }
    </style>

</head>
<body>

    <form id="form1" runat="server">
        <div class="admin-container">
            <h2 class="admin-title">Admin Dashboard - Shoes</h2>
            <asp:Label ID="lblMessage" runat="server"></asp:Label>
            <div style="margin-bottom:32px;">
                <h3 style="margin-bottom:16px;">Add New Shoe</h3>
              <div class="admin-form-row">
    <div class="admin-form-group">
        <label for="txtShoeName">Shoe Name</label>
        <asp:TextBox ID="txtShoeName" runat="server" CssClass="form-input" />
    </div>
    <div class="admin-form-group">
        <label for="ddlCategory">Category</label>
        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-input">
            <asp:ListItem Text="Men" Value="Men" />
            <asp:ListItem Text="Women" Value="Women" />
        </asp:DropDownList>
    </div>
    <div class="admin-form-group">
        <label for="txtBrand">Brand</label>
        <asp:TextBox ID="txtBrand" runat="server" CssClass="form-input" />
    </div>
    <div class="admin-form-group">
        <label for="txtPrice">Price (₹)</label>
        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-input" />
    </div>
    <div class="admin-form-group">
        <label for="fuImage">Image</label>
        <asp:FileUpload ID="fuImage" runat="server" CssClass="form-input" />
    </div>
</div>

                <div class="admin-form-actions">
                    <asp:Button ID="btnAdd" runat="server" Text="Add Product" CssClass="btn btn-primary" OnClick="btnAdd_Click" />
                </div>
            </div>
            <h3 style="margin-bottom:16px;">All Shoes</h3>
            <asp:GridView ID="gvShoes" runat="server" AutoGenerateColumns="False" DataKeyNames="ShoeID"
                CssClass="admin-table"
                OnRowEditing="gvShoes_RowEditing"
                OnRowUpdating="gvShoes_RowUpdating"
                OnRowCancelingEdit="gvShoes_RowCancelingEdit"
                OnRowDeleting="gvShoes_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="ShoeID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="ShoeName" HeaderText="Name" />
                    <asp:BoundField DataField="Category" HeaderText="Category" />
                    <asp:BoundField DataField="Brand" HeaderText="Brand" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="₹{0:N2}" />
                    <asp:ImageField DataImageUrlField="ImagePath" HeaderText="Image" ControlStyle-Width="60px" ControlStyle-Height="60px" />
                    <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" />
                </Columns>
            </asp:GridView>
        </div>
       
    </form>
</body>
</html>
