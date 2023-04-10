<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsStatTracUserControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsStatTracUserControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" enableViewState="True"%>
<div class="SectionSeperator">
    <div class="ParamControlLabel">
        StatTrac User:    
    </div>
    <div class="ParamControl">
        <cc1:DropDownReportStatTracUser id="ddlStatTracUser" runat="server" AutoPostBack="False" DefaultText="..."></cc1:DropDownReportStatTracUser>
    </div>
</div>