<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication8.Login" %>

<!doctype html>
<html lang="en">
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Login</title>
  <style>
    body {
      background: #f8f9fb;
      font-family: "Segoe UI", Roboto, sans-serif;
      color: #2d3748;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .card-auth {
      background: #fff;
      border-radius: 16px;
      padding: 50px;
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
      width: 100%;
      max-width: 420px;
      text-align: center; /* center all text inside */
    }

    h1 {
      color: #1a202c;
      font-weight: 700;
      margin-bottom: 0.5rem;
    }

    .help {
      color: #718096;
      font-size: 0.95rem;
      margin-bottom: 1.5rem;
    }

    .form-label {
      font-weight: 600;
      color: #2d3748;
      margin-bottom: 6px;
      display: block;
      text-align: center; /* center labels */
    }

    .form-control {
      background: #fff;
      border: 1px solid #d1d5db;
      border-radius: 10px;
      padding: 14px 16px;
      font-size: 0.95rem;
      color: #2d3748;
      transition: all 0.2s ease-in-out;
      box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);
      width: 80%;
      max-width: 300px;
      margin: 0 auto 15px;
      display: block;
      text-align: center;
    }
    .form-control:focus {
      border-color: #e74c3c;
      box-shadow: 0 0 0 4px rgba(231, 76, 60, 0.15);
      outline: none;
    }

    .btn-accent {
      background: linear-gradient(90deg, #e74c3c, #e43c2f);
      color: #fff !important;
      font-weight: 600;
      border: none;
      border-radius: 30px;
      padding: 14px;
      transition: all 0.2s ease-in-out;
      width: 80%;
      max-width: 300px;
      margin: 10px auto 0;
      display: block;
      cursor: pointer;
    }
    .btn-accent:hover {
      background: linear-gradient(90deg, #d84333, #c23328);
      box-shadow: 0 6px 16px rgba(231, 76, 60, 0.35);
      transform: translateY(-1px);
    }

    .auth-footer {
      text-align: center;
      color: #666;
      margin-top: 20px;
      font-size: 0.95rem;
    }

    .auth-link {
      color: #e74c3c;
      text-decoration: none;
      font-weight: 500;
    }
    .auth-link:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="card-auth">
      <div class="mb-3 text-center brand">RKLUXfeet<span class="accent">.</span></div>
      <h1 class="h4 fw-bold mb-1">Sign in</h1>
      <p class="help mb-4">Access reservations and orders.</p>

      <asp:Label ID="lblMsg" runat="server" CssClass="mb-2 d-block"></asp:Label>

      <div>
        <label class="form-label">Email</label>
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
      </div>

      <div>
        <label class="form-label">Password</label>
        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
      </div>

      <asp:Button ID="btnSubmit" runat="server" Text="Sign in" CssClass="btn-accent" OnClick="btnSubmit_Click" />

      <hr class="my-4 border-secondary" />
      <p class="mb-0 auth-footer">
        New here?
        <a class="auth-link" href="register.aspx">Create account</a>
      </p>
    </div>
  </form>
</body>
</html>
