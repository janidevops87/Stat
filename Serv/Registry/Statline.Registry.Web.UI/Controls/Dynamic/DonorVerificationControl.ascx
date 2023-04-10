<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DonorVerificationControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.Dynamic.DonorVerificationControl" %>
<div id="DonorVerificationMain" class="DonorVerification">
    <div style=" width: 650px; font-size: 10pt; font-family: Arial; left: 32px; top: 1px; position: relative;">
        <div style=" width: 640px; left: 7px; top: 5px; ">
            <span style="font-size: 16pt">
            <b>
                <asp:Label ID="lblHeader" runat="server" Style="z-index: 100; left: 8px; text-align: center;
                     top: 5px" Width="630px"></asp:Label>
            </b>
         
            </span>
                <asp:Label ID="lblLegalIntro" runat="server" Style="z-index: 104; left: 55px;  text-align: center;
                    " Text="Pursuant to the Uniform Anatomical Gift Acts of:" Width="631px"></asp:Label>

                <br /><br />
                <asp:Label ID="lblLegal" runat="server" Style="z-index: 101; left: 54px; text-align: left;
                    " Height="5px" Width="629px"></asp:Label><br />
        
                <asp:Label ID="lblLegalDescription" runat="server" Height="5px" Style="z-index: 102;
                    left: 4px;  text-align: left" Width="632px"></asp:Label>
        </div>
        <div id = "divMiopRectangle" runat="server" style="position:relative; Top: 25px;"  class="DefaultRectangle">

            <table width="100%" height="150px" border="0px" cellspacing="0" cellpadding="2px">
            <tr>
                <td width="16"></td>
                <td width="158px"><asp:Label ID="lblStateID" runat="server"></asp:Label></td>
                <td width="161px"><asp:Label ID="lblStateIDValue" runat="server"></asp:Label></td>
                <td width="195px"><asp:Label ID="lblSignatureDateValue" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td width="16"></td>
                <td width="158px"><asp:Label ID="lblFullName" Text="Full Name:" runat="server"></asp:Label></td>
                <td width="161px"><asp:Label ID="lblFullNameValue" runat="server"></asp:Label></td>
                <td width="195px"></td>
            </tr>
            <tr>
                <td width="16"></td>
                <td width="158px"><asp:Label ID="lblDOB" Text="Date of Birth:" runat="server"></asp:Label></td>
                <td width="161px"><asp:Label ID="lblDOBValue" runat="server"></asp:Label></td>
                <td width="195px"><asp:Label ID="lblWebRegistryNo" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td width="16"></td>
                <td width="158px"><asp:Label ID="lblAddress" Text="Residential Address:" runat="server"></asp:Label></td>
                <td width="161px"><asp:Label ID="lblResidentialAddressValue" runat="server"></asp:Label></td>
                <td width="195px"></td>
            </tr>
            <tr>
                <td width="16"></td>
                <td width="158px"></td>
                <td width="161px"><asp:Label ID="lblCityStateZipValue" runat="server"></asp:Label></td>
                <td width="195px"></td>
            </tr>
            <tr>
                <td width="16"></td>
                <td width="158px"><asp:Label ID="lblLimitations" runat="server"></asp:Label></td>
                <td width="161px" colspan="2"><asp:Label ID="lblLimitationsValue" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td width="16"></td>
                <td width="158px"><asp:Label ID="lblComments" Text="" runat="server"></asp:Label></td>
                <td width="161px" colspan="2"><asp:Label ID="lblCommentsValue" runat="server"></asp:Label></td>
            </tr>
            </table>
       
             <div style="position: relative; top: 2px; left:200px;">
                <!-- MIOP'S HEART LOGO -->   
                <asp:Image ID="imgMiopHeart" runat="server" acssClass="RegistrySection" Style="left: 10px; position: relative; top: 10px"  />             
                <br />
                 <div style="float:left;word-wrap: normal;">
	                <asp:Label ID="lblInsigniaComment" runat="server" Style="z-index: 107; left: 10px; position: absolute; top: 50px" Width="150px"></asp:Label>
                </div>               
            </div>
        </div>

    <div id="divLegalDescription" runat="server" style="position:relative; width: 660px; height: 5px; top:50px; left: 5px; text-align: left; padding:10px 0px 10px 0px;">
    </div>
    <div id="divContactInformation" runat="server" style="position:relative; width: 640px; height: 5px; top: 380px;  left: 5px; text-align: left; padding:10px 0px 10px 0px;">
    </div>

    <%--<div style="position:relative; width: 640px; height: 15px; left: 5px; text-align: center; ">
        <strong>Orginal (File in Medical Record)</strong></div>--%>
    </div>
</div>
<asp:ObjectDataSource ID="odsVerification" runat="server"></asp:ObjectDataSource>
