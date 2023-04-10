<%@ Page Language="vb" AutoEventWireup="false" Codebehind="FrmLogEventList.aspx.vb" Inherits="FrmLogEvent.FrmLogEventList" errorPage="err_default.htm"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>#<%=session("CallNumber")%></title>
		<meta content="Microsoft Visual Studio.NET 7.0" name="GENERATOR">
		<meta content="Visual Basic 7.0" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	</HEAD>
	<body oncontextmenu="return false" bgColor="activeborder">
		<form id="Form1" method="post" runat="server">
			<asp:button id="cmdNewEvent" style="Z-INDEX: 101; LEFT: 783px; POSITION: absolute; TOP: 108px" runat="server" Height="26px" Width="85px" Text="New Event"></asp:button><asp:datagrid id="dgLogEvent" style="Z-INDEX: 103; LEFT: 11px; POSITION: absolute; TOP: 140px" runat="server" Height="40px" Width="857px" BorderStyle="Inset" AllowPaging="True" PageSize="23" GridLines="Horizontal" AutoGenerateColumns="False" BackColor="White" ForeColor="Black" Font-Size="10pt" Font-Names="Arial" HorizontalAlign="Left" BorderColor="DarkGray" BorderWidth="2px" CellPadding="1" AllowSorting="True" OnPageIndexChanged="dgLogEvent_Paged">
				<SelectedItemStyle Font-Size="7.5pt" Font-Names="Arial" Wrap="False" HorizontalAlign="Left" ForeColor="White" BackColor="DarkBlue"></SelectedItemStyle>
				<EditItemStyle Wrap="False"></EditItemStyle>
				<AlternatingItemStyle Wrap="False"></AlternatingItemStyle>
				<ItemStyle Font-Size="7.5pt" Wrap="False"></ItemStyle>
				<HeaderStyle Font-Size="10pt" Font-Names="Arial" Font-Bold="True" Wrap="False" HorizontalAlign="Left" ForeColor="White" BackColor="ActiveBorder"></HeaderStyle>
				<Columns>
					<asp:BoundColumn Visible="False" DataField="LogEventId" HeaderText="ID"></asp:BoundColumn>
					<asp:ButtonColumn Text="Details" CommandName="Select">
						<HeaderStyle Width="20px"></HeaderStyle>
					</asp:ButtonColumn>
					<asp:BoundColumn DataField="RowNumber" HeaderText="#">
						<HeaderStyle Width="10px"></HeaderStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="DateTimeString" HeaderText="Date/Time">
						<HeaderStyle Width="35px"></HeaderStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="LogEventTypeName" HeaderText="Event Type">
						<HeaderStyle Width="100px"></HeaderStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="LogEventName" HeaderText="From/To"></asp:BoundColumn>
					<asp:BoundColumn DataField="LogEventOrg" HeaderText="Organization"></asp:BoundColumn>
					<asp:BoundColumn DataField="LogEventBy" HeaderText="By"></asp:BoundColumn>
					<asp:ButtonColumn Text="New Event" CommandName="New Event">
						<HeaderStyle Width="20px"></HeaderStyle>
					</asp:ButtonColumn>
					<asp:BoundColumn Visible="False" DataField="LogEventTypeId"></asp:BoundColumn>
				</Columns>
				<PagerStyle NextPageText="Next &amp;gt;&amp;gt;" PrevPageText="&amp;lt;&amp;lt; Previous" Position="Top"></PagerStyle>
			</asp:datagrid>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<asp:datagrid id="dgPendingEvent" style="Z-INDEX: 102; LEFT: 299px; POSITION: absolute; TOP: 30px" runat="server" Height="40px" Width="478px" BorderStyle="Inset" AllowPaging="True" PageSize="4" GridLines="Horizontal" AutoGenerateColumns="False" BackColor="White" ForeColor="Black" Font-Size="10pt" Font-Names="Arial" HorizontalAlign="Left" BorderColor="DarkGray" BorderWidth="2px" CellPadding="1" AllowSorting="True" OnPageIndexChanged="dgPendingEvent_Paged">
				<SelectedItemStyle Font-Size="7.5pt" Font-Names="Arial" Wrap="False" HorizontalAlign="Left" ForeColor="White" BackColor="DarkBlue"></SelectedItemStyle>
				<EditItemStyle Wrap="False"></EditItemStyle>
				<AlternatingItemStyle Wrap="False"></AlternatingItemStyle>
				<ItemStyle Font-Size="7.5pt" Wrap="False"></ItemStyle>
				<HeaderStyle Font-Size="10pt" Font-Names="Arial" Font-Bold="True" Wrap="False" HorizontalAlign="Left" ForeColor="White" BackColor="ActiveBorder"></HeaderStyle>
				<Columns>
					<asp:BoundColumn Visible="False" DataField="LogEventId" HeaderText="ID"></asp:BoundColumn>
					<asp:BoundColumn DataField="LogEventTypeName" HeaderText="Type">
						<HeaderStyle Width="100px"></HeaderStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="LogEventOrg_Name" HeaderText="Organization">
						<HeaderStyle Width="275px"></HeaderStyle>
					</asp:BoundColumn>
					<asp:ButtonColumn Text="Create Response" CommandName="Create Response">
						<HeaderStyle Width="100px"></HeaderStyle>
					</asp:ButtonColumn>
					<asp:BoundColumn Visible="False" DataField="LogEventTypeId"></asp:BoundColumn>
				</Columns>
				<PagerStyle NextPageText="Next &amp;gt;&amp;gt;" PrevPageText="&amp;lt;&amp;lt; Previous" Position="Top"></PagerStyle>
			</asp:datagrid><asp:textbox id="TxtEventDesc" style="Z-INDEX: 104; LEFT: 11px; POSITION: absolute; TOP: 29px" runat="server" Height="105px" Width="282px" TextMode="MultiLine"></asp:textbox><asp:label id="Label1" style="Z-INDEX: 105; LEFT: 11px; POSITION: absolute; TOP: 8px" runat="server" Width="151px" Font-Size="12pt">Event Description</asp:label><asp:label id="Label2" style="Z-INDEX: 106; LEFT: 299px; POSITION: absolute; TOP: 6px" runat="server" Width="97px" Font-Size="12pt">Pending Events</asp:label><input style="Z-INDEX: 107; LEFT: 11px; POSITION: absolute; TOP: 420px" type="hidden" value="this is the test string" name="vartest">
			<INPUT style="Z-INDEX: 108; LEFT: 13px; POSITION: absolute; TOP: 450px" type="hidden" value="Joe User" name="DefaultContactName">
			<INPUT style="Z-INDEX: 109; LEFT: 11px; POSITION: absolute; TOP: 479px" type="hidden" value="194" name="OrganizationId">
			<input style="Z-INDEX: 110; LEFT: 12px; POSITION: absolute; TOP: 509px" type="hidden" value="0" name="FormState">
			<INPUT style="Z-INDEX: 111; LEFT: 182px; POSITION: absolute; TOP: 421px" type="hidden" value="(720) 524-2913" name="DefaultContactPhone">
			<INPUT style="Z-INDEX: 112; LEFT: 178px; POSITION: absolute; TOP: 455px" type="hidden" value="0" name="DefaultContactType">
			<input style="Z-INDEX: 113; LEFT: 176px; POSITION: absolute; TOP: 487px" type="hidden" value="2738134" name="CallId">
			<INPUT style="Z-INDEX: 114; LEFT: 179px; POSITION: absolute; TOP: 517px" type="hidden" value="Statline" name="DefaultOrganization">
			<input style="Z-INDEX: 115; LEFT: 360px; POSITION: absolute; TOP: 423px" type="hidden" value="0" name="LogEventType">
			<INPUT style="Z-INDEX: 116; LEFT: 350px; POSITION: absolute; TOP: 455px" type="hidden" value="2738134-10" name="CallNumber">
			<INPUT style="Z-INDEX: 117; LEFT: 352px; POSITION: absolute; TOP: 491px" type="hidden" value="194" name="DefaultOrganizationID"><input style="Z-INDEX: 118; LEFT: 352px; POSITION: absolute; TOP: 520px" type="hidden" value="69" name="UserId"></form>
		<script lang="javascript">
			window.resizeTo(885, 590)
		</script>
	</body>
</HTML>
