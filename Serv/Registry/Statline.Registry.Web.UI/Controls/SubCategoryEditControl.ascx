<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SubCategoryEditControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.SubCategoryEditControl" %>
<div style="position: relative; width: 650px; height: 207px; font-size: 10pt; font-family: Arial; left: 0px; top: 1px;">
<asp:Label ID="lblSubCategory" runat="server" Font-Bold="True" Style="z-index: 100; left: 15px;
    position: absolute; top: 9px" Text="Sub Category"></asp:Label>
    <asp:CheckBox ID="cbxSubCategoryActive" runat="server" Style="z-index: 101; left: 33px;
        position: absolute; top: 39px" Text="Active" />
    <asp:CheckBox ID="cbxSubCategoryAdditionalText" runat="server" Style="z-index: 102;
        left: 414px; position: absolute; top: 68px" Text="Provide text field to specify answer" />
    <asp:Label ID="lblSubCategoryName" runat="server" Style="z-index: 103; left: 59px;
        position: absolute; top: 70px" Text="Sub Category Name:"></asp:Label>
    <asp:Label ID="lblSubCategorySourceCode" runat="server" Style="z-index: 104; left: 101px;
        position: absolute; top: 96px" Text="Source Code:"></asp:Label>
    <asp:Button ID="btnSubCategorySave" runat="server" Style="z-index: 105; left: 140px;
        position: absolute; top: 121px" Text="Save" OnClick="btnSubCategorySave_Click" />
    <asp:Button ID="btnSubCategoryCancel" runat="server" Style="z-index: 106; left: 191px;
        position: absolute; top: 121px" Text="Cancel" OnClick="btnSubCategoryCancel_Click" />
    <asp:TextBox ID="txtSubCategoryName" runat="server" Style="z-index: 107; left: 190px;
        position: absolute; top: 65px" Width="215px"></asp:TextBox>
    <asp:TextBox ID="txtSubCategorySourceCode" runat="server" Style="z-index: 109; left: 190px;
        position: absolute; top: 92px"></asp:TextBox>
</div>