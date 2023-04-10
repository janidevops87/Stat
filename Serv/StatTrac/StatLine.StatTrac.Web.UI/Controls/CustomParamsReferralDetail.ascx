<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsReferralDetail.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsReferralDetail" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" enableViewState="True"%>

<div class="SectionSeperator">
    <asp:Panel ID="panelSecondary" CssClass="defaultPanel" GroupingText="Secondary Group Display " runat="server">
        <div class="ParamCheckBox">
            <asp:CheckBox id="chkBoxDisplaySecondaryData" runat="server" EnableViewState="False" Text="Secondary Data:" TextAlign="Left"></asp:CheckBox>
        </div>
        <div class="ParamCheckBox">
            <asp:CheckBox id="chkBoxDisplaySecondaryDisposition" runat="server" EnableViewState="true"  Text="Secondary Disposition:" TextAlign="Left"></asp:CheckBox>
            </div>
    </asp:Panel>        
</div>
<div class="SectionSeperator">
    <div class="ParamControlLabel">
        Sort Secondary Data in:
    </div>
    <div class="ParamControl">
        <asp:DropDownList id="ddlSortSecondaryData" runat="server" Width="333px" EnableViewState="False">
			    <asp:ListItem Selected="True"></asp:ListItem>
			    <asp:ListItem Value="Alphabetical">Alphabetical Order</asp:ListItem>
			    <asp:ListItem Value="Case">Case Order</asp:ListItem>
		    </asp:DropDownList>
	</div>
</div>         	