<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="shoes.aspx.cs" Inherits="WebApplication8.Shoes" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Shoes - RKLUXfeet</title>
    <style>body {
    background: #f7f7fa;
    font-family: 'Poppins', Arial, sans-serif;
    margin: 0;
    padding: 0;
}
.container {
    max-width: 1200px;
    margin: 40px auto;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 16px rgba(0,0,0,0.08);
    padding: 32px 24px;
}
.section-title {
    font-size: 2rem;
    font-weight: 600;
    margin-bottom: 32px;
    color: #222;
    text-align: left;
}
.products-grid {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 32px;
    margin-bottom: 40px;
    justify-items: center;
}
.shoe-card {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 16px rgba(0,0,0,0.08);
    padding: 24px 18px 18px 18px;
    width: 100%;
    max-width: 260px;
    text-align: center;
    display: flex;
    flex-direction: column;
    align-items: center;
    transition: box-shadow 0.2s;
    position: relative;
}
.shoe-card:hover {
    box-shadow: 0 4px 24px rgba(0,0,0,0.13);
}
.shoe-card img {
    width: 120px;
    height: 120px;
    object-fit: cover;
    border-radius: 8px;
    margin-bottom: 14px;
    background: #f1f1f1;
}
.shoe-card b {
    font-size: 1.1rem;
    color: #222;
}
.shoe-card div {
    margin-bottom: 6px;
}
.shoe-card .aspNet-Button, .shoe-card input[type="submit"], .shoe-card button {
    margin-top: 10px;
    background: #e74c3c;
    color: #fff;
    border: none;
    border-radius: 4px;
    padding: 8px 20px;
    font-weight: 500;
    cursor: pointer;
    font-size: 1rem;
    transition: background 0.2s;
}
.shoe-card .aspNet-Button:hover, .shoe-card input[type="submit"]:hover, .shoe-card button:hover {
    background: #c0392b;
}
@media (max-width: 900px) {
    .products-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 20px;
    }
    .shoe-card {
        max-width: 200px;
        padding: 16px 8px 12px 8px;
    }
    .shoe-card img {
        width: 90px;
        height: 90px;
    }
}
@media (max-width: 600px) {
    .container {
        padding: 10px 2vw;
    }
    .products-grid {
        grid-template-columns: 1fr;
        gap: 16px;
    }
    .shoe-card {
        max-width: 320px;
        margin: 0 auto;
    }
}

</style>
    <link rel="stylesheet" href="tmp/styles.css" />
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>
     <header class="header">
     <div class="container">
         <div class="nav-brand">
             <h1 class="logo">RKLUXfeet</h1>
         </div>
         <nav class="nav-menu">
             <ul class="nav-list">
                 <li><a href="index.aspx" class="nav-link">Home</a></li>
                 <li><a href="shoes.aspx" class="nav-link">Shoes</a></li>
                  <li><a href="about.aspx" class="nav-link active">About Us</a></li>
                  <li><a href="contact.aspx" class="nav-link">Contact</a></li>
             </ul>
         </nav>
         <div class="nav-actions">
             <a href="register.aspx" class="nav-action"><i class="fas fa-user-plus"></i> Register</a>
             <a href="login.aspx" class="nav-action"><i class="fas fa-sign-in-alt"></i> Login</a>
             <a href="logout.aspx" class="nav-action"><i class="fas fa-sign-out-alt"></i> Logout</a>
             <a href="cart.aspx" class="nav-action cart-icon"><i class="fas fa-shopping-cart"></i> Cart</a>
         </div>
     </div>
 </header>
    <form id="form1" runat="server">
       <div class="container">
    <h2 class="section-title" style="text-align:center;">Men's Shoes</h2>
    <div class="products-grid">
        <asp:Repeater ID="rptMenShoes" runat="server">
            <ItemTemplate>
                <div class="shoe-card">
                    <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' alt='<%# Eval("ShoeName") %>' />
                    <div><b><%# Eval("ShoeName") %></b></div>
                    <div>Brand: <%# Eval("Brand") %></div>
                    <div>₹<%# Eval("Price") %></div>
                    <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart"
                        CommandArgument='<%# Eval("ShoeID") %>' OnClick="btnAddToCart_Click" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <h2 class="section-title" style="text-align:center;">Women's Shoes</h2>
    <div class="products-grid">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <div class="shoe-card">
                    <img src='<%# ResolveUrl(Eval("ImagePath").ToString()) %>' alt='<%# Eval("ShoeName") %>' />
                    <div><b><%# Eval("ShoeName") %></b></div>
                    <div>Brand: <%# Eval("Brand") %></div>
                    <div>₹<%# Eval("Price") %></div>
                    <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart"
                        CommandArgument='<%# Eval("ShoeID") %>' OnClick="btnAddToCart_Click" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</div>

     </ItemTemplate>
 </asp:Repeater>


            </div>
        </div>
    </form>
      <!-- Footer -->
  <footer class="footer">
      <div class="container">
          <div class="footer-content">
              <div class="footer-section">
                  <h3>RKLUXfeet</h3>
                  <p>Premium footwear for the modern lifestyle</p>
              </div>
              <div class="footer-section">
                  <h4>Quick Links</h4>
                  <ul>
                      <li><a href="index.aspx">Home</a></li>
                      <li><a href="shoes.aspx">Shoes</a></li>
                      <li><a href="about.aspx">About Us</a></li>
                      <li><a href="contact.aspx">Contact</a></li>
                  </ul>
              </div>
             
              <div class="footer-section">
                  <h4>Contact Info</h4>
                  <p>📧 info@rkluxfeet.com</p>
                  <p>📞 +91 98765 43210</p>
                  <p>📍 123 Fashion Street, Mumbai</p>
              </div>
          </div>
          <div class="footer-bottom">
              <p>&copy; 2024 RKLUXfeet. All rights reserved.</p>
          </div>
      </div>
  </footer>
</body>
</html>
