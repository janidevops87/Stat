<%@ Control Language="c#" AutoEventWireup="True" Codebehind="InnerMenuControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Framework.Navigation.InnerMenuControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<TABLE borderColor="red" height="19" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR>
		<TD vAlign="middle" align="center" width="18"><IMG height="1" src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="1"></TD>
		<asp:DataList id="menuDataList" runat="server" RepeatLayout="Flow" CellPadding="0" RepeatDirection="Horizontal">
			<ItemTemplate>
				<asp:PlaceHolder id="activeTab" Runat="server">
					<td width="15" align="left" valign="top" background="/Statline.StatTrac.Web.UI/images/subTab-Left.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="15"></td>
					<td nowrap background="/Statline.StatTrac.Web.UI/images/subTab-Tile.gif" class="subTabsActive">
						<asp:HyperLink runat="server" ID="activeHyperlink" NAME="activeHyperlink" CssClass="subTabsActive"></asp:HyperLink></td>
					<td width="15" align="left" valign="top" background="/Statline.StatTrac.Web.UI/images/subTab-Right.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="15"></td>
				</asp:PlaceHolder>
				<asp:PlaceHolder id="inActiveTab" Runat="server">
					<td width="15" align="center" valign="middle" background="/Statline.StatTrac.Web.UI/images/subTabInactive-Left.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="15"></td>
					<td nowrap background="/Statline.StatTrac.Web.UI/images/subTabInactiveBkgrd-Tile.gif"
						class="subTabsInactive">
						<asp:HyperLink runat="server" ID="inActiveHyperlink" NAME="inActiveHyperlink" CssClass="subTabsInactive"></asp:HyperLink></td>
					<td width="15" align="center" valign="middle" background="/Statline.StatTrac.Web.UI/images/subTabInactive-Right.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="15"></td>
				</asp:PlaceHolder>
			</ItemTemplate>
		</asp:DataList>
		<TD class="mainTabsActive" vAlign="middle" align="center" width="100%">&nbsp;</TD>
	</TR>
</TABLE>
