<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TestManualPostback.aspx.vb" Inherits="FrmLogEvent.TestManualPostback"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>WebForm2</title>
		<meta content="Microsoft Visual Studio.NET 7.0" name="GENERATOR">
		<meta content="Visual Basic 7.0" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body onload="initTextbox()" MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:textbox id="txtTestManualPostback" style="Z-INDEX: 101; LEFT: 265px; POSITION: absolute; TOP: 48px" runat="server" Width="189px" Height="23px"></asp:textbox>
			<asp:RegularExpressionValidator id="RegularExpressionValidator1" style="Z-INDEX: 102; LEFT: 50px; POSITION: absolute; TOP: 142px" runat="server" Width="122px" Height="25px" ErrorMessage="RegularExpressionValidator" ControlToValidate="txtRegExValidate" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"></asp:RegularExpressionValidator>
			<asp:TextBox id="txtRegExValidate" style="Z-INDEX: 103; LEFT: 292px; POSITION: absolute; TOP: 137px" runat="server" Width="164px" Height="30px" AutoPostBack="True"></asp:TextBox></form>
	</body>
</HTML>
