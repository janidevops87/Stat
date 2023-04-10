<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Control Language="c#" AutoEventWireup="True" Codebehind="LoginControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.LoginControl" targetSchema="http://schemas.microsoft.com/intellisense/ie3-2nav3-0" enableViewState="False"%>
<%@ Import namespace="Statline.StatTrac.Web.UI"%>

<TABLE id="loginOuterTable" cssclass="PageBorder" cellSpacing="0" cellPadding="10" width="100%"
	border="0">
	<TR>
		<TD><cc1:sectionheader id="topSectionHeader" CssClass="SectionHeader" Text="Statline Reports Login"
				runat="server"></cc1:sectionheader></TD>
	</TR>
	<TR>
		<TD>
			<TABLE id="loginInnterTable" cellSpacing="1" cellPadding="1" width="100%" border="0">
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD width="35%"></TD>
					<TD>
						<TABLE id="loginTable" cellSpacing="1" cellPadding="1" width="100%" border="0">
							<TR>
								<TD width="20%">
									<DIV ms_positioning="FlowLayout">
										<TABLE height="15" cellSpacing="0" cellPadding="0" width="70" border="0" ms_1d_layout="TRUE">
											<TR>
												<TD>User&nbsp;Name:</TD>
											</TR>
										</TABLE>
									</DIV>
								</TD>
								<TD width="80%">
									<asp:textbox id="txtUserName" cssClass="InputText" runat="server" onkeypress="javascript:LogInKeyPressEvent();"></asp:textbox>
									<asp:requiredfieldvalidator id="rfvUsername" runat="server" CssClass="error" ForeColor="" Display="Dynamic"
										ControlToValidate="txtUserName" ErrorMessage="Username is required" EnableClientScript="False" DESIGNTIMEDRAGDROP="13">*</asp:requiredfieldvalidator>
								</TD>
							</TR>
							<TR>
								<TD>
									<DIV ms_positioning="FlowLayout">
										<TABLE height="15" cellSpacing="0" cellPadding="0" width="70" border="0" ms_1d_layout="TRUE">
											<TR>
												<TD>Password:</TD>
											</TR>
										</TABLE>
									</DIV>
								</TD>
								<TD>
									<asp:textbox id="txtPassword" cssClass="InputText" runat="server" TextMode="Password" onkeypress="javascript:LogInKeyPressEvent();"></asp:textbox>
									<asp:requiredfieldvalidator id="rfvPassword" runat="server" EnableClientScript="False" ErrorMessage="Password is required"
										ControlToValidate="txtPassword" Display="Dynamic" ForeColor="" CssClass="error">*</asp:requiredfieldvalidator>
								</TD>
							</TR>
							<TR>
								<TD></TD>
								<TD>
                                    <asp:Button ID="btnLogin" runat="server" OnClick="btnLogin_ServerClick" Text="Login"
                                        Width="60px" />
                                    <INPUT id="btnCancel" type="button" value="Cancel" runat="server" style="width: 60px">
								</TD>
							</TR>
						</TABLE>
					</TD>
					<TD width="35%"></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
				<TR>
					<TD></TD>
					<TD></TD>
					<TD></TD>
				</TR>
			</TABLE>
		</TD>
	</TR>
	<TR>
		<TD></TD>
	</TR>
</TABLE>
<script language="javascript">
	<!--
			function LogInKeyPressEvent()
			{				
				if (event.keyCode == 13)
				{
					//call the btnLogin event
					//__doPostBack('ctl00_ctl00_bCR_cR_LoginControl_btnLogin','');
					__doPostBack('<%= btnLogin.ClientID %>', '');
				}
			}		
		-->
</script>