<%@ Register TagPrefix="stattrac" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsPendingReferralTypeControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsPendingReferralTypeControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<div class="ParamLabeldAndControlWrapper">    
    <div class="ParamControlLabel">
    Pending Referral Type:
    </div>
    <div class="ParamControl">
        <igmisc:WebAsyncRefreshPanel ID="ajaxPanelPendingReferralType" runat="server" >
	        <asp:DropDownList id="ddlPendingReferralType" runat="server" AutoPostBack="False" Width="150px" DataTextField="ReferralTypeName" DataValueField="ReferralTypeID" DataSourceID="odsPendingReferralType"/>
        </igmisc:WebAsyncRefreshPanel>
<asp:ObjectDataSource ID="odsPendingReferralType" runat="server" SelectMethod="FillReportPendingReferralType"
            TypeName="Statline.StatTrac.Report.ReportReferenceManager" OnSelecting="odsPendingReferralType_Selecting" OnDataBinding="odsPendingReferralType_DataBinding" OnSelected="odsPendingReferralType_Selected" OnUpdated="odsPendingReferralType_Updated" OnUpdating="odsPendingReferralType_Updating">
                        <SelectParameters>
                <asp:Parameter  Name="reportGroupID"  Type="Int32" />
            </SelectParameters>
        </asp:ObjectDataSource>
    </div>
</div>