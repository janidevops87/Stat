<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EnrollmentControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

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
<div class="RegistryMain" id="DIV1">
    <asp:HiddenField ID="hdnRegistryOwnerRouteName" runat="server"  Value="None" />
    <asp:HiddenField ID="hdnRegistryOwnerID" runat="server" />
    <asp:HiddenField ID="hdnRegistryOwnerName" runat="server" />
    <asp:HiddenField ID="hdnLanguageCode" runat="server" />
    <asp:HiddenField ID="hdnAllowDisplayNoDonors" runat="server" />
    <asp:HiddenField ID="hdnCSSFileLocation" runat="server" />

    <asp:Image ID="Image1" runat="server" Width="586px" Height="123px" ImageUrl="~/Register/images/neob_form_header.jpg"
        cssClass="RegistrySection" />
    <div id="divInstruction" runat="server" class="RegistrySection">
        Please fill out the form below to register as an organ and tissue donor. By registering
        as a donor you consent to donate your organs and tissues at the time of your death.
        Organs and tissues will be recovered for the purpose of transplantation, however,
        in the event a donated organ or tissue cannot be used for transplant, an effort
        will be made to use the donation for research.
    </div>
    <div id="divRegistrationSelection" runat="server" class="RegistrySection"><strong>Registration Section: </strong></div>
	<div id="selectOne" Class="RegistrySection">
		<asp:Label ID="lblSelectOne" runat="server" Text="*Select One:"></asp:Label>
	    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        	<div id="registrationSelection" Class="RegistryControlIndent">
				<asp:RadioButton ID="rdoAdd" runat="server" GroupName="rdoRegistrationSelection" 
					Text="Add Myself to the Registry /Update My Record" TabIndex="1" OnCheckedChanged="rdoAdd_CheckedChanged" AutoPostBack="True" />
		    </div>
		    <div id="registrationSelection" Class="RegistryControlIndent">
				    <asp:RadioButton ID="rdoRemove" runat="server" GroupName="rdoRegistrationSelection" 
					    Text="Remove Myself from the Registry" TabIndex="2" OnCheckedChanged="rdoRemove_CheckedChanged" AutoPostBack="True" />
		    </div>
            </ContentTemplate>
            
        </asp:UpdatePanel>
	</div>
	
    <div id="divNameInstruction" runat="server" Class="RegistrySection">
		<strong>Your Full Name</strong> (Enter legal name as it might appear on your government issued ID):
		</div>
    <div id="divFirstName">
	    <div id="LabelFirstName" Class="RegistryLabel">
		    <asp:Label ID="lblFirstName" runat="server" Text="First Name:" ></asp:Label>
	    </div>
    	<div id="TextBoxFirstName" Class="RegistryTextBox">
	    	<asp:TextBox ID="txtFirstName" runat="server" MaxLength="20" Width="300px" TabIndex="3" autocomplete="off"></asp:TextBox>
		</div></div>
    <div id="divMiddleName">
	    <div id="LabelMiddleName" Class="RegistryLabel">
		    <asp:Label ID="lblMiddleName" runat="server" Text="Middle name:"></asp:Label>
		</div>
        <div id="TextBoxMiddleName" Class="RegistryTextBox">
		<asp:TextBox ID="txtMiddleName" runat="server" Width="300px" TabIndex="4" MaxLength="20" autocomplete="off"></asp:TextBox>
		</div></div>
   	<div id="div_LastName">
    	<div id="divLastName" Class="RegistryLabel" runat="server">*Last Name:
		</div>
	    <div id="TextBoxLastName" Class="RegistryTextBox">
		    <asp:TextBox ID="txtLastName" runat="server" Width="300px" TabIndex="5" MaxLength="25" autocomplete="off"></asp:TextBox>
		</div></div>
    <div id="divGender">
	    <div id="LabelGender" Class="RegistryLabel">
		    <asp:Label ID="lblGender" runat="server" Text="*Gender:"></asp:Label>
		</div>
	    <div id="ControlGender" Class="RegistryTextBox">
		    <asp:RadioButton ID="rdoMale" runat="server" GroupName="rdoGender" Text="Male" TabIndex="6" Width="109px" />
		    <asp:RadioButton ID="rdoFemale" runat="server" GroupName="rdoGender" Text="Female" TabIndex="7" Width="92px" />
		</div></div>
    <div id="divDOB">
	<div id="LabelDOB" Class="RegistryLabel">
		<asp:Label ID="lblDateOfBirth" runat="server" Text="*Date of Birth:"></asp:Label>
		</div>
	<div id="ControlDOB" Class="RegistryTextBox">
        <asp:TextBox ID="ddlDOB" runat="server" TabIndex="8"></asp:TextBox>
		</div></div>
	<div id="divResidentialAddress" runat="server" class="RegistrySection"><strong>Residential Address </strong>(Must be in New England):
		</div>
    <div id="divStreetAddress">
	<div id="LabelStreetAddress" Class="RegistryLabel">
		<asp:Label ID="lblStreetAddress" runat="server" Text="*Street Address:" ></asp:Label>
		</div>
	<div id="ControlStreetAddress" Class="RegistryTextBox">
		<asp:TextBox ID="txtStreetAddress" runat="server" Width="300px" TabIndex="9" MaxLength="40" autocomplete="off"></asp:TextBox>
		</div></div>
    <div id="divAddress2">
	<div id="LabelAddress2" Class="RegistryLabel">
		<asp:Label ID="lblAddress2" runat="server" Text="Adress 2:" ></asp:Label>
		</div>
	<div id="ControlAddress2" Class="RegistryTextBox">
		<asp:TextBox ID="txtAddress2" runat="server" Width="300px" TabIndex="10" MaxLength="20" autocomplete="off"></asp:TextBox>
		</div></div>
    <div id="divCityStateZip">
	<div id="LabelCityStateZip" Class="RegistryLabel">
		<asp:Label ID="lblCityStateZip" runat="server" Text="*City, State, Zip:" ></asp:Label>
		</div>
	<div id="ControlCityStateZip" Class="RegistryTextBox">
		<asp:TextBox ID="txtCity" runat="server" Width="130px" TabIndex="11" MaxLength="25" autocomplete="off"></asp:TextBox>
	    <asp:DropDownList ID="cboState" runat="server" 
			DataTextField="RegistryOwnerStateAbbrv"
			DataValueField="RegistryOwnerStateAbbrv" Width="69px" TabIndex="12">
			<asp:ListItem></asp:ListItem>
		</asp:DropDownList>
		<asp:TextBox ID="txtZip" runat="server" Width="80px" TabIndex="13" MaxLength="10" autocomplete="off"></asp:TextBox>
	</div>
	<div id="divCityStateZipText" runat="server" class="RegistryControlIndentText">
        (state comments)
		</div>
    <div id="divContactInformation" runat="server" class="RegistrySection"><strong>Contact Information: </strong>
		</div></div>
	<div id="LabelEmailAddress" Class="RegistryLabel">
		<asp:Label ID="lblEmailAddress" runat="server" Text="*Email Address:" ></asp:Label>
		</div>
	<div id="ControlEmailAddress" Class="RegistryTextBox">
		    <asp:TextBox ID="txtEmailAddress" runat="server" Width="300px" TabIndex="14" MaxLength="100" autocomplete="off"></asp:TextBox>
		</div>
	<div id="divEmailConfirmation" runat="server" class="RegistryControlIndent">
        (for confirmation of your donor registration)
		</div>

    <div id="divStateIdInformation" runat="server" class="RegistrySection"><strong>License Information: </strong>
		</div>
	<div id="LabelLicenseOrStateId" Class="RegistryLabel">
		<asp:Label ID="lblLicenseOrStateID" runat="server" Text="*Driver License or StateId Information:" ></asp:Label>
		</div>
	<div id="ControlLicenseOrStateId" Class="RegistryTextBox">
		    <asp:TextBox ID="txtLicenseOrStateID" runat="server" Width="300px" TabIndex="15" MaxLength="20" autocomplete="off"></asp:TextBox>
		</div>
    <div id="divSSN" runat="server" class="RegistrySection">
        <strong>Last four digits of your Social Security Number </strong>(for ID verification purposes only):
    </div>
    <div id="divSSN">
	<div id="LabelLastFourSSN" Class="RegistryLabel">
		<asp:Label ID="lblLastFourSSN" runat="server" Text="*Last four SS#:" Width="90px"></asp:Label>
	</div>
	<div id="ControlLastFourSSN" Class="RegistryTextBox">
		<asp:TextBox ID="txtLastFourSSN" runat="server" MaxLength="4" Width="70px" TabIndex="16" autocomplete="off"></asp:TextBox>
	</div></div>
	<div id="divLimitations" runat="server" class="RegistrySection">
        <strong>Limitations: </strong>
		</div>
    <div id="divLimitationsInstructions" runat="server" class="RegistryNotes">
        If there are specific organs
        and tissues you do NOT wish to donate, list them here.
        Also, indicate here if you do not wish your donation to be used for research.
		</div>
	<div id="ControlLimitations" Class="RegistryLimitations">
		    <asp:TextBox ID="txtLimitations" runat="server" Height="84px" MaxLength="200" TextMode="MultiLine" Width="436px" TabIndex="17" autocomplete="off"></asp:TextBox>
		</div>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <div id="divEventCategory">
        
		<div id="LabelEventCategoryMessage" Class="RegistrySection">
			<asp:Label ID="lblEventCategoryMessage" runat="server" Text="How did you hear about the Donate Life New England Registry?" ></asp:Label>
			</div>
		<div id="ControlEventCategory" Class="RegistryControlIndent">
			<asp:DropDownList ID="cboCategory" runat="server" AutoPostBack="True" Width="290px" OnSelectedIndexChanged="cboCategory_SelectedIndexChanged" TabIndex="18">
			</asp:DropDownList>
			</div></div>
		<div id="LabelCategorySpecifyText" Class="RegistryLabel">
			<asp:Label ID="lblCategorySpecifyText" runat="server" Text="Please Specify:" Visible="False"></asp:Label>
			</div>
		<div id="ControlCategorySpecifyText" Class="RegistryTextBox">
			<asp:TextBox ID="txtCategorySpecifyText" runat="server" Width="290px" TabIndex="19" Visible="False" autocomplete="off"></asp:TextBox>
			</div>
        <div id="divSubCategory">
		<div id="LabelEventCategory" Class="RegistryLabel">
			<asp:Label ID="lblEventCategory" runat="server" Text="*" ></asp:Label>			
			</div>
		<div id="ControlSubCategory" Class="RegistryTextBox">
			<asp:DropDownList ID="cboSubCategory" runat="server" Width="290px" AutoPostBack="True" OnSelectedIndexChanged="cboSubCategory_SelectedIndexChanged" TabIndex="21">
			</asp:DropDownList>
			</div></div>
        <div id="divSubCategorySpecify">
		<div id="LabelSubCategorySpecifyText" Class="RegistryLabel" >
			<asp:Label ID="lblSubCategorySpecifyText" runat="server" Text="Please Specify:" Visible="False"></asp:Label>
			</div>
		<div id="ControlSubCategorySpecifyText" Class="RegistryTextBox ">
			<asp:TextBox ID="txtSubCategorySpecifyText" runat="server" Width="290px" TabIndex="23" Visible="False" autocomplete="off"></asp:TextBox>
			</div> </div>
        <div id="divComments">
		<div id="LabelComment" Class="RegistryLabel">
			<asp:Label ID="lblComment" runat="server" Text="Registering in memory of:" ></asp:Label>
			</div>
		<div id="ControlComments" Class="RegistryTextBox">
			<asp:TextBox ID="txtComments" runat="server" MaxLength="100" Width="290px" TabIndex="25" autocomplete="off"></asp:TextBox>
			</div></div>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="rdoAdd" EventName="OnCheckChanged" />
            <asp:AsyncPostBackTrigger ControlID="rdoRemove" EventName="OnCheckChanged" />
        </Triggers>
        </asp:UpdatePanel>
 		&nbsp;&nbsp;
    <div id="divInformationContacts" runat="server" class="RegistryNotes">
		</div>
 		&nbsp;&nbsp;
    <div id="divSubmitInstructions" runat="server" class="RegistrySubmit">
		&nbsp;&nbsp;
        <strong>Please click on the "Submit Information" button below to continue with the registration process.</strong>
		</div>
    <div id="ControlSubmit" runat="server" class="RegistrySubmit">
		<asp:Button ID="btnRegisterNow" runat="server" Text="Submit Information" OnClick="btnRegisterNow_Click" TabIndex="30" />
		</div>
 		&nbsp;&nbsp;
    <div id="divFooter" runat="server" class="RegistryFooter">
        </div>
</div>
&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;
