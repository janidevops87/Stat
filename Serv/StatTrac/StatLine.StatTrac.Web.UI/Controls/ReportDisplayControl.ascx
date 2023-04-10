<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="ReportDisplayControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.ReportDisplayControl" TargetSchema="http://schemas.microsoft.com/intellisense/ie5"%>
<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845DCD8080CC91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>
<rsweb:ReportViewer ID="reportViewer" CssClass="ReportViewer"  runat="server" AsyncRendering="true" 
    ProcessingMode="Remote" PromptAreaCollapsed="True" ShowParameterPrompts="False" 
    HyperlinkTarget="_blank" OnReportError="reportViewer_ReportError" 
    Height="100%" Width="100%"   >        
</rsweb:ReportViewer>
<asp:ScriptManager ID="ScriptManager1" runat="server"  AsyncPostBackTimeout="56000" >
</asp:ScriptManager>