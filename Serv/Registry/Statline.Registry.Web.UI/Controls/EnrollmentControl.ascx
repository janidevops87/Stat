<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EnrollmentControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.EnrollmentControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDataInput.v11.1, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<%@ Register Assembly="Infragistics4.WebUI.WebCombo.v11.1, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebCombo" TagPrefix="igcmbo" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>

<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>

<script language="javascript" type="text/javascript">

function textMaxLength(obj, maxLength, evt)
{
var charCode=(evt.which) ? evt.which : event.keyCode
var max = maxLength - 1;
var text = obj.value;
if(text.length > max)
{
var ignoreKeys = [8,46,37,38,39,40,35,36];
for(i=0;i<ignoreKeys.length;i++)
{
if(charCode==ignoreKeys[i])
{
return true;
}
}
return false;
}else
{
return true;
}
} 
</script>
<div style="font-size: 10pt; background-color:White; width: 100%; font-family: Arial; position: relative;
    top: -34px; height: 1300px; left: -13px;" id="DIV1">
    <div style="z-index: 133; left: 6px; width: 498px; position: absolute; top: 133px;
        height: 46px">
        Please fill out the form below to register as an organ and tissue donor. By registering
        as a donor you consent to donate your organs and tissues at the time of your death.
        Organs and tissues will be recovered for the purpose of transplantation, however,
        in the event a donated organ or tissue cannot be used for transplant, an effort
        will be made to use the donation for research.</div>
    <div style="z-index: 131; left: 4px; position: absolute; top: 223px">
        <strong>Registration Section: </strong>
    </div>
    <div style="z-index: 128; left: 4px; position: absolute; top: 531px">
        <strong>Residential Address </strong>(Must be in New England):
    </div>
    <div style="z-index: 129; left: 4px; position: absolute; top: 655px">
        <strong>Contact Information: </strong>
    </div>
    <div style="z-index: 130; left: 4px; position: absolute; top: 756px">
        <strong>Last four digits of your Social Security Number </strong>(for ID verification
        purposes only):
    </div>
    <div style="z-index: 132; left: 4px; position: absolute; top: 832px">
        <strong>Limitations: </strong>
    </div>
    <div style="z-index: 134; left: 9px; width: 475px; position: absolute; top: 853px;
        height: 46px">
        If there are specific organs
        and tissues you do NOT wish to donate, list them here.
        Also, indicate here if you do not wish your donation to be used for research.</div>
    <div style="z-index: 135; left: 139px; width: 261px; position: absolute; top: 717px;
        height: 15px">
        (for confirmation of your donor registration)</div>
    <div style="z-index: 136; left: 6px; width: 490px; position: absolute; top: 1204px;
        height: 49px; text-align: center;">
        <strong>Please click on the "Submit Information" button below to continue with the registration
            process.</strong></div>
    <igmisc:WebAsyncRefreshPanel ID="WebAsyncRefreshPanel1" runat="server" Height="53px"
    Style="z-index: 100; left: 132px; position: absolute; top: 275px" Width="364px" LinkedRefreshControlID="ctl00$WebAsyncRefreshPanel2" TriggerPostBackIDs="*$rdoAdd,*$rdoRemove">
    
        <asp:RadioButton ID="rdoAdd" runat="server" Font-Size="10pt" GroupName="rdoRegistrationSelection"
         Style="z-index: 102; left: 13px;
        position: absolute; top: 6px" Text="Add Myself to the Registry /Update My Record" TabIndex="1" OnCheckedChanged="rdoAdd_CheckedChanged" AutoPostBack="True" />

    <asp:RadioButton ID="rdoRemove" runat="server" Font-Size="10pt" GroupName="rdoRegistrationSelection"
         Style="z-index: 100; left: 13px;
        position: absolute; top: 28px" Text="Remove Myself from the Registry" TabIndex="2" OnCheckedChanged="rdoRemove_CheckedChanged" AutoPostBack="True" />
    
    </igmisc:WebAsyncRefreshPanel>
    <div style="z-index: 137; left: 6px; position: absolute; top: 341px">
        <strong>
        Your Full Name</strong> (Enter legal name as it might appear on your government issued ID):</div>
    <div style="z-index: 138; left: 64px; position: absolute; top: 402px">
        *Last Name:</div>
    <asp:TextBox ID="txtLastName" runat="server" Style="z-index: 101; left: 144px; position: absolute;
        top: 396px" Width="300px" TabIndex="4" MaxLength="25"></asp:TextBox><asp:Label ID="lblFirstName" runat="server" Style="z-index: 102; left: 62px; position: absolute;
        top: 374px" Text="*First Name:" Width="77px"></asp:Label>
    <asp:TextBox ID="txtFirstName" runat="server" MaxLength="20" Style="z-index: 103;
        left: 145px; position: absolute; top: 369px" Width="300px" TabIndex="3"></asp:TextBox>
    <asp:Label ID="lblSelectOne" runat="server" Style="z-index: 104; left: 60px; position: absolute;
        top: 249px" Text="*Select One:"></asp:Label>
    <asp:Label ID="lblMiddleName" runat="server" Style="z-index: 105; left: 58px; position: absolute;
        top: 428px" Text="Middle Name:" Width="83px"></asp:Label>
    <asp:TextBox ID="txtMiddleName" runat="server" Style="z-index: 106; left: 144px;
        position: absolute; top: 423px" Width="300px" TabIndex="5" MaxLength="20"></asp:TextBox>
    <asp:Label ID="lblGender" runat="server" Style="z-index: 107; left: 75px; position: absolute;
        top: 464px" Text="*Gender:"></asp:Label>
    <asp:RadioButton ID="rdoMale" runat="server" GroupName="rdoGender" Style="z-index: 108;
        left: 144px; position: absolute; top: 461px" Text="Male" TabIndex="6" />
    <asp:RadioButton ID="rdoFemale" runat="server" GroupName="rdoGender" Style="z-index: 109;
        left: 213px; position: absolute; top: 461px" Text="Female" TabIndex="7" />
    <asp:Label ID="lblDateOfBirth" runat="server" Style="z-index: 110; left: 47px; position: absolute;
        top: 495px" Text="*Date of Birth:"></asp:Label>
    <asp:Label ID="lblStreetAddress" runat="server" Style="z-index: 111; left: 35px;
        position: absolute; top: 566px" Text="*Street Address:"></asp:Label>
    <asp:Label ID="lblAddress2" runat="server" Style="z-index: 112; left: 74px; position: absolute;
        top: 591px" Text="Address 2:"></asp:Label>
    <asp:Label ID="lblCityStateZip" runat="server" Style="z-index: 113; left: 36px; position: absolute;
        top: 615px" Text="*City, State, Zip:"></asp:Label>
    &nbsp;
    <asp:TextBox ID="txtStreetAddress" runat="server" Style="z-index: 114; left: 142px;
        position: absolute; top: 560px" Width="300px" TabIndex="9" MaxLength="40"></asp:TextBox>
    <asp:Button ID="btnRegisterNow" runat="server" Style="z-index: 115; left: 164px;
        position: absolute; top: 1259px" Text="Submit Information" OnClick="btnRegisterNow_Click" TabIndex="30" />
    &nbsp;
    <asp:TextBox ID="txtAddress2" runat="server" Style="z-index: 116; left: 142px; position: absolute;
        top: 586px" Width="300px" TabIndex="10" MaxLength="20"></asp:TextBox>
    <asp:TextBox ID="txtCity" runat="server" Style="z-index: 117; left: 142px; position: absolute;
        top: 612px" Width="130px" TabIndex="11" MaxLength="25"></asp:TextBox>
    <asp:TextBox ID="txtZip" runat="server" Style="z-index: 118; left: 362px; position: absolute;
        top: 613px" Width="80px" TabIndex="13" MaxLength="10"></asp:TextBox>
    <asp:TextBox ID="txtEmailAddress" runat="server" Style="z-index: 119; left: 138px;
        position: absolute; top: 682px" Width="300px" TabIndex="14" MaxLength="100"></asp:TextBox>
    <asp:Label ID="lblEmailAddress" runat="server" Style="z-index: 120; left: 33px; position: absolute;
        top: 688px" Text="*Email Address:"></asp:Label>
    <asp:Label ID="lblLastFourSSN" runat="server" Style="z-index: 121; left: 37px; position: absolute;
        top: 797px" Text="*Last four SS#:"></asp:Label>
    <asp:TextBox ID="txtLastFourSSN" runat="server" MaxLength="4" Style="z-index: 122;
        left: 136px; position: absolute; top: 793px" Width="70px" TabIndex="15"></asp:TextBox>
    <asp:TextBox ID="txtLimitations" runat="server" Height="84px" MaxLength="200" Style="z-index: 123;
        left: 32px; position: absolute; top: 911px" TextMode="MultiLine" Width="436px" TabIndex="16"></asp:TextBox>
    &nbsp; &nbsp; &nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;
    <igsch:webdatechooser id="ddlDOB" runat="server" style="z-index: 124; left: 142px;
        position: absolute; top: 493px" width="160px" TabIndex="8" EnableAppStyling="False" Height="8px" NullDateLabel="" NullValueRepresentation="Null">
        <CalendarLayout DropDownYearsNumber="100">
        </CalendarLayout>
    </igsch:webdatechooser>
    &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
    &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;
   
     <igmisc:WebAsyncRefreshPanel ID="WebAsyncRefreshPanel2" runat="server" Height="192px"
        Style="z-index: 125; left: 5px; position: absolute; top: 1004px"
        Width="485px"> 
           &nbsp;
    <asp:Label ID="lblEventCategory" runat="server" Text="*" Width="130px" Height="20px" style="left: 12px; position: absolute; top: 96px; z-index: 102;"></asp:Label>
    <asp:Label ID="lblCategorySpecifyText" runat="server" Style="left: 39px;
        position: absolute; top: 66px; z-index: 103;" Text="Please Specify:" Width="92px" Visible="False"></asp:Label>
    <asp:Label ID="lblSubCategorySpecifyText" runat="server" Style="left: 36px;
        position: absolute; top: 121px; z-index: 104;" Text="Please Specify:" Width="92px" Visible="False"></asp:Label>
    <asp:TextBox ID="txtSubCategorySpecifyText" runat="server" Style="left: 164px;
        position: absolute; top: 122px; z-index: 105;" Width="300px" TabIndex="23" Visible="False"></asp:TextBox>
    <asp:TextBox ID="txtCategorySpecifyText" runat="server" Style="left: 163px;
        position: absolute; top: 64px; z-index: 106;" Width="300px" TabIndex="19" Visible="False"></asp:TextBox>
        <asp:Label ID="lblEventCategoryMessage" runat="server" Style="z-index: 107; left: 20px;
            position: absolute; top: 7px" Text="* How did you hear about the Donate Life New England Registry?"
            Width="438px"></asp:Label>
    <asp:TextBox ID="txtComments" runat="server" MaxLength="100" Style="z-index: 108;
        left: 163px; position: absolute; top: 151px" Width="300px" TabIndex="25"></asp:TextBox>
    <asp:Label ID="lblComment" runat="server" Style="z-index: 109; left: 2px; position: absolute;
        top: 154px" Text="Registering in memory of:" Width="150px"></asp:Label>
        &nbsp;&nbsp;
    <asp:DropDownList ID="mddlCategory" runat="server" AutoPostBack="True" Style="z-index: 125; 
        left: 164px; position: absolute; top: 35px" Width="300px" OnSelectedIndexChanged="mddlCategory_SelectedIndexChanged" TabIndex="17">
    </asp:DropDownList>
    <asp:DropDownList ID="mddlSubCategory" runat="server" Style="z-index: 140; left: 164px;
        position: absolute; top: 93px" Width="300px" AutoPostBack="True" OnSelectedIndexChanged="mddlSubCategory_SelectedIndexChanged" TabIndex="21">
    </asp:DropDownList>
        
        
    </igmisc:WebAsyncRefreshPanel>
    
    &nbsp;&nbsp;
    <asp:DropDownList ID="mddlState" runat="server" DataTextField="RegistryOwnerStateAbbrv"
        DataValueField="RegistryOwnerStateAbbrv" Style="z-index: 126; left: 283px; position: absolute;
        top: 613px" Width="69px" TabIndex="12">
        <asp:ListItem></asp:ListItem>
    </asp:DropDownList>
    <asp:Image ID="Image1" runat="server" Height="123px" ImageUrl="~/Register/images/neob_form_header.jpg"
        Style="z-index: 139; left: 4px; position: absolute; top: 5px" Width="586px" />
</div>
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;
