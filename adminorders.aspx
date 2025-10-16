<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="adminorders.aspx.cs" Inherits="WebApplication8.AdminOrders" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Admin Orders - RKLUXfeet</title>
    <link rel="stylesheet" href="tmp/styles.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .admin-orders-container { max-width: 1100px; margin: 40px auto; background: #fff; border-radius: 10px; box-shadow: 0 2px 16px rgba(0,0,0,0.08); padding: 32px; }
        .order-block { border-bottom: 1px solid #eee; margin-bottom: 32px; padding-bottom: 24px; }
        .order-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px; }
        .order-id { font-weight: 600; font-size: 1.1rem; }
        .order-status { font-weight: 500; color: #27ae60; }
        .order-items-list { }
        .order-item-card { display: flex; align-items: center; margin-bottom: 18px; }
        .order-item-image img { width: 80px; height: 80px; object-fit: cover; border-radius: 8px; }
        .order-item-info { margin-left: 18px; flex: 1; }
        .order-item-name { font-weight: 600; font-size: 1.1rem; }
        .order-item-brand { color: #888; font-size: 0.95rem; }
        .order-item-price { color: #e74c3c; font-weight: 600; font-size: 1.1rem; }
        .order-item-qty { margin-left: 16px; }
        .order-item-delete { margin-left: 24px; }
        .btn-delete { background: #e74c3c; color: #fff; border: none; border-radius: 50%; width: 36px; height: 36px; font-size: 1.2rem; cursor: pointer; }
        .order-summary { margin-top: 10px; font-weight: 500; }
        .order-address, .order-payment { font-size: 0.98rem; color: #444; margin-top: 4px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-orders-container">
            <h2 class="admin-title">Order Management</h2>
            <asp:Label ID="lblMsg" runat="server" />
            <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
                <ItemTemplate>
                    <div class="order-block">
                        <div class="order-header">
                            <span class="order-id">Order #<%# Eval("order_id") %> | <span style="font-weight:400;">Date:</span> <%# Eval("order_date") %></span>
                            <span class="order-status"><%# Eval("order_status") %></span>
                        </div>
                        <div class="order-address"><b>Shipping:</b> <%# Eval("shipping_address") %></div>
                        <div class="order-payment"><b>Payment:</b> <%# Eval("payment_method") %></div>
                        <div class="order-items-list">
                            <asp:Repeater ID="rptOrderItems" runat="server" DataSource='<%# Eval("OrderItems") %>'>
                                <ItemTemplate>
                                    <div class="order-item-card">
                                        <div class="order-item-image">
                                            <img src='<%# ResolveUrl(Eval("image") as string) %>' alt='<%# Eval("product_name") %>' />
                                        </div>
                                        <div class="order-item-info">
                                            <div class="order-item-name"><%# Eval("product_name") %></div>
                                            <div class="order-item-brand">Brand: <%# Eval("brand") %></div>
                                            <div class="order-item-price">₹<%# Eval("price", "{0:N2}") %></div>
                                            <div class="order-item-qty">Qty: <%# Eval("quantity") %></div>
                                        </div>
                                        <div class="order-item-delete">
                                            <asp:Button ID="btnDelete" runat="server" CssClass="btn-delete" Text="&#128465;" CommandName="DeleteItem" CommandArgument='<%# Eval("order_item_id") %>' ToolTip="Delete Item" />
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                        <div class="order-summary">
                            Total: ₹<%# Eval("total_amount", "{0:N2}") %>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </form>
</body>
</html>
