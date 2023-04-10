<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnrollmentMobile.aspx.cs" Inherits="Statline.Registry.Web.UI.Register.Dynamic.EnrollmentMobile" %>
<%@ Register Src="../../Controls/Dynamic/EnrollmentMobileControl.ascx" TagName="EnrollmentMobileControl"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicRegisterMobileView.ascx" runat="server">
	<mp:content id="cR" runat="server">
	<uc1:EnrollmentMobileControl id="EnrollmentMobileControl1" runat="server">
</uc1:EnrollmentMobileControl>
	</mp:content>	
</mp:contentcontainer>