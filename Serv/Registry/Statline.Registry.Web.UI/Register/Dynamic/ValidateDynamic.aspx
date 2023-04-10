<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ValidateDynamic.aspx.cs" Inherits="Statline.Registry.Web.UI.Register.Dynamic.ValidateDynamic" %>
<%@ Register Src="../../Controls/Dynamic/ValidateDynamicControl.ascx" TagName="ValidateDynamicControl"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicRegisterView.ascx" runat="server">
    <mp:content id="cR" runat="server">
        <uc1:ValidateDynamicControl id="ValidateDynamicControl2" runat="server">
        </uc1:ValidateDynamicControl>
    </mp:content>
</mp:contentcontainer>
