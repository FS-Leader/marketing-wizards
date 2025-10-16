<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="cart.aspx.cs" Inherits="WebApplication8.Cart" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Shopping Cart - RKLUXfeet</title>
    <style>
        .cart-item {
    display: flex;
    align-items: center;
    gap: 16px;
    margin-bottom: 16px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    padding: 16px;
}
.cart-item img {
    width: 80px;
    height: 80px;
    object-fit: cover;
    border-radius: 8px;
}
.cart-item span {
    flex: 1;
}
.cart-item .aspNet-Button, .cart-item input[type="submit"] {
    background: #e74c3c;
    color: #fff;
    border: none;
    border-radius: 50%;
    width: 36px;
    height: 36px;
    font-size: 1.2rem;
    cursor: pointer;
}
.cart-item .aspNet-Button:hover, .cart-item input[type="submit"]:hover {
    background: #c0392b;
}
.cart-summary {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 16px rgba(0,0,0,0.08);
    padding: 32px;
    margin-top: 32px;
}
+
    </style>
    <link rel="stylesheet" href="tmp/styles.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
        <div class="container" style="margin-top:40px;">
            <h2>Your Cart</h2>
            <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
                <ItemTemplate>
                    <div class="cart-item" style="display:flex;align-items:center;gap:16px;margin-bottom:16px;">
                      <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' alt='<%# Eval("ShoeName") %>' style="width:80px;" /><img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' alt='<%# Eval("ShoeName") %>' style="width:80px;" />
                        <span><b><%# Eval("ShoeName") %></b> (<%# Eval("Brand") %>)</span>
                        <span>Qty: <%# Eval("Quantity") %></span>
                        <span>₹<%# Eval("Price") %></span>
                        <asp:Button ID="btnDelete" runat="server" Text="Delete"
                            CommandName="DeleteItem"
                            CommandArgument='<%# Eval("ProductID") %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <hr />
            <div>
                <b>Total Shoes:</b> <asp:Label ID="lblCartCount" runat="server" />
                <br />
                <b>Subtotal:</b> ₹<asp:Label ID="lblSubtotal" runat="server" />
                <br />
                <b>GST (5%):</b> ₹<asp:Label ID="lblTax" runat="server" />
                <br />
                <b>Total:</b> ₹<asp:Label ID="lblTotal" runat="server" />
                <br />
                <b>Shipping:</b> <span style="color:green;">FREE</span>
            </div>
            <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" CssClass="btn btn-primary" OnClick="btnCheckout_Click" />

            <asp:Button ID="btnClearCart" runat="server" Text="Clear Cart" OnClick="btnClearCart_Click" />
        </div>
    </form>
</body>
</html>
