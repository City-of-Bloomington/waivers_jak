<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<s:form action="task" id="form_id" method="post">
    <s:hidden name="action2" id="action2" value="" />
    <h2>Perform Task: <s:property value="task.name" /></h2>
    <s:hidden name="task.task_id" value="%{task_id}" />
    <s:hidden name="task.step_id" value="%{step_id}" />
    <s:hidden name="waiver_id" value="%{waiver_id}" />
    <s:hidden name="task.waiver_id" value="%{waiver_id}" />
    <s:if test="claimed_by !=''">
	<s:hidden name="task.claimed_by" value="%{claimed_by}" />		
    </s:if>
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
  <p>* Required field <br />
  </p>
  <b>Instructions</b>
      <ul>
	  <li>If you make any change, please hit the 'Save Changes' button</li>
	  <li>If all the requirements for this task are met, click on 'Completed' button so that the workflow will move to next task (if any).</li>
	  <li>You can add files by clicking on 'New Attachment'</li>
      </ul>
  <s:if test="require_upload && !canBeCompleted()">
      <p>Requirement: You need to upload a file to complete this task </p>
  </s:if>		
  <div>
      <ul>
	  <li>Related Waiver <a href="<s:property value='#application.url' />waiver.action?id=<s:property value='waiver_id' />"><s:property value="waiverNum" /></a></li>
	  <li>Waiver Info:
	      <ul>
		  <li><s:property value="basicInfo" /></li>
		  <li><s:property value="basicInfo2" /></li>
		  <li><s:property value="basicInfo3" /></li>
	      </ul>
	  </li>
	  <li>Start Date:
		<s:property value="start_date" />
	  </li>
	  <s:if test="task.isClaimed()">
	      <li>
		  Claimed by:
		  <s:property value="claimed_user" /> 
	      </li>
	  </s:if>
	  <s:if test="hasSecondField()">
	      <li>Task: <s:property value="%{field2_name}" /> 
		    <s:textarea name="task.field2_value" value="%{field2_value}" rows="10" cols="70" /> 
	      </li>
	  </s:if>
	    <s:if test="hasPartName()">
		<s:if test="part_name == 'legal'">
		    <s:include value="../waivers/legalPart.jsp" />
		</s:if>
		<s:elseif test="part_name == 'recorder'">
		    <s:include value="../waivers/recorderPart.jsp" />
		</s:elseif>
		<s:elseif test="part_name == 'gis'">
		    <s:include value="../waivers/gisPart.jsp" />
		</s:elseif>
	    </s:if>
	    <li>Related Group:
		<s:property value="groupName" />
	    </li>
	    <s:if test="isCompleted()">
		<li>Status: Completed on <s:property value="%{completed_date}" /> 
		</li>
	    </s:if>
      </ul>
      <s:submit name="action" type="button" value="Save Changes"/>
      <s:if test="canBeCompleted()">
	  Note: If no more actions is needed for this task click completed to move to next task
	  <s:submit name="action" type="button" value="Task Completed"/>
      </s:if>
	<s:if test="canBePrinted()">
	    <a href="<s:property value='#application.url' />WaiverRtf?id=<s:property value='waiver_id' />">Printable Waiver</a>
	</s:if>
	<a href="<s:property value='#application.url' />doUpload.action?waiver_id=<s:property value='waiver_id' />&task_id=<s:property value='task_id' />">New Attachment</a>
	<s:if test="hasCompletedTasks()" >
	    <s:set var="tasksTitle" value="'Completed Tasks'" />
	    <s:set var="tasks" value="%{completedTasks}" />
	    <%@  include file="../tasks/tasks.jsp" %>			
	</s:if>
	<s:if test="hasUploads()">
	    <s:set var="attachmentsTitle" value="'Attachments'" />
	    <s:set var="uploads" value="%{uploads}" />
	    <%@  include file="../attachments/fileUploads.jsp" %>
	</s:if>
  </div>
</s:form>
<s:if test="hasEmailLogs()">
    <s:set var="logsTitle" value="'Email Logs'" />
    <s:set var="emailLogs" value="%{emailLogs}" />
    <%@  include file="../logs/emailLogs.jsp" %>				
</s:if>

<%@  include file="../gui/footer.jsp" %>

