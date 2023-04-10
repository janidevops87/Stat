<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsPatientNameControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsPatientNameControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<div class="SectionSeperator">       
        <div class="ParamControlLabel" >
        Patient Last Name:
        </div>
		<div class="ParamControl">
			<asp:textbox id="txtBoxPatientLastName" runat="server" EnableViewState="False" Width="150px"></asp:textbox>
        </div>
</div>                
<div class="SectionSeperator" >   
        <div class="ParamControlLabel">
        Patient First Name:
        </div>
        <div class="ParamControl">
			<asp:textbox id="txtBoxPatientFirstName" runat="server" EnableViewState="False" Width="150px"></asp:textbox>
        </div>
</div>