<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="LoginFailureControl.ascx.cs" Inherits="Statline.Registry.Web.UI.Controls.LoginFailureControl" %>
<asp:Label ID="lblFailureNotice" runat="server" Font-Names="Arial" Font-Size="12pt"
    ForeColor="Red" Height="77px" Style="z-index: 100; left: 65px; position: relative;
    top: 76px" Text="Three unsuccessful login attempts have been reached." Width="299px"></asp:Label>
