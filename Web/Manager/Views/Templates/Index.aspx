﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Manager/Views/Shared/Admin.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Cuyahoga.Web.Manager.Views.Templates.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphHead" runat="server">
	<script type="text/javascript" src="<%= Url.Content("~/manager/Scripts/jquery.form.js") %>"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphTasks" runat="server">
	<h2><%= GlobalResources.TasksLabel %></h2>
	<%= Html.ActionLink(GlobalResources.RegisterTemplateLabel, "New", null, new { @class = "createlink" })%>
	<div id="uploadarea" class="taskcontainer">
		<h4>Upload template files</h4>
		<% using (Html.BeginForm("UploadTemplates", "Templates", FormMethod.Post, new { id = "templatesuploadform", enctype = "multipart/formdata" })) { %>
            <p>
            You can upload a set of template files, packaged as a .zip file. The name of the .zip file becomes the directory
            name. Make sure that the template control (.ascx) is in the root of the package and images and stylesheets are in the Images
            and Css directories.            
            </p>
            <input type="file" id="templatesuploader" name="templatesuploader" style="width:220px" /><br />
            <input type="submit" value="Upload" />
        <% } %>
        <script type="text/javascript">
			
			$(document).ready(function() {
			
				$('#templatesuploadform').ajaxForm({ 
					dataType:  'json', 
					success:   processJsonMessage // in Messages.ascx 
				}); 
			});        
		</script> 
	</div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="cphMain" runat="server">
	<% if (ViewData.Model.Count > 0) { %>
		<table class="grid" style="width:100%">
			<thead>
				<tr>
					<th><%= GlobalResources.NameLabel%></th>
					<th><%= GlobalResources.BasePathLabel%></th>
					<th><%= GlobalResources.TemplateControlLabel%></th>
					<th><%= GlobalResources.CssLabel%></th>
					<th>&nbsp;</th>
				</tr>
			</thead>
			<tbody>
				<% foreach (var template in ViewData.Model) { %>
					<tr>
						<td><%= template.Name%></td>
						<td><%= template.BasePath%></td>	
						<td><%= template.TemplateControl%></td>
						<td><%= template.Css%></td>
						<td style="white-space:nowrap">
							<%= Html.ActionLink(GlobalResources.EditLabel, "Edit", new { id = template.Id })%>
							<% using (Html.BeginForm("Delete", "Templates", new { id = template.Id }, FormMethod.Post)) { %>
								<a href="#" class="deletelink"><%= GlobalResources.DeleteButtonLabel%></a>
							<% } %>
						</td>
					</tr>
				<% } %>
			</tbody>
		</table>
	<% } else { %>
		<%= GlobalResources.NoTemplatesFound%>
	<% } %>
</asp:Content>