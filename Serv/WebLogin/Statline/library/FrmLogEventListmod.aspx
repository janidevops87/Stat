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
	<body oncontextmenu="return false" bgColor="activeborder" ms_positioning="GridLayout">
		<form id="Form1" method="post" runat="server">
			<asp:button id="cmdNewEvent" style="Z-INDEX: 100; LEFT: 776px; POSITION: absolute; TOP: 280px"
				runat="server" Height="26px" Width="85px" Text="New Event"></asp:button><asp:textbox id="txtContactDate2" style="Z-INDEX: 143; LEFT: 64px; POSITION: absolute; TOP: 40px"
				runat="server" Height="20px" Width="98px" MaxLength="15">00/00/00 00:00</asp:textbox><asp:label id="Label8" style="Z-INDEX: 108; LEFT: 16px; POSITION: absolute; TOP: 40px" tabIndex="50"
				runat="server">Date</asp:label><asp:panel id="pnlOtherName2" style="Z-INDEX: 131; LEFT: 584px; POSITION: absolute; TOP: 8px"
				runat="server" Height="75px" Width="288px" BorderStyle="Outset" Visible="False" CssClass="CSSNoPop">
				<asp:Label id="spacer32" runat="server" Width="6px"></asp:Label>
				<asp:Label id="Label62" runat="server" Width="86px" Font-Size="X-Small" Font-Names="Arial">Person Name:</asp:Label>
				<asp:Label id="Label42" runat="server" Width="280px" BackColor="Desktop" ForeColor="White"
					Font-Size="X-Small" Font-Names="Arial" Font-Bold="True">Person Name</asp:Label>
				<asp:TextBox id="txtOtherName2" runat="server" Height="24px" Width="182px" BorderStyle="Inset"></asp:TextBox>
				<asp:Label id="spacer42" runat="server" Width="55px"></asp:Label>
				<asp:Button id="cmdOtherName2" runat="server" Width="67px" Text="OK"></asp:Button>
				<asp:Label id="spacer92" runat="server" Height="10px" Width="28px"></asp:Label>
				<asp:Button id="cmdOtherNameCancel2" runat="server" Height="25px" Width="67px" Text="Cancel"></asp:Button>
			</asp:panel><asp:dropdownlist id="cboKeyCode2" style="Z-INDEX: 130; LEFT: 600px; POSITION: absolute; TOP: 120px"
				runat="server" Width="150px"></asp:dropdownlist><asp:dropdownlist id="cboContactEventType2" style="Z-INDEX: 128; LEFT: 272px; POSITION: absolute; TOP: 40px"
				tabIndex="7" runat="server" Height="17px" Width="196px" AutoPostBack="True"></asp:dropdownlist><asp:textbox id="txtContactDesc2" style="Z-INDEX: 126; LEFT: 272px; POSITION: absolute; TOP: 72px"
				tabIndex="8" runat="server" Height="94px" Width="200px" TextMode="MultiLine" MaxLength="999"></asp:textbox><asp:button id="cmdValidationMsg2" style="Z-INDEX: 125; LEFT: 832px; POSITION: absolute; TOP: 112px"
				runat="server" Height="16px" Width="24px" Text="Invalid Callout Date!" BorderStyle="Dashed" BackColor="#C0C0FF" ForeColor="Red" BorderColor="RosyBrown" Font-Bold="True" Visible="False" CausesValidation="False"></asp:button><asp:checkbox id="chkConfirmed2" style="Z-INDEX: 107; LEFT: 488px; POSITION: absolute; TOP: 112px"
				tabIndex="10" runat="server" Height="27px" Width="81px" Text="Contact Confirmed"></asp:checkbox><asp:button id="cmdOK2" style="Z-INDEX: 103; LEFT: 488px; POSITION: absolute; TOP: 72px" tabIndex="9"
				runat="server" Height="24px" Width="88px" Text="Save"></asp:button><asp:button id="cmdCancel" style="Z-INDEX: 122; LEFT: 488px; POSITION: absolute; TOP: 168px"
				tabIndex="11" runat="server" Height="23px" Width="88px" Text="Cancel"></asp:button><asp:datagrid id="dgLogEvent" style="Z-INDEX: 105; LEFT: 16px; POSITION: absolute; TOP: 352px"
				runat="server" Height="40px" Width="857px" BorderStyle="Inset" AllowPaging="True" PageSize="23" GridLines="Horizontal" AutoGenerateColumns="False" BackColor="White" ForeColor="Black"
				Font-Size="X-Small" Font-Names="Arial" HorizontalAlign="Left" BorderColor="DarkGray" BorderWidth="2px" CellPadding="1" AllowSorting="True" OnPageIndexChanged="dgLogEvent_Paged">
				<SelectedItemStyle Font-Size="XX-Small" Font-Names="Arial" Wrap="False" HorizontalAlign="Left" ForeColor="White"
					BackColor="DarkBlue"></SelectedItemStyle>
				<EditItemStyle Wrap="False"></EditItemStyle>
				<AlternatingItemStyle Wrap="False"></AlternatingItemStyle>
				<ItemStyle Font-Size="XX-Small" Wrap="False"></ItemStyle>
				<HeaderStyle Font-Size="X-Small" Font-Names="Arial" Font-Bold="True" Wrap="False" HorizontalAlign="Left"
					ForeColor="White" BackColor="ActiveBorder"></HeaderStyle>
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
			<asp:datagrid id="dgPendingEvent" style="Z-INDEX: 101; LEFT: 296px; POSITION: absolute; TOP: 208px"
				runat="server" Height="40px" Width="478px" BorderStyle="Inset" AllowPaging="True" PageSize="4"
				GridLines="Horizontal" AutoGenerateColumns="False" BackColor="White" ForeColor="Black" Font-Size="X-Small"
				Font-Names="Arial" HorizontalAlign="Left" BorderColor="DarkGray" BorderWidth="2px" CellPadding="1"
				AllowSorting="True" OnPageIndexChanged="dgPendingEvent_Paged">
				<SelectedItemStyle Font-Size="XX-Small" Font-Names="Arial" Wrap="False" HorizontalAlign="Left" ForeColor="White"
					BackColor="DarkBlue"></SelectedItemStyle>
				<EditItemStyle Wrap="False"></EditItemStyle>
				<AlternatingItemStyle Wrap="False"></AlternatingItemStyle>
				<ItemStyle Font-Size="XX-Small" Wrap="False"></ItemStyle>
				<HeaderStyle Font-Size="X-Small" Font-Names="Arial" Font-Bold="True" Wrap="False" HorizontalAlign="Left"
					ForeColor="White" BackColor="ActiveBorder"></HeaderStyle>
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
			</asp:datagrid><asp:textbox id="TxtEventDesc" style="Z-INDEX: 102; LEFT: 8px; POSITION: absolute; TOP: 208px"
				runat="server" Height="104px" Width="282px" TextMode="MultiLine"></asp:textbox><asp:label id="Label1" style="Z-INDEX: 104; LEFT: 8px; POSITION: absolute; TOP: 176px" runat="server"
				Width="151px">Event Description</asp:label><asp:label id="Label2" style="Z-INDEX: 106; LEFT: 296px; POSITION: absolute; TOP: 184px" runat="server"
				Width="97px">Pending Events</asp:label><input style="Z-INDEX: 109; LEFT: 11px; POSITION: absolute; TOP: 420px" type="hidden" value="this is the test string"
				name="vartest"> <INPUT style="Z-INDEX: 110; LEFT: 13px; POSITION: absolute; TOP: 450px" type="hidden" value="Joe User"
				name="DefaultContactName"> <INPUT style="Z-INDEX: 111; LEFT: 11px; POSITION: absolute; TOP: 479px" type="hidden" value="194"
				name="OrganizationId"> <input style="Z-INDEX: 112; LEFT: 12px; POSITION: absolute; TOP: 509px" type="hidden" value="0"
				name="FormState"> <INPUT style="Z-INDEX: 113; LEFT: 182px; POSITION: absolute; TOP: 421px" type="hidden"
				value="(720) 524-2913" name="DefaultContactPhone"> <INPUT style="Z-INDEX: 114; LEFT: 178px; POSITION: absolute; TOP: 455px" type="hidden"
				value="0" name="DefaultContactType"> <input style="Z-INDEX: 115; LEFT: 176px; POSITION: absolute; TOP: 487px" type="hidden"
				value="2738134" name="CallId"> <INPUT style="Z-INDEX: 116; LEFT: 179px; POSITION: absolute; TOP: 517px" type="hidden"
				value="Statline" name="DefaultOrganization"> <input style="Z-INDEX: 117; LEFT: 360px; POSITION: absolute; TOP: 423px" type="hidden"
				value="0" name="LogEventType"> <INPUT style="Z-INDEX: 118; LEFT: 350px; POSITION: absolute; TOP: 455px" type="hidden"
				value="2738134-10" name="CallNumber"> <INPUT style="Z-INDEX: 119; LEFT: 352px; POSITION: absolute; TOP: 491px" type="hidden"
				value="194" name="DefaultOrganizationID"><input style="Z-INDEX: 120; LEFT: 352px; POSITION: absolute; TOP: 520px" type="hidden"
				value="69" name="UserId">
			<script lang="javascript">
			window.resizeTo(885, 590)
			</script>
			<asp:textbox id="txtCalloutDate2" style="Z-INDEX: 132; LEFT: 160px; POSITION: absolute; TOP: 144px"
				tabIndex="6" runat="server" Height="22px" Width="98px" MaxLength="15"></asp:textbox><asp:label id="lblCalloutUnits2" style="Z-INDEX: 133; LEFT: 96px; POSITION: absolute; TOP: 152px"
				tabIndex="50" runat="server" Height="20px" Width="64px" Font-Size="X-Small">min. or after</asp:label><asp:textbox id="txtCalloutMins2" style="Z-INDEX: 134; LEFT: 64px; POSITION: absolute; TOP: 144px"
				tabIndex="5" runat="server" Height="22px" Width="35px"></asp:textbox><asp:label id="lblCallout2" style="Z-INDEX: 135; LEFT: 8px; POSITION: absolute; TOP: 144px"
				tabIndex="50" runat="server">Callback</asp:label><asp:label id="lblContactPhone2" style="Z-INDEX: 136; LEFT: 16px; POSITION: absolute; TOP: 120px"
				tabIndex="50" runat="server" Width="44px">Phone</asp:label><asp:textbox id="txtContactPhone2" style="Z-INDEX: 137; LEFT: 64px; POSITION: absolute; TOP: 120px"
				tabIndex="4" runat="server" Height="23px" Width="198px" MaxLength="14"></asp:textbox><asp:textbox id="txtContactOrg2" style="Z-INDEX: 138; LEFT: 64px; POSITION: absolute; TOP: 96px"
				tabIndex="3" runat="server" Height="21px" Width="198px"></asp:textbox><asp:label id="lblContactOrg2" style="Z-INDEX: 139; LEFT: 16px; POSITION: absolute; TOP: 96px"
				tabIndex="50" runat="server" Height="16px" Width="44px">Org</asp:label><asp:label id="lblContactName2" style="Z-INDEX: 140; LEFT: 16px; POSITION: absolute; TOP: 72px"
				tabIndex="50" runat="server" Height="21px" Width="44px">Name</asp:label><asp:dropdownlist id="cboName2" style="Z-INDEX: 141; LEFT: 64px; POSITION: absolute; TOP: 72px" tabIndex="1"
				runat="server" Height="17px" Width="167px" AutoPostBack="True"></asp:dropdownlist><INPUT id="btnNameDetail2" style="Z-INDEX: 142; LEFT: 232px; WIDTH: 29px; POSITION: absolute; TOP: 72px; HEIGHT: 20px"
				onclick="popOtherNameForm();" type="button" value="..." name="btnNameDetail2"><INPUT 
id=OldCalloutDate2 
style="Z-INDEX: 144; LEFT: 776px; WIDTH: 118px; POSITION: absolute; TOP: 152px; HEIGHT: 23px" 
type=hidden size=14 value='<%=Session("OldCalloutDate")%>' name=OldCalloutDate><INPUT id=OldCalloutMins2 
style="Z-INDEX: 145; LEFT: 776px; WIDTH: 118px; POSITION: absolute; TOP: 176px; HEIGHT: 22px" 
type=hidden size=14 value='<%=Session("OldCalloutMins")%>' name=OldCalloutMins><INPUT id=ValMsg2 
style="Z-INDEX: 146; LEFT: 776px; WIDTH: 118px; POSITION: absolute; TOP: 208px; HEIGHT: 22px" 
type=hidden size=14 value='<%=Session("ValMsg")%>' name=ValMsg2><INPUT id=ValCtl2 
style="Z-INDEX: 147; LEFT: 776px; WIDTH: 118px; POSITION: absolute; TOP: 232px; HEIGHT: 23px" 
type=hidden size=14 value='<%=Session("ValCtl")%>' name=ValCtl2><INPUT id=ValDisplayOnce2 
style="Z-INDEX: 148; LEFT: 776px; WIDTH: 118px; POSITION: absolute; TOP: 256px; HEIGHT: 23px" 
type=hidden size=14 value='<%=Session("ValDisplayOnce")%>' name=ValDisplayOnce2></form>
	</body>
</HTML>
