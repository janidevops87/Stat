<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EnrollmentMobileControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.Dynamic.EnrollmentMobileControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls" TagPrefix="StatTrac" %>


<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>

<script language="javascript" type="text/javascript">

    function textMaxLength(obj, maxLength, evt) {
        var charCode = (evt.which) ? evt.which : event.keyCode
        var max = maxLength - 1;
        var text = obj.value;
        if (text.length > max) {
            var ignoreKeys = [8, 46, 37, 38, 39, 40, 35, 36];
            for (i = 0; i < ignoreKeys.length; i++) {
                if (charCode == ignoreKeys[i]) {
                    return true;
                }
            }
            return false;
        } else {
            return true;
        }
    } 
</script>


<div class="RegistryMainMobile" id="DIV1">
    <asp:HiddenField ID="hdnRegistryOwnerRouteName" runat="server"  Value="None" />
    <asp:HiddenField ID="hdnRegistryOwnerID" runat="server" />
    <asp:HiddenField ID="hdnLanguageCode" runat="server" />
    <asp:HiddenField ID="hdnAllowDisplayNoDonors" runat="server" />
    <asp:HiddenField ID="hdnCSSFileLocation" runat="server" />
    <div id="divImageHeader" runat="server" class="RegistryImageMobile">
    <asp:Image ID="Image1" runat="server" Width="586px" Height="123px" ImageUrl="~/Register/images/neob_form_header.jpg"
        cssClass="RegistryImageMobile" />
        </div>
    <div id="divInstruction" runat="server" class="RegistryInstructionMobile">
        Please fill out the form below to register as an organ and tissue donor. By registering
        as a donor you consent to donate your organs and tissues at the time of your death.
        Organs and tissues will be recovered for the purpose of transplantation, however,
        in the event a donated organ or tissue cannot be used for transplant, an effort
        will be made to use the donation for research.
    </div>
    <div id="divRegistrationSelection" runat="server" class="RegistryTitleMobile"><strong>Registration Section: </strong></div>
	<div id="selectOne" Class="RegistryRequiredMobile">
		<asp:Label ID="lblSelectOne" runat="server" Text="*Select One:"></asp:Label>
	</div>
	<asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
		<div id="registrationSelection" Class="RegistryHiddenMobile">
				<asp:RadioButton ID="rdoAdd" runat="server" GroupName="rdoRegistrationSelection" 
					Text="Add Myself to the Registry /Update My Record" TabIndex="1" OnCheckedChanged="rdoAdd_CheckedChanged" AutoPostBack="True" />
		</div>
		<div id="registrationSelection" Class="RegistryHiddenMobile">
				<asp:RadioButton ID="rdoRemove" runat="server" GroupName="rdoRegistrationSelection" 
					Text="Remove Myself from the Registry" TabIndex="2" OnCheckedChanged="rdoRemove_CheckedChanged" AutoPostBack="True" />
		</div>
	        </ContentTemplate>
    </asp:UpdatePanel>



	<div id="LabelFirstName" runat="server" class="RegistryLabelMobile">
        <asp:Label ID="lblFirstName" runat="server" Text="First name:"></asp:Label>
    <div id="divFirstNameInstruction" runat="server">
		(Enter legal name as it might appear on your government issued ID):
		</div></div>
		
	<div id="TextBoxFirstName" Class="RegistryInputMobile">
		    <asp:TextBox ID="txtFirstName" runat="server" MaxLength="20" Width="100%" TabIndex="3"></asp:TextBox>
		</div>
        <!-- Middle Name Not used on Mobile -->
	    <div id="LabelMiddleName" Class="RegistryHiddenMobile">
		    <asp:Label ID="lblMiddleName" runat="server" Text="Middle name:"></asp:Label>
		    </div>
   	    <div id="TextBoxMiddleName" Class="RegistryHiddenMobile">
		    <asp:TextBox ID="txtMiddleName" runat="server" Width="100%" TabIndex="4" MaxLength="20"></asp:TextBox>
		    </div> 
	<div id="LabelLastName" Class="RegistryLabelMobile" runat="server">
		<asp:Label ID="lblLastName" runat="server" Text="Last Name:" ></asp:Label>
    <div id="divLastNameInstruction" runat="server">
		(Enter legal name as it might appear on your government issued ID):
		</div>
		</div>
	<div id="TextBoxLastName" Class="RegistryInputMobile">
		<asp:TextBox ID="txtLastName" runat="server" Width="100%" TabIndex="5" MaxLength="25"></asp:TextBox>
		</div>
	<div id="LabelGender" Class="RegistryLabelMobile">
		<asp:Label ID="lblGender" runat="server" Text="*Gender:"></asp:Label>
		</div>
	<div id="ControlGender" Class="RegistryInputMobile">
        <div>
		    <asp:RadioButton ID="rdoMale" runat="server" GroupName="rdoGender" Text="Male" TabIndex="6" Width="109px" />
        </div>
        <div>
		    <asp:RadioButton ID="rdoFemale" runat="server" GroupName="rdoGender" Text="Female" TabIndex="7" Width="92px" />
        </div>
		</div>
	<div id="LabelDOB" Class="RegistryLabelMobile">
		<asp:Label ID="lblDateOfBirth" runat="server" Text="*Date of Birth:"></asp:Label>
		</div>
	<div id="ControlDOB" Class="RegistryInputMobile">
		<asp:TextBox input type="date" id="ddlDOB" name="ddlDOB" runat="server" Width="100%" TabIndex="8" MaxLength="10"/></asp:TextBox>
    </div>
	<div id="LabelStreetAddress" Class="RegistryLabelMobile">
		<asp:Label ID="lblStreetAddress" runat="server" Text="*Street Address:" ></asp:Label>
		</div>
	<div id="ControlStreetAddress" Class="RegistryInputMobile">
		<asp:TextBox ID="txtStreetAddress" runat="server" Width="100%" TabIndex="9" MaxLength="40"></asp:TextBox>
		</div>
    <div id="divResidentialAddress" runat="server" class="RegistryLabelMobile"><strong>City</strong>
		</div>
    <div id="ControlCity" Class="RegistryInputMobile">
		<asp:TextBox ID="txtCity" runat="server" Width="100%" TabIndex="11" MaxLength="25"></asp:TextBox>
        </div>
	<div id="LabelAddress2" Class="RegistryLabelMobile">
		<asp:Label ID="lblAddress2" runat="server" Text="State"></asp:Label>
		</div>
	<div id="ControlState" Class="RegistryInputMobile">
	    <div>
        <asp:DropDownList ID="cboState" runat="server" 
			DataTextField="RegistryOwnerStateAbbrv"
			DataValueField="RegistryOwnerStateAbbrv" Width="95%" TabIndex="12">
			<asp:ListItem></asp:ListItem>
		</asp:DropDownList></div>
        </div>
	                <div id="ControlAddress2" Class="RegistryHiddenMobile">
		                <asp:TextBox ID="txtAddress2" runat="server" Width="20%" TabIndex="10" MaxLength="20"></asp:TextBox>
		                </div>
	<div id="LabelCityStateZip" Class="RegistryLabelMobile">
		<asp:Label ID="lblCityStateZip" runat="server" Text="Zip Code" ></asp:Label>
		</div>
    <div id="ControlZipCode" Class="RegistryInputMobile">
		<asp:TextBox ID="txtZip" runat="server" Width="100%" TabIndex="13" MaxLength="10"></asp:TextBox>
	</div>
	<div id="LabelEmailAddress" Class="RegistryLabelMobile">
		<asp:Label ID="lblEmailAddress" runat="server" Text="*Email" ></asp:Label>
        <div id="divEmailConfirmation" runat="server">
        (for confirmation of your donor registration)
		</div>
		</div>
	<div id="ControlEmailAddress" Class="RegistryInputMobile">
		    <asp:TextBox ID="txtEmailAddress" runat="server" Width="100%" TabIndex="14" MaxLength="100"></asp:TextBox>
		</div>
	<div id="LabelLicenseOrStateId" Class="RegistryLabelMobile">
		<asp:Label ID="lblLicenseOrStateID" runat="server" ></asp:Label>
		</div>
	<div id="ControlLicenseOrStateId" Class="RegistryInputBox">
		    <asp:TextBox ID="txtLicenseOrStateID" runat="server" Width="100%" TabIndex="15" MaxLength="9"></asp:TextBox>
		</div>

	<div id="LabelLastFourSSN" Class="RegistryLabelMobile" runat="server">
		<asp:Label ID="lblLastFourSSN" runat="server" Text="*Last four SS#:"></asp:Label>
        
        <div id="divSSN" runat="server">
            <strong>Last four digits of your Social Security Number </strong>(for ID verification purposes only):
        </div>
        </div>

	<div id="ControlLastFourSSN" Class="RegistryInputMobile">
		<asp:TextBox ID="txtLastFourSSN" runat="server" MaxLength="4" Width="100%" TabIndex="16"></asp:TextBox>
	</div>

    <div id="divContactInformation" runat="server" class="RegistryHiddenMobile"><strong>Contact Information: </strong>
	</div>
   
	<div id="LabelLimitations" runat="server" class="RegistryLabelMobile">
        <asp:Label ID="lblLimitations" runat="server" Text="Limitations"></asp:Label>
    <div id="divLimitationsInstructions" runat="server" >
        If there are specific organs
        and tissues you do NOT wish to donate, list them here.
        Also, indicate here if you do not wish your donation to be used for research.
		</div>
        </div>

	<div id="ControlLimitations" Class="RegistryInputMobile">
		    <asp:TextBox ID="txtLimitations" runat="server" Height="50px" MaxLength="200" TextMode="MultiLine" Width="95%" TabIndex="17"></asp:TextBox>
		</div>

    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
		<div id="LabelEventCategoryMessage" Class="RegistryLabelMobile">
			<asp:Label ID="lblEventCategoryMessage" runat="server" Text="How did you hear about the Donate Life New England Registry?" ></asp:Label>
			</div>
		<div id="ControlEventCategory" Class="RegistryInputMobile">
			<asp:DropDownList ID="cboCategory" runat="server" AutoPostBack="True" Width="95%" OnSelectedIndexChanged="cboCategory_SelectedIndexChanged" TabIndex="18">
			</asp:DropDownList>
			</div>
		<div id="LabelCategorySpecifyText" Class="RegistryHiddenMobile">
			<asp:Label ID="lblCategorySpecifyText" runat="server" Text="Please Specify:" Visible="False"></asp:Label>
			</div>
		<div id="ControlCategorySpecifyText" Class="RegistryHiddenMobile">
			<asp:TextBox ID="txtCategorySpecifyText" runat="server" Width="100%" TabIndex="19" Visible="False"></asp:TextBox>
			</div>
		<div id="LabelEventCategory" Class="RegistryHiddenMobile">
			<asp:Label ID="lblEventCategory" runat="server" Text="*" ></asp:Label>			
			</div>
		<div id="ControlSubCategory" Class="RegistryHiddenMobile">
			<asp:DropDownList ID="cboSubCategory" runat="server" Width="290px" AutoPostBack="True" OnSelectedIndexChanged="cboSubCategory_SelectedIndexChanged" TabIndex="21">
			</asp:DropDownList>
			</div>
		<div id="LabelSubCategorySpecifyText" Class="RegistryHiddenMobile" >
			<asp:Label ID="lblSubCategorySpecifyText" runat="server" Text="Please Specify:" Visible="False"></asp:Label>
			</div>
		<div id="ControlSubCategorySpecifyText" Class="RegistryHiddenMobile ">
			<asp:TextBox ID="txtSubCategorySpecifyText" runat="server" Width="290px" TabIndex="23" Visible="False"></asp:TextBox>
			</div>
		<div id="LabelComment" class="RegistryHiddenMobile">
			<asp:Label ID="lblComment" runat="server" Text="Registering in memory of:" ></asp:Label>
			</div>
		<div id="ControlComments" class="RegistryHiddenMobile">
			<asp:TextBox ID="txtComments" runat="server" MaxLength="100" Width="100px" TabIndex="25" ></asp:TextBox>
			</div>
            </ContentTemplate>
    </asp:UpdatePanel>

    <div id="divInformationContacts" runat="server" class="RegistryInformationContactsMobile">
		</div>
 		&nbsp;&nbsp;
    <div id="divSubmitInstructions" runat="server" class="RegistryHiddenMobile">
        <strong>Please click on the "Submit Information" button below to continue with the registration process.</strong>
		</div>
    <div id="ControlSubmit" runat="server" class="RegistryButtonMobile">
		<asp:Button ID="btnRegisterNow" runat="server" Text="Submit" Height="50px" Font-Size=".8em" OnClick="btnRegisterNow_Click" TabIndex="30" />
		<asp:Button ID="btnClear" runat="server" Text="Clear" Width="100px" Height="50px" Font-Size=".8em" OnClick= "btnClearForm_Click" TabIndex="31" />
		</div>
    <div id="divFooter" runat="server" class="RegistryHiddenMobile">
        </div>
</div>

