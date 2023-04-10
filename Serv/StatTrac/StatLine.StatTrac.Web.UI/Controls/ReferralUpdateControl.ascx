<%@ Control Language="C#" AutoEventWireup="true" Codebehind="ReferralUpdateControl.ascx.cs"
    Inherits="Statline.StatTrac.Web.UI.Controls.ReferralUpdateControl" %>
<%@ Register TagPrefix="uc" TagName="callHeaderControl" Src="CallHeaderControl.ascx" %>
<%@ Register Assembly="Infragistics4.WebUI.UltraWebGrid.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>
<script language="javascript">
    function GettxtApproacherChangeNote()
    {
        return '<%=  txtApproacherChangeNote.ClientID %>';
    }
    function EnableApproacherReason()
	{
	var txtClientId = GettxtApproacherChangeNote();
					   
	    var txtApproacherChangeNoteCtlID = document.getElementById(txtClientId);
		txtApproacherChangeNoteCtlID.disabled = false;
	}
	function GettxtRecoveryOutcome()
    {
        return '<%=  txtRecoveryOutcome.ClientID %>';
    }
    function EnableRecoveryOutcome()
	{
	var txtClientId = GettxtRecoveryOutcome();
					   
	    var RecoveryOutcomeCtlID = document.getElementById(txtClientId);
		RecoveryOutcomeCtlID.disabled = false;
	}
</script>   
<StatTrac:SectionHeader ID="sectionHeaderUpdateReferral" runat="server" Text="Update Referral"
    Width="100%"></StatTrac:SectionHeader>
<asp:ObjectDataSource ID="odsReferralSingle" runat="server" TypeName="Statline.StatTrac.Referral.ReferralManager"
	SelectMethod="FillReferralSingle" OnSelected="odsReferralSingle_Selected" EnableCaching="True">
    <SelectParameters>
        <asp:Parameter DefaultValue="0" Name="CallID" Type="Int32" />
        <asp:Parameter DefaultValue="194" Name="UserOrgID" Type="Int32" />
        <asp:Parameter DefaultValue="" Name="reportGroupID" Type="Int32" />
        <asp:Parameter DefaultValue="MT" Name="timeZone" Type="String" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsApproacherList" runat="server" SelectMethod="FillApproacherList"
	TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelected="odsApproacherList_Selected" EnableCaching="True">
    <SelectParameters>
        <asp:Parameter Name="CallID" Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsApproacherTypeList" runat="server" SelectMethod="FillApproacherTypeList"
	TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelected="odsApproacherTypeList_Selected" EnableCaching="True">
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsAppropriate" runat="server" SelectMethod="FillAppropriateList"
	TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelected="odsAppropriate_Selected" EnableCaching="True">
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsApproach" runat="server" SelectMethod="FillApproachList"
	TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelected="odsApproach_Selected" EnableCaching="True">
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsConsent" runat="server" SelectMethod="FillConsentList"
	TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelected="odsConsent_Selected" EnableCaching="True">
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsRecovery" runat="server" SelectMethod="FillRecoveryList"
	TypeName="Statline.StatTrac.Referral.ReferralManager" OnSelected="odsRecovery_Selected" EnableCaching="True">
</asp:ObjectDataSource>

<uc:callHeaderControl runat="server" ID="callHeaderCtl"  />

<div style="position: relative; width: 780px; height: 140px; left: 0px; top: 0px; z-index: 104;" id="divMain">
    <asp:Label ID="lblCallDT" runat="server" Style="position: absolute; z-index: 100; left: 5px; top: -23px;" Text="Call D/T:"></asp:Label>
    <asp:Label ID="lblCallDT1" runat="server" Style="position: absolute; z-index: 101; left: 65px; top: -23px;"></asp:Label>
    <asp:Label ID="lblMOA" runat="server" Style="position: absolute; z-index: 102; left: 20px; top: 30px;" Text="Method of Approach:"></asp:Label>
    <asp:Label ID="Label1" runat="server" Style="position: absolute; z-index: 103; left: 470px; top: 5px;" Text="Approacher Change Reason:"></asp:Label>
    <asp:Label ID="lblConsent" runat="server" Style="position: absolute; z-index: 104; left: 20px; top: 80px;" Text="Consent:"></asp:Label>
    <asp:Label ID="lblAppro" runat="server" Style="position: absolute; z-index: 105; left: 20px; top: 55px;" Text="Approacher:"></asp:Label>


    <asp:DropDownList ID="ddlMOA" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" Style="position: absolute; z-index: 106; left: 160px; top: 30px;"
        Width="275px" DataSourceID="odsApproacherTypeList" DataTextField="ApproachTypeName"
        DataValueField="ApproachTypeID" OnPreRender="GetApproachType" OnSelectedIndexChanged="GetApproachTypeChanged"
        AutoPostBack="True">
    </asp:DropDownList>
    <asp:DropDownList ID="ddlApproacher" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" Style="position: absolute; z-index: 107; left: 160px; top: 55px;" Width="275px" DataSourceID="odsApproacherList" DataTextField="approacher"
        DataValueField="PersonID" OnSelectedIndexChanged="GetApproacherChanged" OnPreRender="GetApproacher" 
        AutoPostBack="True">
    </asp:DropDownList>
    <asp:DropDownList ID="ddlConsent" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Solid" BorderWidth="1px" ForeColor="Black" OnPreRender="GetConsent"
        Style="position: absolute; z-index: 108; left: 160px; top: 80px;" Width="275px" AppendDataBoundItems="true">
    </asp:DropDownList>
    <asp:TextBox ID="txtApproacherChangeNote" runat="server" BackColor="White" BorderColor="Silver"
        BorderStyle="Inset" BorderWidth="1px" Enabled="False" ForeColor="Black" Height="70px"
        MaxLength="1000" Style="position: absolute; z-index: 109; left: 465px; top: 30px;"
        TextMode="MultiLine" Width="295px" Wrap="true"></asp:TextBox>
    <asp:Label ID="lblSourceCodeName" runat="server" Visible="False" style="z-index: 111; left: 210px; position: absolute; top: 0px"></asp:Label>
</div>
<!--
<table style=" left: 330px; position: relative; top: 200px ; width: 490px;">
    <tr>
        <td style="width: 108px; height: 21px;">
            <asp:Label ID="lblRefFac" runat="server" Style="  position: relative;
                top: 0px" Text="Referral Facility:" Width="105px"></asp:Label>
        </td>
        <td style="width: 388px; height: 21px;">
            <asp:Label ID="lblRefFac1" runat="server" Style=" position: relative;
             left: 115px;  top: 0px" Width="280px"></asp:Label>
        </td>
       
        
    </tr>
    <tr>
        <td style="width: 108px; height: 21px;">
            <asp:Label ID="lblPatient" runat="server" Style=" position: relative;
                top: 25px" Text="Patient:"></asp:Label>
        </td>
        <td style="width: 388px; height: 21px;">
            <asp:Label ID="lblPatientInfo" runat="server" Style=" position: relative;
                left: 115px; top: 25px" Width="145px"></asp:Label>
             <asp:Label ID="lblASR" runat="server" Style=" position: relative;
                left: 265px; top: 25px; "  Width="90px"></asp:Label>    
        </td>
              
    </tr>
</table>-->
<igtbl:UltraWebGrid ID="gridAppropriate" runat="server" DataSourceID="odsReferralSingle"
    Style="" Height="60px"
    OnDataBound="UltraWebGrid1_DataBound">
    <Bands>
        <igtbl:UltraGridBand AddButtonCaption="ReferralSingle" BaseTableName="ReferralSingle"
            Key="ReferralSingle" AllowDelete="No">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="AppropriateText" IsBound="True" Key="AppropriateText">
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AppropriateOrgan" IsBound="True" Key="AppropriateOrgan">
                    <Header Caption="Organ">
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AppropriateBone" IsBound="True" Key="AppropriateBone">
                    <Header Caption="Bone">
                        <RowLayoutColumnInfo OriginX="2" />
                    </Header>
                    <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AppropriateTissue" IsBound="True" Key="AppropriateTissue">
                    <Header Caption="Tissue">
                        <RowLayoutColumnInfo OriginX="3" />
                    </Header>
                    <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AppropriateSkin" IsBound="True" Key="AppropriateSkin">
                    <Header Caption="Skin">
                        <RowLayoutColumnInfo OriginX="4" />
                    </Header>
                    <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="4" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AppropriateValve" IsBound="True" Key="AppropriateValve">
                    <Header Caption="Valves">
                        <RowLayoutColumnInfo OriginX="5" />
                    </Header>
                    <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="5" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AppropriateEyes" IsBound="True" Key="AppropriateEyes">
                    <Header Caption="Eyes">
                        <RowLayoutColumnInfo OriginX="6" />
                    </Header>
                    <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="6" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="CallDateTime" Hidden="True" IsBound="True"
                    Key="CallDateTime">
                    <Header>
                        <RowLayoutColumnInfo OriginX="7" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="7" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="InitialApproachType" Hidden="True" IsBound="True"
                    Key="InitialApproachType">
                    <Header>
                        <RowLayoutColumnInfo OriginX="8" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="8" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="InitialApproacher" Hidden="True" IsBound="True"
                    Key="InitialApproachType">
                    <Header>
                        <RowLayoutColumnInfo OriginX="9" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="9" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="InitialOutcome" Hidden="True" IsBound="True"
                    Key="InitialOutcome">
                    <Header>
                        <RowLayoutColumnInfo OriginX="10" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="10" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessOrgans" Hidden="True" IsBound="True"
                    Key="AccessOrgans">
                    <Header>
                        <RowLayoutColumnInfo OriginX="11" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="11" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessBone" Hidden="True" IsBound="True" Key="AccessBone">
                    <Header>
                        <RowLayoutColumnInfo OriginX="12" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="12" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessTissue" Hidden="True" IsBound="True"
                    Key="AccessTissue">
                    <Header>
                        <RowLayoutColumnInfo OriginX="13" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="13" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessSkin" Hidden="True" IsBound="True" Key="AccessSkin">
                    <Header>
                        <RowLayoutColumnInfo OriginX="14" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="14" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessValves" Hidden="True" IsBound="True"
                    Key="AccessValves">
                    <Header>
                        <RowLayoutColumnInfo OriginX="15" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="15" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessEyes" Hidden="True" IsBound="True" Key="AccessEyes">
                    <Header>
                        <RowLayoutColumnInfo OriginX="16" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="16" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessOrgansupdate" Hidden="True" IsBound="True"
                    Key="AccessOrgansupdate">
                    <Header>
                        <RowLayoutColumnInfo OriginX="17" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="17" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessBoneupdate" Hidden="True" IsBound="True"
                    Key="AccessBoneupdate">
                    <Header>
                        <RowLayoutColumnInfo OriginX="18" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="18" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessTissueupdate" Hidden="True" IsBound="True"
                    Key="AccessTissueupdate">
                    <Header>
                        <RowLayoutColumnInfo OriginX="19" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="19" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessSkinupdate" Hidden="True" IsBound="True"
                    Key="AccessSkinupdate">
                    <Header>
                        <RowLayoutColumnInfo OriginX="20" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="20" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessValvesupdate" Hidden="True" IsBound="True"
                    Key="AccessValvesupdate">
                    <Header>
                        <RowLayoutColumnInfo OriginX="21" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="21" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessEyesupdate" Hidden="True" IsBound="True"
                    Key="AccessEyesupdate">
                    <Header>
                        <RowLayoutColumnInfo OriginX="22" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="22" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ApproachTypeID" Hidden="True" IsBound="True"
                    Key="ApproachTypeID">
                    <Header>
                        <RowLayoutColumnInfo OriginX="23" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="23" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessResearch" Hidden="True" IsBound="True"
                    Key="AccessResearch">
                    <Header>
                        <RowLayoutColumnInfo OriginX="24" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="24" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AccessResearchupdate" Hidden="True" IsBound="True"
                    Key="AccessResearchupdate">
                    <Header>
                        <RowLayoutColumnInfo OriginX="25" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="25" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="AppropriateOther" IsBound="True" Key="AppropriateOther">
                    <Header Caption="Other">
                        <RowLayoutColumnInfo OriginX="26" />
                    </Header>
                    <CellStyle HorizontalAlign="Center">
                        </CellStyle>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="26" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelApproachOrgan" Hidden="True" IsBound="True"
                    Key="ServiceLevelApproachOrgan">
                    <Header>
                        <RowLayoutColumnInfo OriginX="27" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="27" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelApproachBone" Hidden="True" IsBound="True"
                    Key="ServiceLevelApproachBone">
                    <Header>
                        <RowLayoutColumnInfo OriginX="28" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="28" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelApproachTissue" Hidden="True"
                    IsBound="True" Key="ServiceLevelApproachTissue">
                    <Header>
                        <RowLayoutColumnInfo OriginX="29" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="29" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelApproachSkin" Hidden="True" IsBound="True"
                    Key="ServiceLevelApproachSkin">
                    <Header>
                        <RowLayoutColumnInfo OriginX="30" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="30" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelApproachValves" Hidden="True"
                    IsBound="True" Key="ServiceLevelApproachValves">
                    <Header>
                        <RowLayoutColumnInfo OriginX="31" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="31" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelApproachEyes" Hidden="True" IsBound="True"
                    Key="ServiceLevelApproachEyes">
                    <Header>
                        <RowLayoutColumnInfo OriginX="32" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="32" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelApproachRsch" Hidden="True" IsBound="True"
                    Key="ServiceLevelApproachRsch">
                    <Header>
                        <RowLayoutColumnInfo OriginX="33" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="33" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelConsentOrgan" Hidden="True" IsBound="True"
                    Key="ServiceLevelConsentOrgan">
                    <Header>
                        <RowLayoutColumnInfo OriginX="34" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="34" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelConsentBone" Hidden="True" IsBound="True"
                    Key="ServiceLevelConsentBone">
                    <Header>
                        <RowLayoutColumnInfo OriginX="35" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="35" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelConsentTissue" Hidden="True" IsBound="True"
                    Key="ServiceLevelConsentTissue">
                    <Header>
                        <RowLayoutColumnInfo OriginX="36" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="36" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelConsentSkin" Hidden="True" IsBound="True"
                    Key="ServiceLevelConsentSkin">
                    <Header>
                        <RowLayoutColumnInfo OriginX="37" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="37" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelConsentValves" Hidden="True" IsBound="True"
                    Key="ServiceLevelConsentValves">
                    <Header>
                        <RowLayoutColumnInfo OriginX="38" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="38" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelConsentEyes" Hidden="True" IsBound="True"
                    Key="ServiceLevelConsentEyes">
                    <Header>
                        <RowLayoutColumnInfo OriginX="39" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="39" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelConsentRsch" Hidden="True" IsBound="True"
                    Key="ServiceLevelConsentRsch">
                    <Header>
                        <RowLayoutColumnInfo OriginX="40" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="40" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelRecoveryOrgan" Hidden="True" IsBound="True"
                    Key="ServiceLevelRecoveryOrgan">
                    <Header>
                        <RowLayoutColumnInfo OriginX="41" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="41" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelRecoveryBone" Hidden="True" IsBound="True"
                    Key="ServiceLevelRecoveryBone">
                    <Header>
                        <RowLayoutColumnInfo OriginX="42" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="42" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelRecoveryTissue" Hidden="True"
                    IsBound="True" Key="ServiceLevelRecoveryTissue">
                    <Header>
                        <RowLayoutColumnInfo OriginX="43" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="43" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelRecoverySkin" Hidden="True" IsBound="True"
                    Key="ServiceLevelRecoverySkin">
                    <Header>
                        <RowLayoutColumnInfo OriginX="44" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="44" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelRecoveryValves" Hidden="True"
                    IsBound="True" Key="ServiceLevelRecoveryValves">
                    <Header>
                        <RowLayoutColumnInfo OriginX="45" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="45" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelRecoveryEyes" Hidden="True" IsBound="True"
                    Key="ServiceLevelRecoveryEyes">
                    <Header>
                        <RowLayoutColumnInfo OriginX="46" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="46" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ServiceLevelRecoveryRsch" Hidden="True" IsBound="True"
                    Key="ServiceLevelRecoveryRsch">
                    <Header>
                        <RowLayoutColumnInfo OriginX="47" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="47" />
                    </Footer>
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="PersonID" Hidden="True" IsBound="True"
                    Key="PersonID">
                    <Header>
                        <RowLayoutColumnInfo OriginX="48" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="48" />
                    </Footer>
                </igtbl:UltraGridColumn>
            </Columns>
            <AddNewRow View="NotSet" Visible="NotSet">
            </AddNewRow>
        </igtbl:UltraGridBand>
    </Bands>
    <DisplayLayout Name="ctl00xgridAppropriate" RowHeightDefault="20px" SelectTypeRowDefault="Single"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" CellSpacingDefault="1" ScrollBar="Never">
        <FrameStyle BorderStyle="None" BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt"
            ForeColor="#A37171" Cursor="Default" Height="43px">
        </FrameStyle>
        <FooterStyleDefault BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
        </FooterStyleDefault>
        <HeaderStyleDefault BackColor="#6E1515" BorderStyle="Solid" BorderColor="Black" ForeColor="White">
            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
        </HeaderStyleDefault>
        <RowStyleDefault BackColor="#DBCACA" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
            Font-Names="Verdana" Font-Size="8pt">
            <Padding Left="3px" />
            <BorderDetails ColorLeft="219, 202, 202" ColorTop="219, 202, 202" />
        </RowStyleDefault>
        <AddNewBox>
            <BoxStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </BoxStyle>
        </AddNewBox>
        <ActivationObject BorderColor="Black" BorderWidth="">
        </ActivationObject>
        <FilterOptionsDefault>
            <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                Font-Size="11px" Width="200px">
                <Padding Left="2px" />
            </FilterDropDownStyle>
            <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
            </FilterHighlightRowStyle>
            <FilterOperandDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid"
                BorderWidth="1px" CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                Font-Size="11px">
                <Padding Left="2px" />
            </FilterOperandDropDownStyle>
        </FilterOptionsDefault>
        <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
        </SelectedRowStyleDefault>
    </DisplayLayout>
</igtbl:UltraWebGrid>
<igtbl:UltraWebGrid ID="gridApproach" runat="server" DataSourceID="odsReferralSingle"
  Height="20px" OnDataBound="gridApproach_DataBound" Width="125px">
     <Bands>
        <igtbl:UltraGridBand AddButtonCaption="ReferralSingle" BaseTableName="ReferralSingle"
            Key="ReferralSingle" Hidden="True" AllowDelete="No">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="ApproachText" IsBound="True" Key="ApproachText">
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ApproachOrgan" IsBound="True" Key="ApproachOrgan"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="ApproachBone" IsBound="True" Key="ApproachBone"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="ApproachTissue" IsBound="True" Key="ApproachTissue"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="ApproachSkin" IsBound="True" Key="ApproachSkin"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="4" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="4" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="ApproachValve" IsBound="True" Key="ApproachValve"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="5" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="5" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="ApproachEyes" IsBound="True" Key="ApproachEyes"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="6" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="6" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="ApproachOther" IsBound="True" Key="ApproachOther"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="7" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="7" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
            </Columns>
            <AddNewRow View="NotSet" Visible="NotSet">
            </AddNewRow>
            
        </igtbl:UltraGridBand></Bands>
        
    
    <DisplayLayout Name="ctl00xgridApproach" RowHeightDefault="20px" SelectTypeRowDefault="Single"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" CellSpacingDefault="1" ScrollBar="Never">
        <FrameStyle BorderStyle="None" BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt"
            ForeColor="#A37171" Cursor="Default" Height="20px" Width="125px">
        </FrameStyle>
        <FooterStyleDefault BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
        </FooterStyleDefault>
        <HeaderStyleDefault BackColor="#6E1515" BorderStyle="Solid" BorderColor="Black" ForeColor="White"
            Height="0px">
            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
        </HeaderStyleDefault>
        <RowStyleDefault BackColor="#DBCACA" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
            Font-Names="Verdana" Font-Size="8pt">
            <Padding Left="3px" />
            <BorderDetails ColorLeft="219, 202, 202" ColorTop="219, 202, 202" />
        </RowStyleDefault>
        <AddNewBox>
            <BoxStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </BoxStyle>
        </AddNewBox>
        <ActivationObject BorderColor="Black" BorderWidth="">
        </ActivationObject>
        <FilterOptionsDefault>
            <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                Font-Size="11px" Width="200px">
                <Padding Left="2px" />
            </FilterDropDownStyle>
            <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
            </FilterHighlightRowStyle>
            <FilterOperandDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid"
                BorderWidth="1px" CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                Font-Size="11px">
                <Padding Left="2px" />
            </FilterOperandDropDownStyle>
        </FilterOptionsDefault>
        <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
        </SelectedRowStyleDefault>
    </DisplayLayout>
</igtbl:UltraWebGrid>
<div id="divApproach" style="position: relative; background-color:#DBCACA; left: 125px; width: 708px; top: -18px;
    height: 10px; z-index: 103;" >
     <asp:DropDownList ID="ddlApproachOrgan" runat="server" DataSourceID="odsApproach" DataTextField="ApproachName" 
         DataValueField="ApproachID" Enabled="false" AutoPostBack="true"
         AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentApproachOrganChanged"
         OnDataBound="GetCurrentApproachOrgan" Style="position: relative; top: 0px; left: 5px;" Width="95px">
    </asp:DropDownList>
    <asp:DropDownList ID="ddlApproachBone" runat="server" DataSourceID="odsApproach"
        DataTextField="ApproachName" DataValueField="ApproachID" Enabled="false" AutoPostBack="true"
        AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentApproachBoneChanged"
        OnDataBound="GetCurrentApproachBone" Style="position: relative; top: 0px; left: 5px;" Width="95px">
    </asp:DropDownList>
    <asp:DropDownList ID="ddlApproachTissue" runat="server" DataSourceID="odsApproach"
        DataTextField="ApproachName" DataValueField="ApproachID" Enabled="false" AutoPostBack="true"
        AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentApproachTissueChanged"
        OnDataBound="GetCurrentApproachTissue" Style="position: relative; top: 0px; left: 5px;" Width="95px">
    </asp:DropDownList>
    <asp:DropDownList ID="ddlApproachSkin" runat="server" DataSourceID="odsApproach"
                            DataTextField="ApproachName" DataValueField="ApproachID" Enabled="false" AutoPostBack="true"
                            AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentApproachSkinChanged"
                            OnDataBound="GetCurrentApproachSkin" Style="position: relative;
                            top: 0px; left: 10px;" Width="95px">
    </asp:DropDownList>
    <asp:DropDownList ID="ddlApproachValve" runat="server" DataSourceID="odsApproach"
                            DataTextField="ApproachName" DataValueField="ApproachID" Enabled="false" AutoPostBack="true"
                            AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentApproachValveChanged"
                            OnDataBound="GetCurrentApproachValve" Style="position: relative;
                            top: 0px; left: 10px;" Width="100px">
                        </asp:DropDownList>                    
   <asp:DropDownList ID="ddlApproachEyes" runat="server" DataSourceID="odsApproach"
                            DataTextField="ApproachName" DataValueField="ApproachID" Enabled="false" AutoPostBack="true"
                            AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentApproachEyesChanged"
                            OnDataBound="GetCurrentApproachEyes" Style="position: relative;
                            top: 0px; left: 10px;" Width="95px">
                        </asp:DropDownList>
   <asp:DropDownList ID="ddlApproachOther" runat="server" DataSourceID="odsApproach"
                            DataTextField="ApproachName" DataValueField="ApproachID" Enabled="false" AutoPostBack="true"
                            AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentApproachOtherChanged"
                            OnDataBound="GetCurrentApproachOther" Style="position: relative;
                            top: 0px; left: 15px;" Width="95px">
                        </asp:DropDownList>                     
                                             
</div>
<div id="divConsent" style="position: relative; background-color:#DBCACA; left: 125px; width: 708px; top: -18px;
    height: 10px; z-index: 100;" >
     <asp:DropDownList ID="ddlConsentOrgan" runat="server" DataSourceID="odsConsent" DataTextField="ConsentName"
                            DataValueField="ConsentID" Enabled="false" AutoPostBack="true" AppendDataBoundItems="true"
                            OnSelectedIndexChanged="GetCurrentConsentOrganChanged" OnDataBound="GetCurrentConsentOrgan"
                            Style="position: relative; top: 0px; left: 5px;" Width="95px">
                        </asp:DropDownList>
    <asp:DropDownList ID="ddlConsentBone" runat="server" DataSourceID="odsConsent" DataTextField="ConsentName"
                            DataValueField="ConsentID" Enabled="false" AutoPostBack="true" AppendDataBoundItems="true"
                            OnSelectedIndexChanged="GetCurrentConsentBoneChanged" OnDataBound="GetCurrentConsentBone"
                            Style="position: relative; top: 0px; left: 5px;" Width="95px">
                        </asp:DropDownList>
   
    <asp:DropDownList ID="ddlConsentTissue" runat="server" DataSourceID="odsConsent"
                            DataTextField="ConsentName" DataValueField="ConsentID" Enabled="false" AutoPostBack="true"
                            AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentConsentTissueChanged"
                            OnDataBound="GetCurrentConsentTissue" Style="position: relative;
                            top: 0px; left: 5px;" Width="95px">
                        </asp:DropDownList>
    <asp:DropDownList ID="ddlConsentSkin" runat="server" DataSourceID="odsConsent" DataTextField="ConsentName"
                            DataValueField="ConsentID" Enabled="false" AutoPostBack="true" AppendDataBoundItems="true"
                            OnSelectedIndexChanged="GetCurrentConsentSkinChanged" OnDataBound="GetCurrentConsentSkin"
                            Style="position: relative; top: 0px; left: 10px;" Width="95px">
                        </asp:DropDownList>
    <asp:DropDownList ID="ddlConsentValve" runat="server" DataSourceID="odsConsent" DataTextField="ConsentName"
                            DataValueField="ConsentID" Enabled="false" AutoPostBack="true" AppendDataBoundItems="true"
                            OnSelectedIndexChanged="GetCurrentConsentValveChanged" OnDataBound="GetCurrentConsentValve"
                            Style="position: relative; top: 0px; left: 10px;" Width="100px">
                        </asp:DropDownList>               
   <asp:DropDownList ID="ddlConsentEyes" runat="server" DataSourceID="odsConsent" DataTextField="ConsentName"
                            DataValueField="ConsentID" Enabled="false" AutoPostBack="true" AppendDataBoundItems="true"
                            OnSelectedIndexChanged="GetCurrentConsentEyesChanged" OnDataBound="GetCurrentConsentEyes"
                            Style="position: relative; top: 0px; left: 10px;" Width="95px">
                        </asp:DropDownList>
  <asp:DropDownList ID="ddlConsentOther" runat="server" DataSourceID="odsConsent" DataTextField="ConsentName"
                            DataValueField="ConsentID" Enabled="false" AutoPostBack="true" AppendDataBoundItems="true"
                            OnSelectedIndexChanged="GetCurrentConsentOtherChanged" OnDataBound="GetCurrentConsentOther"
                            Style="position: relative; top: 0px; left: 15px;" Width="95px">
                        </asp:DropDownList>                  
                                             
</div>
<div style="z-index: 106; left: 0px; width: 125px; position: relative; top: -23px;
    height: 40px">
<igtbl:UltraWebGrid ID="gridConsent" runat="server" DataSourceID="odsReferralSingle"
     Height="20px"  Width="120px"  style=" left: 0px; position: absolute; top: -17px; z-index: 100;" >
    <Bands>
        <igtbl:UltraGridBand AddButtonCaption="ReferralSingle" BaseTableName="ReferralSingle"
            Key="ReferralSingle" AllowDelete="No">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="ConsentText" IsBound="True" Key="ConsentText">
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="ConsentOrgan" IsBound="True" Key="ConsentOrgan"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
               
                <igtbl:UltraGridColumn BaseColumnName="ConsentBone" IsBound="True" Key="ConsentBone"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Footer>
                </igtbl:UltraGridColumn>
               
                <igtbl:UltraGridColumn BaseColumnName="ConsentTissue" IsBound="True" Key="ConsentTissue"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Footer>
                </igtbl:UltraGridColumn>
               
                <igtbl:UltraGridColumn BaseColumnName="ConsentSkin" IsBound="True" Key="ConsentSkin"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="4" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="4" />
                    </Footer>
                </igtbl:UltraGridColumn>
               
                <igtbl:UltraGridColumn BaseColumnName="ConsentValve" IsBound="True" Key="ConsentValve"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="5" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="5" />
                    </Footer>
                </igtbl:UltraGridColumn>
               
                <igtbl:UltraGridColumn BaseColumnName="ConsentEyes" IsBound="True" Key="ConsentEyes"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="6" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="6" />
                    </Footer>
                </igtbl:UltraGridColumn>
               
                <igtbl:UltraGridColumn BaseColumnName="ConsentOther" IsBound="True" Key="ConsentOther"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="7" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="7" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
            </Columns>
            <AddNewRow View="NotSet" Visible="NotSet">
            </AddNewRow>
        </igtbl:UltraGridBand>
    </Bands>
    <DisplayLayout Name="ctl00xgridConsent" RowHeightDefault="20px" SelectTypeRowDefault="Single"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" CellSpacingDefault="1" ScrollBar="Never">
        <FrameStyle BorderStyle="None" BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt"
            ForeColor="#A37171" Cursor="Default" Height="20px" Width="125px">
        </FrameStyle>
        <FooterStyleDefault BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
        </FooterStyleDefault>
        <HeaderStyleDefault BackColor="#6E1515" BorderStyle="Solid" BorderColor="Black" ForeColor="White"
            Height="0px">
            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
        </HeaderStyleDefault>
        <RowStyleDefault BackColor="#DBCACA" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
            Font-Names="Verdana" Font-Size="8pt">
            <Padding Left="3px" />
            <BorderDetails ColorLeft="219, 202, 202" ColorTop="219, 202, 202" />
        </RowStyleDefault>
        <AddNewBox>
            <BoxStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </BoxStyle>
        </AddNewBox>
        <ActivationObject BorderColor="Black" BorderWidth="">
        </ActivationObject>
        <FilterOptionsDefault>
            <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                Font-Size="11px" Width="200px">
                <Padding Left="2px" />
            </FilterDropDownStyle>
            <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
            </FilterHighlightRowStyle>
            <FilterOperandDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid"
                BorderWidth="1px" CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                Font-Size="11px">
                <Padding Left="2px" />
            </FilterOperandDropDownStyle>
        </FilterOptionsDefault>
        <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
        </SelectedRowStyleDefault>
    </DisplayLayout>
</igtbl:UltraWebGrid>


<igtbl:UltraWebGrid ID="gridRecovery" runat="server" DataSourceID="odsReferralSingle"
     Height="20px"  Width="125px" style=" left: 0px; position: absolute; top: 4px; z-index: 102;">
    <Bands>
        <igtbl:UltraGridBand AddButtonCaption="ReferralSingle" BaseTableName="ReferralSingle"
            Key="ReferralSingle" AllowDelete="No">
            <Columns>
                <igtbl:UltraGridColumn BaseColumnName="RecoveryText" IsBound="True" Key="RecoveryText">
                </igtbl:UltraGridColumn>
                <igtbl:UltraGridColumn BaseColumnName="RecoveryOrgan" IsBound="True" Key="RecoveryOrgan"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="1" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="RecoveryBone" IsBound="True" Key="RecoveryBone"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="2" />
                    </Footer>
                </igtbl:UltraGridColumn>
              
                <igtbl:UltraGridColumn BaseColumnName="RecoveryTissue" IsBound="True" Key="RecoveryTissue"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="3" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="RecoverySkin" IsBound="True" Key="RecoverySkin"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="4" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="4" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="RecoveryValve" IsBound="True" Key="RecoveryValve"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="5" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="5" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="RecoveryEyes" IsBound="True" Key="RecoveryEyes"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="6" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="6" />
                    </Footer>
                </igtbl:UltraGridColumn>
                
                <igtbl:UltraGridColumn BaseColumnName="RecoveryOther" IsBound="True" Key="RecoveryOther"
                    Hidden="True">
                    <Header>
                        <RowLayoutColumnInfo OriginX="7" />
                    </Header>
                    <Footer>
                        <RowLayoutColumnInfo OriginX="7" />
                    </Footer>
                </igtbl:UltraGridColumn>
               
            </Columns>
            <AddNewRow View="NotSet" Visible="NotSet">
            </AddNewRow>
        </igtbl:UltraGridBand>
    </Bands>
    <DisplayLayout Name="ctl00xgridRecovery" RowHeightDefault="20px" SelectTypeRowDefault="Single"
        StationaryMarginsOutlookGroupBy="True" TableLayout="Fixed" Version="4.00" CellSpacingDefault="1" ScrollBar="Never">
        <FrameStyle BorderStyle="None" BorderWidth="1px" Font-Names="Verdana" Font-Size="8pt"
            ForeColor="#A37171" Cursor="Default" Height="20px" Width="125px">
        </FrameStyle>
        <FooterStyleDefault BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
        </FooterStyleDefault>
        <HeaderStyleDefault BackColor="#6E1515" BorderStyle="Solid" BorderColor="Black" ForeColor="White"
            Height="0px">
            <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
        </HeaderStyleDefault>
        <RowStyleDefault BackColor="#DBCACA" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
            Font-Names="Verdana" Font-Size="8pt">
            <Padding Left="3px" />
            <BorderDetails ColorLeft="219, 202, 202" ColorTop="219, 202, 202" />
        </RowStyleDefault>
        <AddNewBox>
            <BoxStyle BackColor="LightGray" BorderStyle="Solid" BorderWidth="1px">
                <BorderDetails ColorLeft="White" ColorTop="White" WidthLeft="1px" WidthTop="1px" />
            </BoxStyle>
        </AddNewBox>
        <ActivationObject BorderColor="Black" BorderWidth="">
        </ActivationObject>
        <FilterOptionsDefault>
            <FilterDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                Font-Size="11px" Width="200px">
                <Padding Left="2px" />
            </FilterDropDownStyle>
            <FilterHighlightRowStyle BackColor="#151C55" ForeColor="White">
            </FilterHighlightRowStyle>
            <FilterOperandDropDownStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid"
                BorderWidth="1px" CustomRules="overflow:auto;" Font-Names="Verdana,Arial,Helvetica,sans-serif"
                Font-Size="11px">
                <Padding Left="2px" />
            </FilterOperandDropDownStyle>
        </FilterOptionsDefault>
        <SelectedRowStyleDefault BackColor="#A10B0B" ForeColor="White">
        </SelectedRowStyleDefault>
    </DisplayLayout>
</igtbl:UltraWebGrid>
</div>

<div id="divRecovery" style="position: relative; background-color:#DBCACA; left: 125px; width: 708px; top: -58px;
    height: 10px; z-index: 102;" >
     <asp:DropDownList ID="ddlRecoveryOrgan" runat="server" DataSourceID="odsRecovery"
                            DataTextField="ConversionName" DataValueField="ConversionID" AutoPostBack="true"
                            Enabled="false" AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentRecoveryOrganChanged"
                            OnDataBound="GetCurrentRecoveryOrgan"
                            Style="position: relative; top: 0px; left: 5px;" Width="95px">
                        </asp:DropDownList>
   <asp:DropDownList ID="ddlRecoveryBone" runat="server" DataSourceID="odsRecovery"
                            DataTextField="ConversionName" DataValueField="ConversionID" AutoPostBack="true"
                            Enabled="false" AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentRecoveryBoneChanged"
                            OnDataBound="GetCurrentRecoveryBone"
                            Style="position: relative; top: 0px; left: 5px;" Width="95px">
                        </asp:DropDownList>
   
    <asp:DropDownList ID="ddlRecoveryTissue" runat="server" DataSourceID="odsRecovery"
                            DataTextField="ConversionName" DataValueField="ConversionID" AutoPostBack="true"
                            Enabled="false" AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentRecoveryTissueChanged"
                            OnDataBound="GetCurrentRecoveryTissue" Style="position: relative;
                            top: 0px; left: 5px;" Width="95px">
                        </asp:DropDownList>
    <asp:DropDownList ID="ddlRecoverySkin" runat="server" DataSourceID="odsRecovery"
                            DataTextField="ConversionName" DataValueField="ConversionID" AutoPostBack="true"
                            Enabled="false" AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentRecoverySkinChanged"
                            OnDataBound="GetCurrentRecoverySkin" 
                            Style="position: relative; top: 0px; left: 10px;" Width="95px">
                        </asp:DropDownList>
   <asp:DropDownList ID="ddlRecoveryValve" runat="server" DataSourceID="odsRecovery"
                            DataTextField="ConversionName" DataValueField="ConversionID" AutoPostBack="true"
                            Enabled="false" AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentRecoveryValveChanged"
                            OnDataBound="GetCurrentRecoveryValve"
                            Style="position: relative; top: 0px; left: 10px;" Width="100px">
                        </asp:DropDownList>               
   <asp:DropDownList ID="ddlRecoveryEyes" runat="server" DataSourceID="odsRecovery"
                            DataTextField="ConversionName" DataValueField="ConversionID" AutoPostBack="true"
                            Enabled="false" AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentRecoveryEyesChanged"
                            OnDataBound="GetCurrentRecoveryEyes"
                            Style="position: relative; top: 0px; left: 10px;" Width="95px">
                        </asp:DropDownList>
  <asp:DropDownList ID="ddlRecoveryOther" runat="server" DataSourceID="odsRecovery"
                            DataTextField="ConversionName" DataValueField="ConversionID" AutoPostBack="true"
                            Enabled="false" AppendDataBoundItems="true" OnSelectedIndexChanged="GetCurrentRecoveryOtherChanged"
                            OnDataBound="GetCurrentRecoveryOther" 
                            Style="position: relative; top: 0px; left: 15px;" Width="95px">
                        </asp:DropDownList>                  
                                             
</div>
<div style="position: relative; width: 780px; height: 175px; left: 0px; top: -13px; z-index: 105;" id="div1">
            <asp:TextBox ID="txtConsentOutcome" runat="server" BackColor="White" BorderColor="Silver"
                BorderStyle="Inset" BorderWidth="1px" ForeColor="Black" Height="130px" Style="left: 145px;
                position: absolute; top: 0px; z-index: 100;" Width="220px" TextMode="MultiLine" Wrap="true"
                MaxLength="1000"></asp:TextBox>
            <asp:Label ID="lblConsentOutcome" runat="server" Style="left: 0px;
                position: absolute; top: 0px; z-index: 101;" Text="Consent Outcome:" Width="140px"></asp:Label>
            <asp:TextBox ID="txtRecoveryOutcome" runat="server" BackColor="White" BorderColor="Silver"
                BorderStyle="Inset" BorderWidth="1px" ForeColor="Black" Height="130px" Style="left: 505px;
                position: relative; top: 0px; z-index: 102;" Width="225px" TextMode="MultiLine" Wrap="true"
                MaxLength="1000" Enabled="false"></asp:TextBox>
            <asp:Label ID="lblRecoveryOutcome" runat="server" Style=" left: 370px;
                position: absolute; top: 0px; z-index: 103;" Text="Recovery Outcome:" Width="130px"></asp:Label>
    &nbsp;&nbsp;
            <asp:Button ID="btnCancel" runat="server" Style="left: 660px; 
                top: 145px; z-index: 104; position: absolute;" Text="Cancel" OnClick="btnCancel_Click" UseSubmitBehavior="False" Width="70px" />
            <asp:Button ID="btnSave" runat="server" Style="left: 505px;  top: 145px;
                width: 70px; z-index: 106; position: absolute;" OnClick="btnSave_Click" Text="Save" />
              
 </div>
