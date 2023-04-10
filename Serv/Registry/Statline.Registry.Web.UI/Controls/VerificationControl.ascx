<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="VerificationControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.VerificationControl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
    <div style=" width: 650px; font-size: 10pt; font-family: Arial; left: 0px; top: 1px;">

    <div style=" width: 640px; left: 7px; top: 5px; ">
        <span style="font-size: 16pt">
        <b>
            <asp:Label ID="lblHeader" runat="server" Height="44px" Style="z-index: 100; left: 8px; text-align: center;
                 top: 5px" Width="630px"></asp:Label>
        </b>
        </span>
            <asp:Label ID="lblLegalIntro" runat="server" Style="z-index: 104; left: 55px;  text-align: center;
                " Text="Pursuant to the Uniform Anatomical Gift Acts of:" Width="631px"></asp:Label>

            <br /><asp:Label ID="lblLegal" runat="server" Style="z-index: 101; left: 54px; text-align: center;
                " Height="5px" Width="629px"></asp:Label><br /><br />

        <!--<p style="text-align: left"><-->
            <asp:Label ID="lblLegalDescription" runat="server" Height="5px" Style="z-index: 102;
                left: 4px;  text-align: left" Width="632px"></asp:Label>
        <!--</p><-->
    </div><br />
    <div style="position:relative; width: 640px; height: 190px; left: 7px;">
        <asp:Label ID="lblFullNameValue" runat="server" Style="z-index: 100; left: 140px; position: absolute;
            top: 49px"></asp:Label>
        <asp:Label ID="lblDOBValue" runat="server" Style="z-index: 101; left: 140px; position: absolute;
            top: 69px"></asp:Label>
        <asp:Label ID="lblFullName" runat="server" Style="z-index: 102; left: 70px; position: absolute;
            top: 47px" Text="Full Name:"></asp:Label>
        <asp:Label ID="lblDOB" runat="server" Style="z-index: 103; left: 57px; position: absolute;
            top: 70px" Text="Date of Birth:"></asp:Label>
        <asp:Label ID="lblAddress" runat="server" Style="z-index: 104; left: 12px; position: absolute;
            top: 89px" Text="Residential Address:"></asp:Label>
        <asp:Label ID="lblResidentialAddressValue" runat="server" Style="z-index: 105; left: 140px;
            position: absolute; top: 89px" Width="250px"></asp:Label>
        <asp:Label ID="lblLimitationsValue" runat="server" Height="100px" Style="z-index: 106;
            left: 137px; position: absolute; top: 142px" Width="446px"></asp:Label>
        <div style="text-align: right">
        <asp:Label ID="lblLimitations" runat="server" Style="z-index: 107; left: 10px; position: absolute;
            top: 143px" Text="Limitations:" Width="119px"></asp:Label>
        </div>
        <asp:Label ID="lblCityStateZipValue" runat="server" Style="z-index: 108; left: 140px;
            position: absolute; top: 109px" Width="250px"></asp:Label>
        <asp:Label ID="lblSignatureDateValue" runat="server" Style="z-index: 109; left: 422px;
            position: absolute; top: 51px" Width="195px"></asp:Label>
        <asp:Label ID="lblWebRegistryNo" runat="server" Style="z-index: 110; left: 422px;
            position: absolute; top: 71px" Width="195px"></asp:Label>
        &nbsp;
        <asp:Label ID="lblStateID" runat="server" Height="34px" Style="z-index: 111; left: 4px;
            position: absolute; top: 4px" Width="159px"></asp:Label>
        <asp:Label ID="lblStateIDValue" runat="server" Style="z-index: 113; left: 168px;
            position: absolute; top: 21px" Width="161px"></asp:Label>
    </div>
<asp:Label id="lblLegalDescription2" runat="server" style="position:relative; width: 640px; height: 5px; left: 5px; text-align: left;">
</asp:Label>
<div id="divContactInformation" runat="server" style="position:relative; width: 640px; height: 5px; left: 5px; text-align: left;">
</div>

<div style="position:relative; width: 640px; height: 15px; left: 5px; text-align: center; ">
    <strong>Orginal (File in Medical Record)</strong></div>
</div>
<asp:ObjectDataSource ID="odsVerification" runat="server"></asp:ObjectDataSource>
