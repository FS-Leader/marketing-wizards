<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="checkout.aspx.cs" Inherits="WebApplication8.Checkout" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Checkout - RKLUXfeet</title>
    <link rel="stylesheet" href="tmp/styles.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2 class="section-title">Checkout</h2>
            <asp:Repeater ID="rptOrder" runat="server">
                <HeaderTemplate>
                    <table class="admin-table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Brand</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("ShoeName") %></td>
                        <td><%# Eval("Brand") %></td>
                        <td>₹<%# Eval("Price", "{0:N2}") %></td>
                        <td><%# Eval("Quantity") %></td>
                        <td>₹<%# (Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity"))).ToString("N2") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                        </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <div style="margin:16px 0;">
                <h3>Order Total: ₹<asp:Label ID="lblOrderTotal" runat="server" /></h3>
            </div>
            <div>
                <h4>Shipping Address</h4>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-input" TextMode="MultiLine" Rows="3" Width="100%" />
            </div>
            <div style="margin:16px 0;">
                <h4>Payment Method</h4>
                <asp:RadioButtonList ID="rblPayment" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Debit/Credit Card" Value="Card" />
                    <asp:ListItem Text="Online (UPI)" Value="UPI" />
                    <asp:ListItem Text="Cash on Delivery" Value="COD" />
                </asp:RadioButtonList>
            </div>
            <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" CssClass="btn btn-primary" OnClick="btnPlaceOrder_Click" />
            <asp:Label ID="lblMsg" runat="server" CssClass="message-success" />
        </div>
    </form>
</body>
</html>

