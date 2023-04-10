<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Enrollment.aspx.cs" Inherits="Statline.Registry.Web.UI.Register.Enrollment" %>
<%@ Register Src="../Controls/EnrollmentControl.ascx" TagName="EnrollmentControl"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicRegisterView.ascx" runat="server">
	<mp:content id="cR" runat="server">
	<uc1:EnrollmentControl id="EnrollmentControl1" runat="server">
</uc1:EnrollmentControl>
	</mp:content>	
</mp:contentcontainer>