<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RegistrySearchResultsControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.RegistrySearchResultsControl" %>
<div style="width: 700px; font-size: 10pt; font-family: Arial; left: 7px; top: 13px; z-index: 100;" id="DIV1">
<script language="javascript" src="scripts/GenericPage.js" ></script>
    <asp:Label ID="lblWebNoData" runat="server" Style="left: 25px;" Font-Bold="True" Font-Names="Arial" Font-Size="12pt"></asp:Label><br />
    <asp:Label ID="lblDMVNoData" runat="server" Style="left: 25px;" Font-Bold="True" Font-Names="Arial" Font-Size="12pt"></asp:Label><br />
    <asp:Label ID="lblDMV_MINoData" runat="server" Style="left: 25px;" Font-Bold="True" Font-Names="Arial" Font-Size="12pt"></asp:Label><br />
    <asp:Label ID="lblWeb_MINoData" runat="server" Style="left: 25px;" Font-Bold="True" Font-Names="Arial" Font-Size="12pt"></asp:Label>
    <asp:DataList ID="dlRegistrySearchResults" runat="server" BackColor="White" BorderColor="#999999" DataMember="DataListRegistrySearchResults"
        BorderStyle="None" BorderWidth="1px" CellPadding="1" Width="690px" Height="1px" CellSpacing="1" OnSelectedIndexChanged="dlRegistrySearchResults_SelectedIndexChanged" style="left: 5px; top: 20px">
        <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
        <AlternatingItemStyle BackColor="Gainsboro" />
        <ItemStyle BackColor="#EEEEEE" ForeColor="Black" />
        <SelectedItemStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
        <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="Navy" Font-Italic="False" Font-Overline="False" Font-Strikeout="False" Font-Underline="False" />
        <ItemTemplate>
            <table style="width: 690px" border="solid"; cellspacing="0";>
                <tr><asp:Label ID="Header" runat="server" Text='<%# GetHeader(Eval("RegistrySearchResultSourceName").ToString()) %>'></asp:Label></tr>
                <tr>
                    <td rowspan="5" style="width: 107px" align="center">
                       <%# DisplayRegistryControls(Eval("RegistrySearchResultSourceID").ToString(), Eval("RegistrySearchResultSourceName").ToString(), Eval("RegistrySearchResultSourceState").ToString(), "")%>
                    </td>
                    <td style="width: 236px; background-color: #ccccff">
                        <asp:Label ID="FirstName" runat="server" Text='<%# Eval("RegistrySearchResultFirstName") %>'></asp:Label>
                        <asp:Label ID="Middle" runat="server" Text='<%# Eval("RegistrySearchResultMiddleName") %>'></asp:Label>
                        <asp:Label ID="LastName" runat="server" Text='<%# Eval("RegistrySearchResultLastName") %>'></asp:Label></td>
                    <td colspan="2" style="width: 296px; background-color: #ccccff">
                        <%# GetVerificationURL(Eval("RegistrySearchResultSourceID").ToString(), Eval("RegistrySearchResultSourceName").ToString(), Eval("RegistrySearchResultSourceState").ToString(), Eval("RegistrySearchResultDonorStatus").ToString())%> </td>
                </tr>
                <tr>
                    <td style="width: 236px">
                        DOB:
                        <asp:Label ID="DOB" runat="server" Text='<%# Eval("RegistrySearchResultDOB") %>'
                            Width="24px"></asp:Label></td>
                    <td colspan="2">
                        SID:
                        <asp:Label ID="SID" runat="server" Text='<%# Eval("RegistrySearchResultSID") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 236px; height: 20px">
                        <asp:Label ID="Address" runat="server" Text='<%# Eval("RegistrySearchResultAddress") %>'></asp:Label></td>
                    <td colspan="2" style="height: 20px">
                        <%# DisplayWebSourceID(Eval("RegistrySearchResultSourceID").ToString(), Eval("RegistrySearchResultSourceName").ToString(), Eval("RegistrySearchResultBranchNumber").ToString())%> </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <asp:Label ID="City" runat="server" Text='<%# Eval("RegistrySearchResultCity") %>'></asp:Label>,
                        <asp:Label ID="State" runat="server" Text='<%# Eval("RegistrySearchResultState") %>'></asp:Label>,
                        <asp:Label ID="Zip" runat="server" Text='<%# Eval("RegistrySearchResultZip") %>'></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 236px; height: 20px">
                        <asp:Label ID="DonorDate" runat="server" Text='<%# Eval("RegistrySearchResultDonorDate") %>'></asp:Label></td>
                    <td style="width: 120px; height: 20px">
                        Donor:
                        <asp:Label ID="Status" runat="server" Text='<%# Eval("RegistrySearchResultDonorStatus") %>'></asp:Label></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:DataList></div>

<asp:ObjectDataSource ID="odsRegistrySearchResults" runat="server" SelectMethod="FillDataListRegistrySearchResults"
    TypeName="Statline.Registry.Common.RegistryCommonManager">
    <SelectParameters>
        <asp:Parameter Name="FirstName" Type="String" />
        <asp:Parameter Name="MiddleName" Type="String" />
        <asp:Parameter Name="LastName" Type="String" />
        <asp:Parameter Name="City" Type="String" />
        <asp:Parameter Name="State" Type="String" />
        <asp:Parameter Name="Zip" Type="String" />
        <asp:Parameter Name="License" Type="String" />
        <asp:Parameter Name="WebRegistryID" Type="String" />
        <asp:Parameter Name="DOB" Type="String" />
        <asp:Parameter Name="DisplayWebDonors" Type="String" />
        <asp:Parameter Name="DisplayWebPendingSignature" Type="String" />
        <asp:Parameter Name="DisplayDMVDonors" Type="String" />
        <asp:Parameter Name="DisplayDMVDonorYesOnly" Type="String" />
        <asp:Parameter Name="StateSelection" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
