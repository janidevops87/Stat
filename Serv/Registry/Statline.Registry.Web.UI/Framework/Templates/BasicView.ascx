<%@ Register TagPrefix="uc1" TagName="MenuControl" Src="../Navigation/MenuControl.ascx" %>
<%@ Control CodeBehind="BasicView.ascx.cs" Language="c#" AutoEventWireup="True" Inherits="Statline.Registry.Web.UI.Framework.Templates.BasicView" %>
<%@ Register TagPrefix="mp" Namespace="Statline.StatTrac.Web.UI.MasterPages" Assembly="Statline.StatTrac.Web" %>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<mp:contentcontainer id="cC" MasterPageFile="~/Framework/Templates/BasicMaster.ascx" runat="server">
	<mp:content id="bCR" runat="server">
		<TABLE borderColor="red" height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
			<TR> <!-- Region Header-->
				<TD>
					<mp:region id="headerRegion" runat="server">
						<TABLE height="5" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<TR vAlign="top" align="left">
								<TD width="15" background='<%= ResolveUrl("~/images/leftTile.gif") %>'><IMG height="5" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
								<TD><IMG height="5" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
								<TD width="15" background='<%= ResolveUrl("~/images/rightTile.gif") %>'><IMG height="5" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							</TR>
						</TABLE>
						<TABLE cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<TR vAlign="top" align="left">
								<TD width="15" background='<%= ResolveUrl("~/images/leftTile.gif") %>'><IMG height="15" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
								<TD vAlign=middle >								
								     <!-- use Table to center titelLabel -->
								     <TABLE ForeColor="#000000" border="0" width="100%">
										<TR  valign=middle>
                                            <TD background='<%= ResolveUrl("~/images/headerBkgrd01-Tile.gif") %>' >	
												&nbsp;<asp:Label id="titleLabel" runat="server" ForeColor="#000000" Font-Bold="false" Font-Size="32pt" Font-Names="Book Antiqua"></asp:Label>
											</TD>
											<TD background='<%= ResolveUrl("~/images/headerBkgrd01-Tile.gif") %>' width="40" align="center">
											    <img  src='<%= ResolveUrl("~/images/Logos/statline.bmp") %>' > 
												<!-- <IMG height="40" src='<%= ResolveUrl("~/images/Logos/statline.jpg") %>' border="0">-->
											</TD>
										</TR>
									</TABLE></TD>
								<TD width="205" background='<%= ResolveUrl("~/images/headerBkgrd01-Tile.gif") %>'>
								    <IMG height="65" src='<%= ResolveUrl("~/images/headerBkgrd03.gif") %>' width="205"> 								
								</TD>
								<TD width="15" background='<%= ResolveUrl("~/images/rightTile.gif") %>'><IMG height="15" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							</TR>
						</TABLE>
						<TABLE height="1" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<TR vAlign="top" align="left">
								<TD width="15" background='<%= ResolveUrl("~/images/leftTile.gif") %>'><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
								<TD><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
								<TD width="15" background='<%= ResolveUrl("~/images/rightTile.gif") %>'><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							</TR>
						</TABLE>
						<!-- Date and Time Label -->
						<TABLE height="17" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0" bordercolor=lime>
							<TR vAlign="top" align="left">
								<TD width="15" background='<%= ResolveUrl("~/images/leftTile.gif") %>'><IMG height="15" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
								<TD width="335" background='<%= ResolveUrl("~/images/headerBkgrd02-Tile.gif") %>'>
									<IMG height="17" src='<%= ResolveUrl("~/images/headerBkgrd04.gif") %>' width="335"></TD>
								<TD class="Date" bgColor="#804D4D" align ="right">&nbsp;
									<asp:Label ID="displayNameLabel" Runat="server"></asp:Label>
									&nbsp;
									<asp:Label id="dateTimeLabel" Runat="server" ></asp:Label>                                    
                                    </TD>
                                    <td style="background-color: #804D4D; padding-top: 1px; padding-left: 5px; width: 40px;"><asp:Label ID="LogoutLabel" Runat="server"><a href='<%= ResolveUrl("~/Logout.aspx") %>' class="Date">Logout</a></asp:Label></td>
								<TD width="5" bgColor="#804D4D"><IMG height="5" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="5"></TD>
								<TD width="15" background='<%= ResolveUrl("~/images/rightTile.gif") %>'><IMG height="15" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							</TR>
						</TABLE>
						<TABLE height="1" cellSpacing="0" cellPadding="0" width="100%" bgColor="#000000" border="0">
							<TR vAlign="top" align="left">
								<TD width="15" background='<%= ResolveUrl("~/images/leftTile.gif") %>'><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
								<TD><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
								<TD width="15" background='<%= ResolveUrl("~/images/rightTile.gif") %>'><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							</TR>
						</TABLE>
					</mp:region>
					<uc1:MenuControl id="menuControl" runat="server"></uc1:MenuControl></TD>
			</TR>
			<TR> <!-- Region Main Page -->
				<TD height="100%">
					<TABLE borderColor="purple" height="100%" cellSpacing="0" cellPadding="0" width="100%"
						bgColor="#ffffff" border="0">
						<TR vAlign="top" align="left">
							<TD width="15" background='<%= ResolveUrl("~/images/leftTile.gif") %>'><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD width="1" bgColor="#000000"><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="1"></TD>
							<TD width="15"><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD vAlign="bottom" width="100%"><BR>
								<mp:region id="breadCrumbRegion" runat="server">
									<cc1:BreadCrumb id="breadCrumb" runat="server" CssClass="BreadCrumb" ImageUrl='<%= ResolveUrl("~/images/Menu/Marker01.gif") %>'></cc1:BreadCrumb>
								</mp:region></TD>
							<TD width="15"><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD width="1" bgColor="#000000"><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="1"></TD>
							<TD width="15" background='<%= ResolveUrl("~/images/rightTile.gif") %>'><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
						</TR>
						<TR vAlign="top" align="left">
							<TD width="15" background='<%= ResolveUrl("~/images/leftTile.gif") %>'><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD width="1" bgColor="#000000"><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="1"></TD>
							<TD width="15"><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD align="left">
								<mp:region id="validationErrorRegion" runat="server">
									<cc1:DataListMessageCollection id="dataListMessageCollection" runat="server"></cc1:DataListMessageCollection>
									<asp:ValidationSummary id="validationSummary" runat="server" ForeColor="" CssClass="Error"></asp:ValidationSummary>
								</mp:region></TD>
							<TD width="15"><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD width="1" bgColor="#000000"><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="1"></TD>
							<TD width="15" background='<%= ResolveUrl("~/images/rightTile.gif") %>'><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
						</TR>
						<TR vAlign="top" align="left" height="100%">
							<TD width="15" background='<%= ResolveUrl("~/images/leftTile.gif") %>'><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD width="1" bgColor="#000000"><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="1"></TD>
							<TD width="15"><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD width="100%" height="100%">
								<TABLE height="100%" cellSpacing="0" cellPadding="0" width="100%" border="0">
									<TR>
										<TD vAlign="top" width="100%">
											<mp:region id="cR" runat="server">&nbsp;</mp:region>
										</TD>
									</TR>
								</TABLE>
							</TD>
							<TD width="15"><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD width="1" bgColor="#000000"><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="1"></TD>
							<TD width="15" background='<%= ResolveUrl("~/images/rightTile.gif") %>'><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD>
					<TABLE height="100%" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
						<TR vAlign="top" align="left">
							<TD width="15" background='<%= ResolveUrl("~/images/leftTile.gif") %>'><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD width="1" bgColor="#000000"><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="1"></TD>
							<TD width="15"><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD vAlign="bottom" align="center" width="100%">
								<mp:region id="footerRegion" runat="server" >©1996-<%=currentYear%> Statline, A Division of MTF, All rights reserved.</mp:region>
							</TD>
							<TD vAlign="bottom" height="100%"></TD>
							<TD width="15"><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
							<TD width="1" bgColor="#000000"><IMG height="1" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="1"></TD>
							<TD width="15" background='<%= ResolveUrl("~/images/rightTile.gif") %>'><IMG height="10" src='<%= ResolveUrl("~/images/spacer.gif") %>' width="15"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
		</TABLE>
	</mp:content>
</mp:contentcontainer>