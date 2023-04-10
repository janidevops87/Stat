<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ScheduleSplitShiftControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.ScheduleSplitShiftControl" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDateChooser.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebSchedule" TagPrefix="igsch" %>
<%@ Register Assembly="Infragistics4.WebUI.WebDataInput.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.WebDataInput" TagPrefix="igtxt" %>
<%@ Register Assembly="Infragistics4.WebUI.Misc.v11.1, Version=11.1.20111.2020, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb" Namespace="Infragistics.WebUI.Misc" TagPrefix="igmisc" %>
<%@ Register Assembly="Statline.StatTrac.Web" Namespace="Statline.StatTrac.Web.UI.WebControls"
    TagPrefix="StatTrac" %>        
<asp:ScriptManager ID="ScriptManager1" runat="server">
</asp:ScriptManager>
<stattrac:sectionheader id="sectionHeaderSplitShift" runat="server" text="Split Shift"
    width="100%"></stattrac:sectionheader>
<igsch:webcalendar id="webCalendar" runat="server" EnableAppStyling="True" style="z-index: 103; left: 392px; position: absolute; top: 467px"></igsch:webcalendar>
&nbsp;
<div style="position: relative; width: 720px; height: 390px; left: 0px; top: 0px; z-index: 100;" id="divMain">    
<fieldset style="z-index: 120; left: 45px; width: 245px; position: absolute; top: 180px;
    height: 160px">
    <legend accesskey="I" style="font-weight: bold">Start Split</legend>
    <asp:DropDownList ID="ddlPerson1Start" runat="server" DataSourceID="odsPerson" DataTextField="Name"
        DataValueField="PersonID" OnPreRender="GetPerson1" 
        Style="z-index: 101; left: 10px; position: absolute; top: 25px" Width="125px">
    </asp:DropDownList>
    &nbsp;
    <asp:DropDownList ID="ddlPerson2Start" runat="server" DataSourceID="odsPerson" DataTextField="Name"
        DataValueField="PersonID" OnPreRender="GetPerson2" 
        Style="z-index: 103; left: 10px; position: absolute; top: 50px" Width="125px">
    </asp:DropDownList>
    &nbsp;
    <asp:DropDownList ID="ddlPerson3Start" runat="server" DataSourceID="odsPerson" DataTextField="Name"
        DataValueField="PersonID" OnPreRender="GetPerson3" 
        Style="z-index: 105; left: 10px; position: absolute; top: 75px" Width="125px">
    </asp:DropDownList>
    &nbsp;
    <asp:DropDownList ID="ddlPerson4Start" runat="server" DataSourceID="odsPerson" DataTextField="Name"
        DataValueField="PersonID" OnPreRender="GetPerson4" 
        Style="z-index: 107; left: 10px; position: absolute; top: 100px" Width="125px">
    </asp:DropDownList>
    &nbsp;
    <asp:DropDownList ID="ddlPerson5Start" runat="server" DataSourceID="odsPerson" DataTextField="Name"
        DataValueField="PersonID" OnPreRender="GetPerson5" 
        Style="z-index: 109; left: 10px; position: absolute; top: 125px" Width="125px">
    </asp:DropDownList>
    
</fieldset>
<fieldset style="z-index: 121; left: 465px; width: 245px; position: absolute; top: 180px;
    height: 160px">
    <legend accesskey="I" style="font-weight: bold">End Split</legend>
    <asp:DropDownList ID="ddlPerson1End" runat="server" DataSourceID="odsPerson" DataTextField="Name" 
        DataValueField="PersonID" OnPreRender="GetPerson1End" 
        Style="z-index: 101; left: 10px; position: absolute; top: 25px" Width="125px">
    </asp:DropDownList>
    &nbsp;
    <asp:DropDownList ID="ddlPerson2End" runat="server" DataSourceID="odsPerson" DataTextField="Name"
        DataValueField="PersonID" OnPreRender="GetPerson2End" 
        Style="z-index: 103; left: 10px; position: absolute; top: 50px" Width="125px">
    </asp:DropDownList>
    &nbsp;
    <asp:DropDownList ID="ddlPerson3End" runat="server" DataSourceID="odsPerson" DataTextField="Name"
        DataValueField="PersonID" OnPreRender="GetPerson3End" 
        Style="z-index: 105; left: 10px; position: absolute; top: 75px" Width="125px">
    </asp:DropDownList>
    &nbsp;
    <asp:DropDownList ID="ddlPerson4End" runat="server" DataSourceID="odsPerson" DataTextField="Name"
        DataValueField="PersonID" OnPreRender="GetPerson4End"
        Style="z-index: 107; left: 10px; position: absolute; top: 100px" Width="125px">
    </asp:DropDownList>
    &nbsp;
    <asp:DropDownList ID="ddlPerson5End" runat="server" DataSourceID="odsPerson" DataTextField="Name"
        DataValueField="PersonID" OnPreRender="GetPerson5End" 
        Style="z-index: 109; left: 10px; position: absolute; top: 125px" Width="125px">
    </asp:DropDownList>
   
</fieldset>


            <asp:Label ID="lblSchedOrg" runat="server" Font-Bold="True" Style="z-index: 100;
                left: 0px; position: absolute; top: 5px" Text="Schedule Organization:" Width="155px"></asp:Label>
      
            <asp:Label ID="lblSchedOrg1" runat="server" Style="z-index: 101; left: 160px; position: absolute;
                top: 5px" Width="250px"></asp:Label>
      
            <asp:Label ID="lblSchedGroup" runat="server" Font-Bold="True" Style="z-index: 102;
                left: 40px; position: absolute; top: 25px" Text="Schedule Group:" Width="115px"></asp:Label>
       
            <asp:Label ID="lblSchedGroup1" runat="server" Style="z-index: 103; left: 160px; position: absolute;
                top: 25px" Width="185px"></asp:Label>
            <asp:Label ID="lblTZ" runat="server" Style="z-index: 104; left: 540px; position: absolute;
                top: 5px"></asp:Label>
            <asp:Label ID="lblTZ1" runat="server" Style="z-index: 105; left: 460px; position: absolute;
                top: 5px" Width="80px" Font-Bold="True">Time Zone:</asp:Label>
     
<asp:TextBox ID="txtNameStart" runat="server" Style="z-index: 106; left: 110px; position: absolute;
    top: 47px" Width="180px">
</asp:TextBox>
<asp:Label ID="lblStartDT" runat="server" Style="z-index: 107; left: 45px; position: absolute;
    top: 95px" Text="Start D/T:" Width="60px"></asp:Label>
    &nbsp;

<asp:Label ID="lblEndDT" runat="server" Style="z-index: 108; left: 50px; position: absolute;
    top: 140px" Text="End D/T:" Width="55px"></asp:Label>
    &nbsp;
    

<asp:Button ID="btnCanel" runat="server" OnClick="btnCanel_Click" Style="z-index: 109;
    left: 370px; position: absolute; top: 355px" Text="Cancel" Width="55px" />
<asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Style="z-index: 110;
    left: 305px; position: absolute; top: 355px" Text="Save" Width="55px" />
<asp:TextBox ID="txtNameEnd" runat="server" Height="20px" Style="z-index: 111; left: 530px;
    position: absolute; top: 45px" Width="180px"></asp:TextBox>
    &nbsp;
<asp:Label ID="lblStartDT1" runat="server" Height="20px" Style="z-index: 112; left: 465px;
    position: absolute; top: 90px" Text="Start D/T:" Width="60px"></asp:Label>
    &nbsp;

<asp:Label ID="lblEndDT1" runat="server" Height="20px" Style="z-index: 113; left: 470px;
    position: absolute; top: 135px" Text="End D/T:" Width="55px"></asp:Label>
    &nbsp;

<asp:Label ID="lblName" runat="server" Style="z-index: 114; left: 65px; position: absolute;
    top: 50px" Text="Name:"></asp:Label>
<asp:Label ID="Label3" runat="server" Style="z-index: 115; left: 485px; position: absolute;
    top: 45px" Text="Name:"></asp:Label>
    &nbsp;&nbsp;

        <StatTrac:WebDateTime ID="endDateTimeEndShift" runat="server" Width="170px" WebCalendarID="webCalendar" Enabled=false style="Z-INDEX: 116; LEFT: 530px; POSITION: absolute; TOP: 135px" OnValueChange="endDateTimeEndShift_ValueChange">
                <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif"></ButtonsAppearance>
                <SpinButtons Display="OnRight" />
            </StatTrac:WebDateTime>  

        <StatTrac:WebDateTime ID="startDateTimeEndShift" runat="server" Width="170px" WebCalendarID="webCalendar" style="Z-INDEX: 117; LEFT: 530px; POSITION: absolute; TOP: 85px">
                <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif"></ButtonsAppearance>
                <SpinButtons Display="OnRight" />
            </StatTrac:WebDateTime>    
    
        <StatTrac:WebDateTime ID="endDateTimeStartShift" runat="server" Width="170px" WebCalendarID="webCalendar" style="Z-INDEX: 118; LEFT: 110px; POSITION: absolute; TOP: 135px">
                <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
                </ButtonsAppearance>
                <SpinButtons Display="OnRight" />
            </StatTrac:WebDateTime>            

        <StatTrac:WebDateTime ID="startDateTimeStartShift" runat="server" Width="170px" WebCalendarID="webCalendar" Enabled=false style="Z-INDEX: 122; LEFT: 110px; POSITION: absolute; TOP: 92px">
                <ButtonsAppearance CustomButtonDisplay="OnRight" CustomButtonImageUrl="./Images/cal.gif">
                </ButtonsAppearance>
                <SpinButtons Display="OnRight" />
            </StatTrac:WebDateTime>
</div>
<div id="divWebCalendar" style="position:static; top:800px">
    </div>
<div style="z-index: 102; left: 10px; width: 205px; position: absolute; top: 440px;
    height: 80px">
    
           <asp:ObjectDataSource ID="odsPerson" runat="server" OnSelected="odsPerson_Selected"
    SelectMethod="FillSchedPersonList" TypeName="Statline.StatTrac.Schedule.ScheduleManager">
    <SelectParameters>
        <asp:Parameter Name="OrganizationId" Type="Int32" />
        <asp:QueryStringParameter Name="ScheduleGroupID" QueryStringField="SchedGroupID"
            Type="Int32" />
    </SelectParameters>
</asp:ObjectDataSource>
    &nbsp;
 <igmisc:WebPageStyler ID="webPageStyler" runat="server" StyleSetName="StatlineReports" />
        
</div>


