<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FrmStart.aspx.vb" Inherits="FrmLogEvent.FrmStart" errorPage="err_default.htm"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>FrmStart</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio.NET 7.0">
		<meta name="CODE_LANGUAGE" content="Visual Basic 7.0">
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
	</HEAD>
	<body MS_POSITIONING="GridLayout" oncontextmenu="return false">
		<form id="Form1" method="post" action="FrmLogEventList.aspx" target="logevent" onsubmit="window.open('logevent.htm','logevent','width=885,height=590', true)">
			<DIV style="DISPLAY: inline; Z-INDEX: 101; LEFT: 189px; WIDTH: 49px; POSITION: absolute; TOP: 50px; HEIGHT: 22px"
				ms_positioning="FlowLayout">Call Id:</DIV>
			<INPUT style="Z-INDEX: 102; LEFT: 240px; WIDTH: 60px; POSITION: absolute; TOP: 51px; HEIGHT: 21px"
				type="text" maxLength="7" size="4" value="5474853" id="LogEventCallId" name="LogEventCallId">
			<INPUT style="Z-INDEX: 103; LEFT: 189px; WIDTH: 126px; POSITION: absolute; TOP: 150px; HEIGHT: 23px"
				type="submit" value="Show Events">
			<DIV style="DISPLAY: inline; Z-INDEX: 104; LEFT: 139px; WIDTH: 99px; POSITION: absolute; TOP: 97px; HEIGHT: 22px"
				ms_positioning="FlowLayout">
				<P>Organization Id:</P>
			</DIV>
			<INPUT id="WebUserOrganizationId" style="Z-INDEX: 105; LEFT: 241px; WIDTH: 59px; POSITION: absolute; TOP: 98px; HEIGHT: 21px"
				type="text" size="4" value="194" name="WebUserOrganizationId">
			<DIV style="DISPLAY: inline; Z-INDEX: 106; LEFT: 185px; WIDTH: 53px; POSITION: absolute; TOP: 75px; HEIGHT: 20px"
				ms_positioning="FlowLayout">User Id:</DIV>
			<INPUT style="Z-INDEX: 107; LEFT: 241px; WIDTH: 59px; POSITION: absolute; TOP: 75px; HEIGHT: 19px"
				type="text" maxLength="12" size="4" value="3060" id="WebUserId" name="WebUserId">
			<asp:Label id="Label1" style="Z-INDEX: 108; LEFT: 313px; POSITION: absolute; TOP: 53px" runat="server"
				Width="150px" Height="18px" Visible="False">LifeBanc User - rwood</asp:Label>
			<asp:Label id="Label2" style="Z-INDEX: 109; LEFT: 314px; POSITION: absolute; TOP: 73px" runat="server"
				Width="117px" Height="15px" Visible="False">1313</asp:Label>
			<asp:Label id="Label3" style="Z-INDEX: 110; LEFT: 315px; POSITION: absolute; TOP: 101px" runat="server"
				Width="128px" Height="22px" Visible="False">1100</asp:Label>
			<INPUT id="LogEventDSN" style="Z-INDEX: 111; LEFT: 242px; WIDTH: 104px; POSITION: absolute; TOP: 122px; HEIGHT: 21px"
				type="text" size="12" value="Development" name="LogEventDSN">
			<DIV title="DSN:" style="DISPLAY: inline; Z-INDEX: 112; LEFT: 158px; WIDTH: 79px; POSITION: absolute; TOP: 122px; HEIGHT: 19px"
				ms_positioning="FlowLayout">
				<P>DataSource:</P>
			</DIV>
		</form>
	</body>
</HTML>
