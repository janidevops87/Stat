<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsFSConversionRateControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsFSConversionRateControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" enableViewState="True"%>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<div style="width:700px;">
    <div style="clear: left; margin-top: 5px; display: inline; float: left; visibility: visible;
        width: 150px; position: static; text-align: right" id="ApproachPersonLabel" >
        Approach Person:    
    </div>
    <div id="ApproacPersonddl">
        <cc1:DropDownReportFSConversionApproachPerson id="ddlApproachPerson" Width="500px" runat="server" AutoPostBack="false" DefaultText="..."></cc1:DropDownReportFSConversionApproachPerson>
    </div>
    <div style="clear: left; display: block; float: left; visibility: visible;
            width: 170px; position: static; text-align: right">
        <asp:CheckBox id="chkBoxBoneSkinOnly" runat="server" EnableViewState="False" Text="Run for Bone and Skin Only:" TextAlign="left"></asp:CheckBox>
    </div>    
</div>