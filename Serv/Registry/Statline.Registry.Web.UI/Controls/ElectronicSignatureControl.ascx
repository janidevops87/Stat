<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ElectronicSignatureControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.ElectronicSignatureControl" %>
<div style=" font-family: Arial; font-size: 10pt; position: relative; width: 650px; height: 300px; left: 11px; top: 12px;">
    <asp:Label ID="lblName" runat="server" Style="z-index: 100; left: 54px; position: absolute;
        top: 35px" Text="Name:" Width="36px"></asp:Label>
    <asp:Label ID="lblAddress" runat="server" Style="z-index: 101; left: 40px; position: absolute;
        top: 57px" Text="Address:"></asp:Label>
    <asp:Label ID="lblEmail" runat="server" Style="z-index: 102; left: 54px; position: absolute;
        top: 79px" Text="Email:" Width="36px"></asp:Label>
    <asp:Label ID="lblNameValue" runat="server" Style="z-index: 103; left: 120px; position: absolute;
        top: 34px" Width="400px"></asp:Label>
    <asp:Label ID="lblAddressValue" runat="server" Style="z-index: 104; left: 120px;
        position: absolute; top: 56px" Width="400px"></asp:Label>
    <asp:Label ID="lblEmailValue" runat="server" Style="z-index: 105; left: 120px; position: absolute;
        top: 78px" Width="400px"></asp:Label>
    <asp:Label ID="lblConfirmationText" runat="server" Font-Bold="True" Height="60px"
        Style="z-index: 106; left: 41px; position: absolute; top: 126px" Width="523px"></asp:Label>
    <asp:CheckBox ID="cbxConfirmation" runat="server" Font-Bold="False" Height="50px"
        OnCheckedChanged="cbxConfirmation_CheckedChanged" Style="z-index: 107; left: 103px;
        position: absolute; top: 194px" Width="395px" />
    <asp:Button ID="btnRegistration" runat="server" Style="z-index: 108; left: 206px;
        position: absolute; top: 261px" Text="Complete Registration" Width="200px" OnClick="btnRegistration_Click" />
    <asp:Label ID="lblDOB" runat="server" Visible="False"></asp:Label></div>
<asp:ObjectDataSource ID="odsDonor" runat="server" SelectMethod="FillDataFormElectronicSignature" TypeName="Statline.Registry.Common.RegistryCommonManager">
    <SelectParameters>
        <asp:Parameter Name="RegistryID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
