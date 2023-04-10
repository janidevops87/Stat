<%@ Control Language="c#" AutoEventWireup="True" Codebehind="InnerMenuControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Framework.Navigation.InnerMenuControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<TABLE borderColor="red" height="19" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR>
		<TD vAlign="middle" align="center" width="18"><IMG height="1" src='<%= ResolveUrl("~/Images/spacer.gif") %>' width="1"></TD>
		<asp:DataList id="menuDataList" runat="server" RepeatLayout="Flow" CellPadding="0" RepeatDirection="Horizontal">
			<ItemTemplate>
				<asp:PlaceHolder id="activeTab" Runat="server">
					<td width="15" align="left" valign="top" background='<%= ResolveUrl("~/Images/subTab-Left.gif") %>'><img src='<%= ResolveUrl("~/Images/spacer.gif") %>' width="15" height="15"></td>
					<td nowrap background='<%= ResolveUrl("~/Images/subTab-Tile.gif") %>' class="subTabsActive">
						<asp:HyperLink runat="server" ID="activeHyperlink" NAME="activeHyperlink" CssClass="subTabsActive"></asp:HyperLink></td>
					<td width="15" align="left" valign="top" background='<%= ResolveUrl("~/Images/subTab-Right.gif") %>'><img src='<%= ResolveUrl("~/Images/spacer.gif") %>' width="15" height="15"></td>
				</asp:PlaceHolder>
				<asp:PlaceHolder id="inActiveTab" Runat="server">
					<td width="15" align="center" valign="middle" background='<%= ResolveUrl("~/Images/subTabInactive-Left.gif") %>'><img src='<%= ResolveUrl("~/Images/spacer.gif") %>' width="15" height="15"></td>
					<td nowrap background='<%= ResolveUrl("~/Images/subTabInactiveBkgrd-Tile.gif") %>'
						class="subTabsInactive">
						<asp:HyperLink runat="server" ID="inActiveHyperlink" NAME="inActiveHyperlink" CssClass="subTabsInactive"></asp:HyperLink></td>
					<td width="15" align="center" valign="middle" background='<%= ResolveUrl("~/Images/subTabInactive-Right.gif") %>'><img src='<%= ResolveUrl("~/Images/spacer.gif") %>' width="15" height="15"></td>
				</asp:PlaceHolder>
			</ItemTemplate>
		</asp:DataList>
		<TD class="mainTabsActive" vAlign="middle" align="center" width="100%">&nbsp;</TD>
	</TR>
</TABLE>
