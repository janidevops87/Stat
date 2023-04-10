<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsPersonControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsPersonControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<div class="SectionSeperator">       
        <div class="ParamControlLabel" >
            Person Last Name:
        </div>
		<div class="ParamControl">
			<asp:textbox id="txtBoxPersonLastName" runat="server" EnableViewState="False"></asp:textbox>
        </div>
</div>                
<div class="SectionSeperator" >   
        <div class="ParamControlLabel">
            Person First Name:
        </div>
        <div class="ParamControl">
			<asp:textbox id="txtBoxPersonFirstName" runat="server" EnableViewState="False"></asp:textbox>
        </div>
</div>
