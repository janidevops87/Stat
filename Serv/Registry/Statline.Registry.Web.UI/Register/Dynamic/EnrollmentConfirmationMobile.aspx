<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnrollmentConfirmationMobile.aspx.cs" Inherits="Statline.Registry.Web.UI.Register.Dynamic.EnrollmentConfirmationMobile" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages"
    TagPrefix="mp" %>
<%@ Register Src="../../Controls/Dynamic/EnrollmentConfirmationMobileControl.ascx" TagName="EnrollmentConfirmationMobileControl"
    TagPrefix="uc1" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicRegisterMobileView.ascx" runat="server">
    <mp:content id="cR" runat="server">
        <uc1:EnrollmentConfirmationMobileControl id="EnrollmentConfirmationMobile2" runat="server">
        </uc1:EnrollmentConfirmationMobileControl>
    </mp:content>
</mp:contentcontainer>