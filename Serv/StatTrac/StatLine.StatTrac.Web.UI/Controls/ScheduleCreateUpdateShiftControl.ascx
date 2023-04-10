<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ScheduleCreateUpdateShiftControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.ScheduleCreateUpdateShiftControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls" TagPrefix="StatTrac" %>
    
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>

<stattrac:sectionheader id="sectionHeaderAddUpdateShift" runat="server" text="Add/Update Shift"
    width="100%"></stattrac:sectionheader>
    <igsch:webCalendar ID="webCalendar" EnableAppStyling="True" runat="server" style="z-index: 100; left: 645px; position: absolute; top: 310px">
    </igsch:webCalendar>
<div style="position: relative; width: 970px; height: 265px; left: 0px; top: 0px; z-index: 102;" id="divMain">
<fieldset style="z-index: 118; left: 405px; width: 285px; position: absolute; top: 55px;
    height: 160px">
    <legend accesskey="I" style="font-weight: bold">On Call</legend>
    <asp:CheckBox ID="cbxPerson1" runat="server" Style="z-index: 102; left: 5px; position: absolute;
        top: 25px" Text="On Call 1" />
    <asp:DropDownList ID="ddlPerson1" runat="server" Style="z-index: 103; left: 90px; position: absolute; 
        top: 25px" OnPreRender="GetPerson1" OnSelectedIndexChanged="GetPerson1Changed" Width="185px" DataSourceID="odsPerson" DataTextField="Name" DataValueField="PersonID"></asp:DropDownList>
    <asp:CheckBox ID="cbxPerson2" runat="server" Style="z-index: 104; left: 5px; position: absolute;
        top: 50px" Text="On Call 2" />
    <asp:DropDownList ID="ddlPerson2" runat="server" Style="z-index: 105; left: 90px; position: absolute;
        top: 50px" OnPreRender="GetPerson2" OnSelectedIndexChanged="GetPerson2Changed" Width="185px" DataSourceID="odsPerson" DataTextField="Name" DataValueField="PersonID"></asp:DropDownList>
    <asp:CheckBox ID="cbxPerson3" runat="server" Style="z-index: 106; left: 5px; position: absolute;
        top: 75px" Text="On Call 3" />
    <asp:DropDownList ID="ddlPerson3" runat="server" Style="z-index: 107; left: 90px; position: absolute;
        top: 75px" OnPreRender="GetPerson3" OnSelectedIndexChanged="GetPerson3Changed" Width="185px" DataSourceID="odsPerson" DataTextField="Name" DataValueField="PersonID"></asp:DropDownList>
    <asp:CheckBox ID="cbxPerson4" runat="server" Style="z-index: 108; left: 5px; position: absolute;
        top: 100px" Text="On Call 4" />
    <asp:DropDownList ID="ddlPerson4" runat="server" Style="z-index: 109; left: 90px; position: absolute;
        top: 100px" OnPreRender="GetPerson4" OnSelectedIndexChanged="GetPerson4Changed" Width="185px" DataSourceID="odsPerson" DataTextField="Name" DataValueField="PersonID"></asp:DropDownList>
    <asp:CheckBox ID="cbxPerson5" runat="server" Style="z-index: 110; left: 5px; position: absolute;
        top: 125px" Text="On Call 5" />
    <asp:DropDownList ID="ddlPerson5" runat="server" Style="z-index: 111; left: 90px; position: absolute;
        top: 125px" OnPreRender="GetPerson5" OnSelectedIndexChanged="GetPerson5Changed" Width="185px" DataSourceID="odsPerson" DataTextField="Name" DataValueField="PersonID"></asp:DropDownList>
</fieldset>
            <asp:TextBox ID="txtName" runat="server" Style="z-index: 100; left: 160px; position: absolute;top: 65px" Width="220px"></asp:TextBox>
            <asp:Label ID="lblTZ1" runat="server" Style="z-index: 101; left: 335px; position: absolute;
                top: 145px" ></asp:Label>
            <asp:Label ID="lblTZ" runat="server" Style="z-index: 102; left: 335px; position: absolute;
                top: 105px"></asp:Label>

<asp:Label ID="lblName" runat="server" Style="z-index: 103; left: 110px; position: absolute;
    top: 65px" Text="Name:"></asp:Label>
<asp:Label ID="lblStartDT" runat="server" Style="z-index: 104; left: 90px; position: absolute;
    top: 105px" Text="Start D/T:" Width="60px"></asp:Label>
<asp:Label ID="lblEndDT" runat="server" Style="z-index: 105; left: 95px; position: absolute;
    top: 145px" Text="End D/T:" Width="55px"></asp:Label>


<asp:Button ID="btnSplitShift" runat="server" Style="z-index: 106; left: 185px; position: absolute;
    top: 230px" Text="Split Shift" OnClick="btnSplitShift_Click" />
<asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Style="z-index: 107;
        left: 405px; position: absolute; top: 230px" Text="Delete" Width="70px" />    
<asp:Button ID="btnCanel" runat="server" Style="z-index: 108; left: 605px; position: absolute;
    top: 230px" Text="Cancel" OnClick="btnCanel_Click" Width="70px" />
<asp:Button ID="btnSave" runat="server" Style="z-index: 109; left: 505px; position: absolute;
    top: 230px" Text="Save" OnClick="btnSave_Click" Width="70px" />
<asp:Button ID="btnRemoveShift" runat="server" Style="z-index: 110; left: 290px;
    position: absolute; top: 230px" Text="Remove Shift" OnClick="btnRemoveShift_Click" OnClientClick="var agree=confirm('Are you sure you wish to continue?');if (agree) return true ; else return false ; " Width="84px" />

    <asp:Panel ID="pnlCreateShift" runat="server" Height="195px" Width="245px" Visible="false"   BorderStyle="None" style="z-index: 111; left: 715px; position: absolute; top: 55px" BorderWidth="1px">
    <fieldset id=fldsetCreateShift runat="server" style="z-index: 107; left: 10px; width: 230px; position: absolute; top: 5px;
    height: 185px "><legend accesskey="I" style="font-weight: bold">Create Shift</legend>
    
    <asp:CheckBox ID="cbxSunday" runat="server" Style="z-index: 100; left: 5px; position: absolute;
        top: 90px" Text="Sunday" Enabled="False" />
    <asp:CheckBox ID="cbxMonday" runat="server" Style="z-index: 101; left: 5px; position: absolute;
        top: 113px" Text="Monday" Enabled="False" />
    <asp:CheckBox ID="cbxThursday" runat="server" Style="z-index: 102; left: 105px; position: absolute;
        top: 90px" Text="Thursday" Enabled="False" />
    <asp:CheckBox ID="cbxFriday" runat="server" Style="z-index: 103; left: 105px; position: absolute;
        top: 110px" Text="Friday" Enabled="False" />
    <asp:CheckBox ID="cbxSaturday" runat="server" Style="z-index: 104; left: 105px; position: absolute;
        top: 135px" Text="Saturday" Enabled="False" />
    <asp:CheckBox ID="cbxTuesday" runat="server" Style="z-index: 105; left: 5px; position: absolute;
        top: 136px" Text="Tuesday" Enabled="False" />
    <asp:CheckBox ID="cbxWednesday" runat="server" Style="z-index: 106; left: 5px; position: absolute;
        top: 160px" Text="Wednesday" Enabled="False" />
    <asp:CheckBox ID="cbxRepeatShift" runat="server" Style="z-index: 107; left: 5px; 
        position: absolute; top: 20px" Text="Repeat Shift" AutoPostBack="true" OnCheckedChanged="cbxRepeatShift_CheckedChanged" />
        <asp:Label ID="lblRepeattxt" runat="server" Style="z-index: 108; left: 5px; position: absolute;
            top: 40px" Text="Repeat for each selected day until:" Width="210px"></asp:Label>
         <StatTrac:WebDateTime ID="repeatDateTime" runat="server" WebCalendarID="webCalendar" Width="160px" Enabled="False" style="z-index: 110; left: 5px; position: absolute; top: 60px" >
                <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
                </ButtonsAppearance>
                <SpinButtons Display="OnRight" />
         </StatTrac:WebDateTime>
    </fieldset>
</asp:Panel>

            <StatTrac:WebDateTime ID="endDateTime" runat="server" WebCalendarID="webCalendar" Width="160px" style="z-index: 112; left: 160px; position: absolute; top: 140px" >
                <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
                </ButtonsAppearance>
                <SpinButtons Display="OnRight" />
            </StatTrac:WebDateTime>

            <StatTrac:WebDateTime ID="startDateTime" runat="server" WebCalendarID="webCalendar" Width="160px" style="z-index: 113; left: 160px; position: absolute; top: 101px">
                <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
                </ButtonsAppearance>
                <SpinButtons Display="OnRight" />
            </StatTrac:WebDateTime>

            <asp:Label ID="lblSchedGroup1" runat="server" Style="z-index: 114;
                top: 25px; left: 160px; position: absolute;" Width="420px"></asp:Label>

            <asp:Label ID="lblSchedOrg1" runat="server" Style="z-index: 115; 
                top: 0px; left: 160px; position: absolute;" Width="420px"></asp:Label>

            <asp:Label ID="lblSchedGroup" runat="server" Font-Bold="True" Style="z-index: 116;
                left: 40px; top: 25px; position: absolute;" Text="Schedule Group:" Width="115px"></asp:Label>
    <asp:Label ID="lblSchedOrg" runat="server" Font-Bold="True" Style="z-index: 119;
                left: 0px; top: 0px; position: absolute;" Text="Schedule Organization:" Width="155px"></asp:Label>
</div>
<div style="z-index: 103; left: 10px; width: 195px; position: absolute; top: 315px;
    height: 110px">
    &nbsp;<igmisc:WebPageStyler ID="webPageStyler" runat="server" StyleSetName="StatlineReports"  />
<asp:ObjectDataSource ID="odsPerson" runat="server" EnableCaching="True" OnSelected="odsPerson_Selected"
    SelectMethod="FillSchedPersonList" TypeName="Statline.StatTrac.Schedule.ScheduleManager">
    <SelectParameters>
        <asp:Parameter Name="OrganizationId" Type="Int32" />
        <asp:QueryStringParameter Name="ScheduleGroupID" QueryStringField="SchedGroupID"
            Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
    
</div>
    
