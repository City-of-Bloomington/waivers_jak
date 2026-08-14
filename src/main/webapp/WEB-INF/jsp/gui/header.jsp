<?xml version="1.0" encoding="UTF-8" ?>
<!--
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<s:head />
	<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
	<link rel="SHORTCUT ICON" href="<s:property value='#application.url' />images/favicon.ico" />
	<link rel="stylesheet" href="<s:property value='#application.url' />css2/menu_style.css" type="text/css" />	
	<link rel="stylesheet" href="<s:property value='#application.url' />css2/waivers.css" type="text/css" />
	<link rel="stylesheet" href="<s:property value='#application.url' />css/jquery-ui.min-1.13.2.css" type="text/css" media="all" />
	<link rel="stylesheet" href="<s:property value='#application.url' />css/jquery-ui.theme.min-1.13.2.css" type="text/css" media="all" />
	<title>Waivers</title>
	<script type="text/javascript">
	 var APPLICATION_URL = '<s:property value='#application.url' />';
	</script>
    </head>
<body>
    <header>
	<h1><a href="<s:property value='#application.url'/>welcome.action">Annexation Waivers</a></h1>	
	<h3><a href="<s:property value='#application.url'/>welcome.action">City of Bloomington, IN</a></h3>
	<s:if test="#session.user != null">
	    <div id="div_top">
		<ul id="ul_top">
		    <li><a href="<s:property value='#application.url'/>activeTasks.action">Active Task List</a></li>				
		    <li><a href="<s:property value='#application.url'/>waiver.action">New Waiver</a></li>
		    <li><a href="<s:property value='#application.url'/>entity.action">New Entity/Owner</a></li>				
		    <li><a href="<s:property value='#application.url'/>search.action">Search</a></li>
		    <li><a href="<s:property value='#application.url'/>report.action">Reports</a></li>
		    <li><a href="<s:property value='#application.url'/>statsReport.action">Stats Reports</a></li>
		    <li><a href="<s:property value='#application.url'/>emailLog.action">Notification Logs</a></li>
		</ul>		    
	    </div>
	</s:if>
    </header>
    <br />
    <br />


