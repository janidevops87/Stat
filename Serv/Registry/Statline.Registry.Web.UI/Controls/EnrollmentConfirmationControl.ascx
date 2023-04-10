<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EnrollmentConfirmationControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.EnrollmentConfirmationControl" %>

<asp:Panel ID="PanelAdd" runat="server" Font-Names="Arial" Font-Size="10pt" Height="206px"
    Style="z-index: 100; left: 21px; position: relative; top: 5px" Width="600px" Visible="False">
    Thank you for making the decision to register as an organ and/or tissue donor. You
    should receive a confirmation email shortly.
    <p>
        Should you wish to change your Donate Life New England Donor Registry status at
        any time in the future, please visit <a href="http://www.donatelifenewengland.org/">
        www.donatelifenewengland.org</a>
    </p>
    <p>
        Please remember that Donate Life New England is an independent registry. Adding
        or removing yourself from this registry does not change your donor designation status
        with your state department of motor vehicles in any way.
    </p>
    Return to <a href="http://www.donatelifenewengland.org/">www.donatelifenewengland.org</a>
    to learn more about donation and how you can help spread the word about donation!
</asp:Panel>
<asp:Panel ID="PanelRemove" runat="server" Font-Names="Arial" Font-Size="10pt" Height="206px"
    Style="z-index: 100; left: 21px; position: relative; top: 5px" Width="600px" Visible="False">
    <p>
        You have been removed from the Donate Life New England Donor Registry. You should receive a confirmation email shortly.
    </p>
    <p>
        Please remember that Donate Life New England is an independent registry. Adding or removing yourself from this registry does not change your donor designation status with your state department of motor vehicles.
    </p>
    <p>
        Return to <a href="http://www.donatelifenewengland.org/">www.donatelifenewengland.org</a>
    </p> 

</asp:Panel>
