<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubCategoryEdit.aspx.cs" Inherits="Statline.Registry.Web.UI.Controls.SubCategoryEdit" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.MasterPages" TagPrefix="mp" %>
<%@ Register Src="Controls/SubCategoryEditControl.ascx" TagName="SubCategoryEditControl" TagPrefix="uc1" %>
<mp:ContentContainer ID="cC" runat="server">
    <mp:Content ID="cR" runat="server" >
        <uc1:SubCategoryEditControl ID="SubCategoryEditControl" runat="server" />
    </mp:Content>
</mp:ContentContainer>

