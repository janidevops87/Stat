<%@ Control language="c#" Codebehind="AdministrationControl.ascx.cs" AutoEventWireup="True" Inherits="Statline.StatTrac.Web.UI.Controls.Admin.AdministrationControl" %>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<TABLE id="Table5" cellSpacing="0" cellPadding="3" border="1">
	<TR>
		<TD noWrap>Board Refresh Interval (minutes)</TD>
		<TD noWrap></TD>
	</TR>
	<TR>
		<TD noWrap>
			<asp:TextBox id="optionTextBox" Width="200px" runat="server" MaxLength="50"></asp:TextBox>
			<asp:RequiredFieldValidator id="rfvStatusName" CssClass="error" runat="server" ErrorMessage="Urgency Threshold is required."
				ForeColor=" " ControlToValidate="optionTextBox">*</asp:RequiredFieldValidator>
			<asp:CompareValidator id="cvUrgencyThreshold" runat="server" ControlToValidate="optionTextBox" ForeColor=" "
				ErrorMessage="Urgency Threshold must be a number." CssClass="error" Operator="DataTypeCheck" Type="Integer">*</asp:CompareValidator>
			<asp:RangeValidator id="rvOption" runat="server" ControlToValidate="optionTextBox" ForeColor=" " ErrorMessage="The Board Refresh Interval (minutes) must be between 1 and 60 minutes."
				CssClass="error">*</asp:RangeValidator></TD>
		<TD noWrap>
			<cc1:LinkButtonTexture id="saveButton" CssClass="ButtonText" Text="Search" runat="server" CommandArgument="0" onclick="saveButton_Click">Save</cc1:LinkButtonTexture></TD>
	</TR>
</TABLE>
