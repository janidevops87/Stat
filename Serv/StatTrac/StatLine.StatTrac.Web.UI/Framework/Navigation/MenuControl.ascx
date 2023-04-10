<%@ Control Language="c#" AutoEventWireup="True" Codebehind="MenuControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Framework.Navigation.MenuControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Register TagPrefix="uc1" TagName="OuterMenuControl" Src="OuterMenuControl.ascx" %>
<%@ Register TagPrefix="uc1" TagName="InnerMenuControl" Src="InnerMenuControl.ascx" %>
<table width="100%" height="38" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff">
	<tr align="left" valign="top">
		<td width="15" background="/Statline.StatTrac.Web.UI/images/leftTile.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="5"></td>
		<td background="/Statline.StatTrac.Web.UI/images/mainTabBkgrd-Tile.gif">
			<mp:region id="outerNavRegion" runat="server">
				<uc1:OuterMenuControl id="outerMenuControl" runat="server"></uc1:OuterMenuControl>
			</mp:region>
		</td>
		<td width="15" background="/Statline.StatTrac.Web.UI/images/rightTile.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="5"></td>
	</tr>
</table>
<table width="100%" height="19" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff"
	bordercolor="red">
	<tr align="left" valign="top">
		<td width="15" background="/Statline.StatTrac.Web.UI/images/leftTile.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="5"></td>
		<td background="/Statline.StatTrac.Web.UI/images/subTabBkgrd-Tile.gif">
			<mp:region id="innerNavRegion" runat="server">
				<uc1:InnerMenuControl id="innerMenuControl" runat="server"></uc1:InnerMenuControl>
			</mp:region>
		</td>
		<td width="15" background="/Statline.StatTrac.Web.UI/images/rightTile.gif"><img src="/Statline.StatTrac.Web.UI/images/spacer.gif" width="15" height="5"></td>
	</tr>
</table>
