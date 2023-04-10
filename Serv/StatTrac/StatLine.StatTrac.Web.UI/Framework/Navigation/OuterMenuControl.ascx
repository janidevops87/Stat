<%@ Control Language="c#" AutoEventWireup="True" Codebehind="OuterMenuControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Framework.Navigation.OuterMenuControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<TABLE borderColor="red" height="31" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<TR>
		<TD vAlign="middle" align="center" width="6"><IMG height="1" src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="1"></TD>
		<asp:DataList id="menuDataList" runat="server" RepeatLayout="Flow" CellPadding="0" RepeatDirection="Horizontal">
			<ItemTemplate>
				<asp:PlaceHolder id="activeTab" Runat="server">
					<td width="15" align="center" valign="middle" background="/Statline.StatTrac.Web.UI/Images/activeTab-Left.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="1"></td>
					<td nowrap background="/Statline.StatTrac.Web.UI/images/activeTab-Tile.gif" class="mainTabsActive">
						<asp:HyperLink runat="server" ID="activeHyperlink" NAME="activeHyperlink" CssClass="mainTabsActive"></asp:HyperLink></td>
					<td width="15" align="center" valign="middle" background="/Statline.StatTrac.Web.UI/images/activeTab-Right.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="1"></td>
				</asp:PlaceHolder>
				<asp:PlaceHolder id="inActiveTab" Runat="server">
					<td width="15" align="center" valign="middle" background="/Statline.StatTrac.Web.UI/images/inactiveTab-Left.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="1"></td>
					<td nowrap background="/Statline.StatTrac.Web.UI/images/inactiveTab-Tile.gif" class="mainTabsInactive">
						<asp:HyperLink runat="server" ID="inActiveHyperlink" NAME="inActiveHyperlink" CssClass="mainTabsInactive"></asp:HyperLink></td>
					<td width="15" align="center" valign="middle" background="/Statline.StatTrac.Web.UI/images/inactiveTab-Right.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="1"></td>
				</asp:PlaceHolder>
			</ItemTemplate>
		</asp:DataList>
		<TD class="mainTabsActive" vAlign="middle" align="right" width="100%"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="1" height="1"></TD>
	</TR>
</TABLE>
