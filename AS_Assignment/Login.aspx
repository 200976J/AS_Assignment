<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AS_Assignment.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="https://www.google.com/recaptcha/api.js?render=6LeNB0QeAAAAALY62NcoC6KetgKcl5sPxIOIzlNK"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <fieldset>
                <legend>Login</legend>
                <br />
                <p>Email : <asp:TextBox ID="tb_email" runat="server" Height="25px" Width="137px" /> </p>
                <p>Password : <asp:TextBox ID="tb_pwd" runat="server" Height="25px" Width="137px" TextMode="Password" /> </p>
                <p><asp:Button ID="btnSubmit" runat="server" Text="Login" OnClick="LoginMe" Height="27px" Width="133px" /> </p>
           
                <br />
                <br />
                <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
                
                <asp:Label ID="lblMessage" runat="server" >Error message here (lblMessage)</asp:Label>
                
            </fieldset>
        </div>
    </form>
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute(' 6LeNB0QeAAAAALY62NcoC6KetgKcl5sPxIOIzlNK ', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });

    </script>
</body>
</html>
