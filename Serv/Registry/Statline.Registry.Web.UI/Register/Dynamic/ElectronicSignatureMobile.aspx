<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ElectronicSignatureMobile.aspx.cs" Inherits="Statline.Registry.Web.UI.Register.Dynamic.ElectronicSignatureMobile" %>
<%@ Register Src="../../Controls/Dynamic/ElectronicSignatureMobileControl.ascx" TagName="ElectronicSignatureMobileControl"
    TagPrefix="uc1" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicRegisterMobileView.ascx" runat="server">
	<mp:content id="cR" runat="server">
	    <uc1:ElectronicSignatureMobileControl id="ElectronicSignatureMobile2" runat="server">
        </uc1:ElectronicSignatureMobileControl>
	</mp:content>	
</mp:contentcontainer>