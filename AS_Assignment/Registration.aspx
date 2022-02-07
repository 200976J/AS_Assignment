<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="AS_Assignment.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
            Registration
            <br />
            <br />
            <asp:Label ID="fn_Lb" runat="server" Text="First Name:"></asp:Label>
            <asp:TextBox ID="Fn_TxtBox" runat="server" style="margin-left: 15px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="First name required" ForeColor="Red" ControlToValidate="Fn_TxtBox"></asp:RequiredFieldValidator>
        </div>
        <asp:Label ID="ln_Lb" runat="server" Text="Last Name:"></asp:Label>
        <asp:TextBox ID="Ln_TxtBox" runat="server" style="margin-left: 17px"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Last name required" ForeColor="Red" ControlToValidate="Ln_TxtBox"></asp:RequiredFieldValidator>
        <p>
            <asp:Label ID="Label1" runat="server" Text="Credit Card No:"></asp:Label>
            <asp:TextBox ID="Credit_TextBx" runat="server" style="margin-left: 17px" onkeyup="javascript:creditcardValidate()"  placeholder="xxxx xxxx xxxx xxxx"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Credit Card required" ForeColor="Red" ControlToValidate="Credit_TextBx"></asp:RequiredFieldValidator>
        </p>
        <p>
            <asp:Label ID="Credit_error" runat="server" Text="Hint"></asp:Label>
        </p>
        <asp:Label ID="Label2" runat="server" Text="Email:"></asp:Label>
        <asp:TextBox ID="Email_TxtBox" runat="server" style="margin-left: 22px" TextMode="Email"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Email required" ForeColor="Red" ControlToValidate="Email_TxtBox"></asp:RequiredFieldValidator>
        <p>
            <asp:Label ID="Label3" runat="server" Text="Password:"></asp:Label>
            <asp:TextBox ID="pwd_txtBox" runat="server" style="margin-left: 14px" onkeyup="javascript:validate()" TextMode ="Password"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Password required" ForeColor="Red" ControlToValidate="pwd_txtBox"></asp:RequiredFieldValidator>
        </p>
        <p>
            <asp:Label ID="lbl_pwdchecker" runat="server" Text="Hints" EnableViewState="False"></asp:Label>
        </p>
        <asp:Label ID="Label4" runat="server" Text="Date of Birth:"></asp:Label>
        
&nbsp;<asp:TextBox ID="dob_txtBox" runat="server" TextMode="Date"></asp:TextBox>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Date required" ForeColor="Red" ControlToValidate="dob_txtBox"></asp:RequiredFieldValidator>
        <p>
            <asp:Label ID="Label5" runat="server" Text="Upload Photo:"></asp:Label>
        </p>
        <asp:FileUpload runat="server" ID="image_upload" Width="297px"/>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Photo required" ForeColor="Red" ControlToValidate="image_upload"></asp:RequiredFieldValidator>
        <br />
        <br />
        <asp:Button ID="Submit_btn" runat="server" Text="Register" Height="46px" Width="203px" OnClick="Submit_Click" />
        <p>
        <asp:Label ID="lbl_error" runat="server" Text="Password Status" EnableViewState="False"></asp:Label>
        </p>
       
    <script type="text/javascript">

        function creditcardValidate() {
            var card = document.getElementById('<%=Credit_TextBx.ClientID %>').value;

            if (card.search(/^4[0-9]{12}(?:[0-9]{3})?$/) == -1) {
                document.getElementById("Credit_error").innerHTML = "Credit card format wrong";
                document.getElementById("Credit_error").style.color = "Red";
                return ("not_credit");
            }
            else {
                document.getElementById("Credit_error").innerHTML = "Excellent";
                document.getElementById("Credit_error").style.color = "Blue";
            }

        }
       
        function validate() {
            var str = document.getElementById('<%=pwd_txtBox.ClientID %>').value;

            
            if (str.length < 12) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password Length must be at least 12 Characters";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("too_short");
            }

            if (str.search(/[0-9]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 number";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_number");
            }

            if (str.search(/[a-z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 lowercase letter";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_lowercase");
            }

            if (str.search(/[A-Z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 uppercase letter";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_uppercase");
            }

            if (str.search(/[?!.*\s]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 special character";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_uppercase");
            }

            else {
                document.getElementById("lbl_pwdchecker").innerHTML = "";
            }




        }

    </script>

        <p>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="pwd_txtBox" ErrorMessage="Password Complexity - Weak" ValidationExpression="^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^a-zA-Z0-9])(?!.*\s).{12,15}"></asp:RegularExpressionValidator>
        </p>
    </form>

    </body>
</html>

