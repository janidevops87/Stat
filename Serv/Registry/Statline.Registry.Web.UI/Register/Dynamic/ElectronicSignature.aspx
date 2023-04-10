<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ElectronicSignature.aspx.cs" Inherits="Statline.Registry.Web.UI.Register.Dynamic.ElectronicSignature" %>
<%@ Register Src="../../Controls/Dynamic/ElectronicSignatureControl.ascx" TagName="ElectronicSignatureControl"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicRegisterView.ascx" runat="server">
	<mp:content id="cR" runat="server">
	    <uc1:ElectronicSignatureControl id="ElectronicSignature2" runat="server">
        </uc1:ElectronicSignatureControl>
	</mp:content>	
</mp:contentcontainer>