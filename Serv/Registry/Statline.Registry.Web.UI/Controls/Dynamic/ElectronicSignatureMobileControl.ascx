<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ElectronicSignatureMobileControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.Dynamic.ElectronicSignatureMobileControl" %>
<div id="ElectronicSignatureMain" class="RegistryMainMobile">
        <asp:HiddenField ID="hdnRegistryOwnerRouteName" runat="server"  Value="None" />
        <asp:HiddenField ID="hdnRegistryOwnerID" runat="server" />
        <asp:HiddenField ID="hdnLanguageCode" runat="server" />
        <asp:HiddenField ID="hdnRegistryID" runat="server" />
        <asp:HiddenField ID="hdnDonorRegistrationRequest" runat="server" />
        <asp:HiddenField ID="hdnFirstName" runat="server" />
        <asp:HiddenField ID="hdnLastName" runat="server" />
        <asp:HiddenField ID="hdnLastFourSSN" runat="server" />
        <asp:HiddenField ID="hdnLicense" runat="server" />
        <asp:HiddenField ID="hdnIDologyID" runat="server" />
        <asp:HiddenField ID="hdnAllowDisplayNoDonors" runat="server" />
        <asp:HiddenField ID="hdnCSSFileLocation" runat="server" />
        <asp:HiddenField ID="hdnState" runat="server" />

<div id=Div3" class="RegistrySignatureMobile">
    <div id="lblName1" class="RegistrySignatureLabelMobile">
        <asp:Label ID="lblName" runat="server" Text="Name:"> </asp:Label>
        </div>
    <div class="RegistrySignatureValueMobile">
        <asp:Label ID="lblNameValue" runat="server"></asp:Label>
    </div>
    <div class="RegistrySignatureLabelMobile">
        <asp:Label ID="lblAddress" runat="server" Text="Address:"></asp:Label>
    </div>
    <div class="RegistrySignatureValueMobile">
        <asp:Label ID="lblAddressValue" runat="server"></asp:Label>
    </div>
    <div class="RegistrySignatureLabelMobile">
        <asp:Label ID="lblEmail" runat="server" Text="Email:"></asp:Label>
    </div>
    <div class="RegistrySignatureValueMobile">
        <asp:Label ID="lblEmailValue" runat="server"></asp:Label>
    </div>
    <div id="divConfirmation" class="RegistrySignatureEnrollMobile">
        <asp:Label ID="lblConfirmationText" runat="server" Font-Bold="True" ></asp:Label>
       </div>
    <div id="divConfirmationNotes" runat="server" class="RegistrySignatureEnrollMobile">
        Additional Confirmation notes go here.
	    </div>      
    <div id="divConfirmation1" class="RegistrySignatureEnrollMobile">
        <asp:CheckBox ID="cbxConfirmation" runat="server" Font-Bold="False" OnCheckedChanged="cbxConfirmation_CheckedChanged" />
       </div>     
    <div id="divRegistration" class="RegistrySignatureEnrollMobile">
        <asp:Button ID="btnRegistration" runat="server" Text="Complete Registration" Width="200px" Height="50px" Font-Size=".8em" OnClick="btnRegistration_Click" />
       </div>     
        <asp:Label ID="lblDOB" runat="server" Visible="False"></asp:Label>
        <div id="divFooter" runat="server" class="RegistryFooterMobile">
        </div>
    </div>
</div>
<asp:ObjectDataSource ID="odsDonor" runat="server" SelectMethod="FillDataFormElectronicSignature" TypeName="Statline.Registry.Common.RegistryCommonManager">
    <SelectParameters>
        <asp:Parameter Name="RegistryID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
