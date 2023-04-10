<%@ Register TagPrefix="stattrac" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsReferralTypeControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsReferralTypeControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<div class="ParamLabeldAndControlWrapper">    
    <div class="ParamControlLabel">
     <asp:Label ID="lblReferralType" runat="server"  Text="Referral Type:" Width="120px"></asp:Label>
    
    </div>
    <div class="ParamControl">
        <igmisc:WebAsyncRefreshPanel ID="ajaxPanelReferralType" runat="server" >
	        <StatTrac:DropDownReferralType id="ddlReferralType" runat="server" AutoPostBack="False" DefaultText="..." Width="150px"/>
        </igmisc:WebAsyncRefreshPanel>
       
    </div>
</div>