<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsErrorControl.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsErrorControl" %>
<div class="ParamControl">
    <fieldset style="width:400px;">
        <legend  >Error</legend>
        <div class="ParamControlLabel">
            Error Source:
        </div>
        <div class="ParamControl">
            <input id="txtErrorSource" type="text" style="width: 150px" runat="server"/>
        </div>
        <div class="ParamControlLabel">
            Error Computer:
        </div>
        <div class="ParamControl" >
            <input id="txtErrorComputer" type="text" style="width: 150px" runat="server"/>
        </div>
        <div class="ParamControlLabel">
            Error Description:
        </div>
        <div class="ParamControl">
            <input id="txtErrorDescription" type="text" style="width: 150px" runat="server"/>
            </div>
    </fieldset>            
</div>
