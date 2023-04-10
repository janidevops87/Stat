<%@ Control Language="c#" AutoEventWireup="True" Codebehind="CustomParamsAvayaTroubleReportControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsAvayaTroubleReportControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" enableViewState="True"%>
<div style="width:500px;">
    <div class="SectionSeperator" >
        <div class="ParamControlLabel">
            Agent ID:
        </div  >
        <div class="ParamControl">
	        <asp:textbox id="txtBoxAgentID" runat="server" EnableViewState="False"></asp:textbox><INPUT type="checkbox" checked onclick="javascript:toggleInputElementsDisabledStatus('<%=this.txtBoxAgentID.ClientID%>');"	>
        </div>
    </div>  
    <div class="SectionSeperator" >
        <div class="ParamControlLabel">
            Calling Number:
        </div>
        <div class="ParamControl">
            <asp:textbox id="txtBoxCallingNumber" runat="server" EnableViewState="False"></asp:textbox><INPUT type="checkbox" checked onclick="javascript:toggleInputElementsDisabledStatus('<%=this.txtBoxCallingNumber.ClientID%>');"	>
        </div>
    </div>
    <div class="SectionSeperator" >
        <div class="ParamControlLabel">
            Dialed Number:
        </div>
        <div class="ParamControl">
            <asp:textbox id="txtBoxDialedNumber" runat="server" EnableViewState="False"></asp:textbox><INPUT type="checkbox" checked onclick="javascript:toggleInputElementsDisabledStatus('<%=this.txtBoxDialedNumber.ClientID%>');">
        </div>
    </div>
    <div class="SectionSeperator" >
        <div class="ParamControlLabel">
            Minimum Queue Time (Sec):
        </div>
        <div class="ParamControl">
            <asp:textbox id="txtBoxMinmumQueueTime" runat="server" EnableViewState="False"></asp:textbox><INPUT type="checkbox" checked onclick="javascript:toggleInputElementsDisabledStatus('<%=this.txtBoxMinmumQueueTime.ClientID%>');"	>
        </div>
    </div>        
</div>