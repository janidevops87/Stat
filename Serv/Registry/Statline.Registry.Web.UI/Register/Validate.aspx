<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Validate.aspx.cs" Inherits="Statline.Registry.Web.UI.Register.Validate" %>
<%@ Register Src="../Controls/ValidateControl.ascx" TagName="ValidateControl"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicRegisterView.ascx" runat="server">
    <mp:content id="cR" runat="server">
        <uc1:ValidateControl id="ValidateControl1" runat="server">
        </uc1:ValidateControl>
    </mp:content>
</mp:contentcontainer>
