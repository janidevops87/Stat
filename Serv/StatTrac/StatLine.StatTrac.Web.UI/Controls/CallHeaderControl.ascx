<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CallHeaderControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CallHeaderControl" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
    
&nbsp;
<div style="left:25px; width: 220px; display: inline; top: 200px;
    height: 50px">
    <asp:Label ID="lblCallNo" runat="server" Style="z-index: 100; left: 15px; 
        top: 0px" Text="Call #:" Width="40px"></asp:Label>
    <asp:LinkButton ID="lblCallNo1" runat="server" Style="
     color:Blue; text-align:left; top: 0px; left: 65px; z-index: 100;" Width="100px"  OnClick="lblCallNo1_Click"></asp:LinkButton>    
</div>
<table style="left: 330px; display: inline; top: 200px ; width: 490px;">
    <tr>
        <td style="width: 108px; height: 21px;">
            <asp:Label ID="lblRefFac" runat="server" Style="  
                top: 0px" Text="Referral Facility:" Width="105px"></asp:Label>
        </td>
        <td style="width: 388px; height: 21px;">
            <asp:Label ID="lblRefFac1" runat="server" Style=" 
             left: 115px;  top: 0px" Width="280px"></asp:Label>
        </td>
       
        
    </tr>
    <tr>
        <td style="width: 108px; height: 21px;">
            <asp:Label ID="lblPatient" runat="server" Style="
                top: 25px" Text="Patient:"></asp:Label>
        </td>
        <td style="width: 388px; height: 21px;">
            <asp:Label ID="lblPatientInfo" runat="server" Style="
                left: 115px; top: 25px" Width="145px"></asp:Label>
             <asp:Label ID="lblASR" runat="server" Style="
                left: 265px; top: 25px; "  Width="90px"></asp:Label>    
        </td>
              
    </tr>
</table>
    



<!--<asp:Label ID="lblOrgID" runat="server" Style=" position: absolute;
                top: 470px; z-index: 100; left:45px " Visible=false></asp:Label>
<asp:Label ID="lblCallID" runat="server" Style=" position: absolute;
                top: 500px; z-index: 101; left:45px" Visible=false></asp:Label>
<asp:Label ID="lblCallOrgID" runat="server" Style="z-index: 106; left: 40px; position: absolute;
    top: 440px" Visible="False"></asp:Label>-->
