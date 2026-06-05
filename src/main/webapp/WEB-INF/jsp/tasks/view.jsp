<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<s:if test="hasActionErrors()">
    <div class="errors">
	<s:actionerror/>
    </div>
</s:if>
<s:elseif test="hasActionMessages()">
    <div class="welcome">
	<s:actionmessage/>
    </div>
</s:elseif>
<h1>Task: <s:property value='name' /></h1>
<h3>Instructions</h3>
<ul>
    <li>If this task is completed, you may click on next task (if allowed)</li>
    <li>If the task is still going on, you may edit by clicking on 'Edit' button</li>
    <li>If the task is still going on, you can add attachment by clicking on 'New Attachment'</li>
</ul>
<s:if test="require_upload && !canBeCompleted()">
    <p>Requirement: You need to upload a file to complete this task </p>
</s:if>		
<ul>
    <li>Related Waiver:<a href="<s:property value='#application.url' />waiver.action?id=<s:property value='waiver_id' />"><s:property value="waiverNum" /></a>
    </li>
    <li> Waiver Info: 
	<ul>
	    <s:if test="basicInfo != ''">
		<li><s:property value="basicInfo" /></li>
	    </s:if>
	    <s:if test="basicInfo2 != ''">
		<li><s:property value="basicInfo2" /></li>
	    </s:if>
	    <s:if test="basicInfo3 != ''">
		<li><s:property value="basicInfo3" /></li>
	    </s:if>
	</ul>
    </li>
    <li>Start Date:
	<s:property value="start_date" />
    </li>
    <s:if test="isClaimed()">
	<li>Claimed by: <s:property value="claimed_user" /></li>
    </s:if>
    <s:if test="require_upload && !canBeCompleted()">
	<li>Requirment: You need to attach a file to complete this task </li>
    </s:if>			
    <s:if test="hasSecondField()">
	<s:if test="field2_value">		
	    <li><s:property value="%{field2_name}" /> :
		<s:property value="%{field2_value}" /> </li>
	</s:if>
    </s:if>
    <s:if test="isCompleted()">
	<li>Status: Completed on <s:property value="%{completed_date}" /> 
	</li>
    </s:if>    
</ul>
<s:if test="task.hasPart()">
    <s:if test="part_name == 'legal'">
	<s:set var="waiver" value="%{waiver}" />
	<s:include value="../waivers/legalViewPart.jsp" />
    </s:if>
    <s:elseif test="part_name == 'recorder'">
	<s:set var="waiver" value="%{waiver}" />		
	<s:include value="../waivers/recorderViewPart.jsp" />
    </s:elseif>
    <s:elseif test="part_name == 'gis'">
	<s:set var="waiver" value="%{waiver}" />
	<s:include value="../waivers/gisViewPart.jsp" />
    </s:elseif>
</s:if>
<s:if test="isOpen()">
    <a href="<s:property value='#application.url'/>task.action?task_id=<s:property value='task_id' />&action=Edit">Edit: <s:property value='task.name' /></a>
    <s:if test="waiver.canBePrinted()">
	<a href="<s:property value='#application.url' />WaiverRtf?id=<s:property value='waiver_id' />">Printable Waiver</a>
    </s:if>
    <a href="<s:property value='#application.url' />doUpload.action?waiver_id=<s:property value='task.waiver_id' />&task_id=<s:property value='task_id' />">New Attachments</a>	
    <s:if test="task.isCompleted()">
	<s:if test="waiver.hasMoreTasks()">
	    <s:iterator var="one" value="waiver.tasks">
		<a href="<s:property value='#application.url'/>task.action?task_id=<s:property value='task_id' />&action=Edit">Next: <s:property value="alias" /> (<s:property value="group" />)</a>
	    </s:iterator>
	</s:if>
    </s:if>
    <s:else>
	<s:if test="task.canBeCompleted()">
	    <a href="<s:property value='#application.url'/>task.action?task_id=<s:property value='task_id' />&action=Task+Completed">Task Completed </a>		
	</s:if>		
    </s:else>
</s:if>
<s:if test="waiver.hasCompletedTasks()" >
    <s:set var="tasksTitle" value="'Completed Tasks'" />
    <s:set var="tasks" value="%{completedTasks}" />
    <%@  include file="tasks.jsp" %>			
</s:if>
<s:if test="task.waiver.hasUploads()">
    <s:set var="attachmentsTitle" value="'Attachments'" />
    <s:set var="uploads" value="%{uploads}" />
    <%@  include file="../attachments/fileUploads.jsp" %>			
</s:if>
<s:if test="hasEmailLogs()">
    <s:set var="logsTitle" value="'Email Logs'" />
    <s:set var="emailLogs" value="%{emailLogs}" />
    <%@  include file="../logs/emailLogs.jsp" %>				
</s:if>
<%@  include file="../gui/footer.jsp" %>

