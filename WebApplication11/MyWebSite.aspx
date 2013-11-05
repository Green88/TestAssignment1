<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyWebSite.aspx.cs" Inherits="WebApplication11.WebForm2" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit.HTMLEditor" tagprefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<style type="text/css">  
        .accordion {  
            width: 400px;  
        }  
          
        .accordionHeader {  
            border: 1px solid #2F4F4F;  
            color: white;  
            background-color: #2E4d7B;  
            font-family: Arial, Sans-Serif;  
            font-size: 12px;  
            font-weight: bold;  
            padding: 5px;  
            margin-top: 5px;  
            cursor: pointer;  
        }  
          
        .accordionHeaderSelected {  
            border: 1px solid #2F4F4F;  
            color: white;  
            background-color: #5078B3;  
            font-family: Arial, Sans-Serif;  
            font-size: 12px;  
            font-weight: bold;  
            padding: 5px;  
            margin-top: 5px;  
            cursor: pointer;  
        }  
          
        .accordionContent {  
            background-color: #FFFFFF;  
            border: 1px dashed #2F4F4F;  
            border-top: none;  
            padding: 5px;  
            padding-top: 10px;  
        }  
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
    

    <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="2" 
        Height="312px" Width="856px">

        <asp:TabPanel runat="server" HeaderText="Edit File" ID="EditorTab">
            <ContentTemplate>
            <div>
                <asp:Button ID="btLoadFile" runat="server" Text="Load file" 
                    style="margin-bottom: 10px" onclick="btLoadFile_Click"/>
                <asp:TextBox ID="TextBoxEditor" runat="server" Height="151px" Width="828px" 
                    ></asp:TextBox>
                <asp:HtmlEditorExtender ID="HtmlEditorExt" runat="server" 
                    Enabled="True" TargetControlID="TextBoxEditor">
                </asp:HtmlEditorExtender>
                <asp:Button ID="Button1" runat="server" Height="32px" style="margin-top: 10px" 
                    Text="Ready? Now pick a date" Width="211px" onclick="Button1_Click" />
                    
                    </div>
            </ContentTemplate>
        </asp:TabPanel>

        <asp:TabPanel ID="CalendarTab" runat="server" HeaderText="Pick a date">
        <ContentTemplate>
        <gridview>
            <div>
            <asp:TextBox ID="TextBoxCalendar" runat="server" Height="30px" Width="232px" 
                style="margin-top: 0px"></asp:TextBox>
            <asp:CalendarExtender ID="CalendarExt" runat="server" 
                Enabled="True" TargetControlID="TextBoxCalendar" 
                TodaysDateFormat = "d MMMM, yyyy" PopupButtonID="btShowCalendar" 
                Format="D">
            </asp:CalendarExtender>
        
            <asp:ImageButton ID="btShowCalendar" runat="server" Height="31px" 
                ImageUrl="~/Images/Calendar-icon.png" style="margin-top: 0px" Width="32px" 
                 />
                <br />
                <br />
            <asp:Button ID="Button2" runat="server" onclick="Button2_Click" 
                    Text="Picked a date? Now publish" Width="242px" />
                </gridview>
        </div>
        </ContentTemplate>
        </asp:TabPanel>

        <asp:TabPanel ID="SummaryTab" runat="server" HeaderText="Ready to publish">
        <ContentTemplate>
            <asp:Accordion 
            ID="Accordion1" 
            CssClass="accordion"  
            HeaderCssClass="accordionHeader"  
            HeaderSelectedCssClass="accordionHeaderSelected"  
            ContentCssClass="accordionContent" runat="server" Width="780px" 
                FramesPerSecond="30" TransitionDuration="250">
            </asp:Accordion>    
        
        </ContentTemplate>
        </asp:TabPanel>
    </asp:TabContainer>
    </div>
    </form>
</body>
</html>
