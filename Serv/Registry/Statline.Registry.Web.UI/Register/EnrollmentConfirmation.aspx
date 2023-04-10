<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnrollmentConfirmation.aspx.cs" Inherits="Statline.Registry.Web.UI.Register.EnrollmentConfirmation" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages"
    TagPrefix="mp" %>
<%@ Register Src="../Controls/EnrollmentConfirmationControl.ascx" TagName="EnrollmentConfirmationControl"
    TagPrefix="uc1" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicRegisterView.ascx" runat="server">
    <mp:content id="cR" runat="server">
        <uc1:EnrollmentConfirmationControl id="EnrollmentConfirmation1" runat="server">
        </uc1:EnrollmentConfirmationControl>
    </mp:content>
</mp:contentcontainer>