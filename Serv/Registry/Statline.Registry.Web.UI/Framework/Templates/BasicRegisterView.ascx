<%@ Register TagPrefix="uc1" TagName="MenuControl" Src="../Navigation/MenuControl.ascx" %>
<%@ Control CodeBehind="BasicRegisterView.ascx.cs" Language="c#" AutoEventWireup="True" Inherits="Statline.Registry.Web.UI.Framework.Templates.BasicRegisterView" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicMaster.ascx" runat="server">
	<mp:content id="bCR" runat="server">
		<table height="100%" bordercolor="white" cellspacing="0" cellpadding="0" width="100%" border="0" style=" padding-left: 30px;" >
			<tr valign="top" align="left" height="100%">
                <td>
					<table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td>
                            <mp:region id="validationErrorRegion" runat="server">
									<cc1:DataListMessageCollection id="dataListMessageCollection" runat="server"></cc1:DataListMessageCollection>
									<asp:ValidationSummary id="validationSummary" runat="server" ForeColor="" CssClass="Error"></asp:ValidationSummary>
								</mp:region>
                            </td>
                        </tr>
						<tr>
							<td valign="top" width="100%">
								<mp:region id="cR" runat="server">&nbsp;</mp:region>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>	
        </mp:content>
</mp:contentcontainer>