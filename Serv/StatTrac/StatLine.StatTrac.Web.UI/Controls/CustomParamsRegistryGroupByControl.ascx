<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsRegistryGroupByControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsRegistryGroupByControl" %>
<div class="SectionSeperator" />
<div class="ParamControlLabel">
Report Format:
</div>
<div class="ParamControl">
  		<asp:RadioButtonList id="radioButtonReportFormat" runat="server" AutoPostBack="true" OnSelectedIndexChanged="raidoButtonReportFormat_SelectedIndexChanged">
   		    <asp:ListItem Value="Standard" Selected="true">Standard Format</asp:ListItem>
   		    <asp:ListItem Value="AgeGender" >Group by Age or Gender</asp:ListItem>
   		</asp:RadioButtonList>
</div>
<div class="SectionSeperator" />
<div class="ParamControlLabel">
Demographics:
</div>
<div class="ParamControl">
    <asp:CheckBox id="chkBoxGroupByAge" runat="server" EnableViewState="False" Text="Age" TextAlign="right" ></asp:CheckBox>
</div>
<div class="ParamControl">
    <asp:CheckBox id="chkBoxGroupByGender" runat="server" EnableViewState="False" Text="Gender" TextAlign="right" ></asp:CheckBox>
</div>