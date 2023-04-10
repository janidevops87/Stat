<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsRegistryDonorDesignationStatus.ascx.cs" Inherits="Statline.StatTac.Web.UI.Controls.CustomParamsRegistryDonorDesignationStatus" %>
<div class="SectionSeperator" >
    <div class="ParamControlLabel">
    Donor Designation Status:
    </div>
    <div class="ParamControl">
        <div class="ParamCheckBoxLeftAlign">	        
            <asp:CheckBox id="chkBoxNewYes" runat="server" Checked="True" EnableViewState="False" TextAlign="Right" Text="New Yes'"></asp:CheckBox>
        <br />
            <asp:CheckBox id="chkBoxYesToYes" runat="server" Checked="True" EnableViewState="False" TextAlign="Right" Text="Yes to Yes"></asp:CheckBox> 
        <br />
            <asp:CheckBox id="chkBoxNoToYes" runat="server" Checked="True" EnableViewState="False" TextAlign="Right" Text="No to Yes"></asp:CheckBox> 
        <br />
            <asp:CheckBox id="chkBoxTotalYes" runat="server" Checked="True" EnableViewState="False" TextAlign="Right" Text="Total Yes'"></asp:CheckBox> 
        <br />
            <asp:CheckBox id="chkBoxYesToNo" runat="server" Checked="True" EnableViewState="False" TextAlign="Right" Text="Yes to No"></asp:CheckBox> 
        </div>
    </div>
</div>    