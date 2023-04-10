<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CustomParamsRegistryOutreachEvents.ascx.cs" Inherits="Statline.StatTrac.Web.UI.Controls.CustomParamsRegistryOutreachEvents" %>
<%@ Register TagPrefix="cc1" Namespace="Statline.StatTrac.Web.UI.WebControls" Assembly="Statline.StatTrac.Web" %>
        <div class="ParamControlLabel">State:
        </div>        
        <div class="ParamControl">
                <asp:RadioButtonList id="radioButtonListState" runat="server" OnSelectedIndexChanged="radioButtonListState_SelectedIndexChanged" AutoPostBack="True" TextAlign="Right">
            </asp:RadioButtonList>
        </div>
        <div class="SectionSeperator" >
            <div class="ParamControlLabel">
            Main Category:
            </div>
            <div class="ParamControl">
                <cc1:DropDownRegistryMainCategory ID="ddlMainCategory" runat="server"
                    OnSelectedIndexChanged="DropDownRegistryMainCategory_SelectedIndexChanged" AutoPostBack="True">
                </cc1:DropDownRegistryMainCategory>
            </div>
        </div>
        <div class="SectionSeperator" >        
            <div class="ParamControlLabel">Sub Category:
            </div>
            <div class="ParamControl">
                        <cc1:DropDownRegistrySubCategory ID="ddlSubCategory" runat="server">
                        </cc1:DropDownRegistrySubCategory>
            </div>
        </div>
        <div class="SectionSeperator" >
            <div class="ParamControlLabel">Source Code:
            </div>
            <div class="ParamControl">
                <asp:textbox id="txtBoxSourceCode" runat="server" EnableViewState="False"></asp:textbox>
            </div>
        </div>