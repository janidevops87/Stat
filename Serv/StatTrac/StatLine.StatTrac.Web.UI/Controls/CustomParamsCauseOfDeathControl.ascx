<%@ Register TagPrefix="stattrac" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsCauseOfDeathControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsCauseOfDeathControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<div class="SectionSeperator">

    <div class="ParamControlLabel" >
            Cause Of Death:
        </div>
        <div class="ParamControl" >			
            <StatTrac:DropDownCauseOfDeath id="ddlCauseOfDeath" runat="server" AutoPostBack="False" DefaultText="..." Width="150px"></StatTrac:DropDownCauseOfDeath>
        </div>
</div> 