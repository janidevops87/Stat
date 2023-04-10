<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsProcessor.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsProcessor" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" enableViewState="True"%>
<div class="SectionSeperator">       
        <div class="ParamControlLabel" >
        Processor:
        </div>
		<div class="ParamControl">
        <asp:DropDownList id="ddlProcessorList" runat="server" Width="208px" EnableViewState="False">
	        <asp:ListItem Value="Cryolife">Cryolife</asp:ListItem>
	        <asp:ListItem Value="LifeNet">LifeNet</asp:ListItem>
	        <asp:ListItem Value="MTF">MTF</asp:ListItem>
	        <asp:ListItem Value="CTDN" Selected="True">CTDN</asp:ListItem>
        </asp:DropDownList>
    </div>
</div>    