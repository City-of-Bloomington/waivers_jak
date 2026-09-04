<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
    <h1>User Group Notification Setup</h1>
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
    <s:form action="groupNotification" id="form_id" method="post">
    <s:hidden name="action2" id="action2" value="" />
    <s:if test="id != ''">
	<s:hidden name="groupNotification.id" value="%{id}" />
    </s:if>
    <p>If you want certain group to be Not notified, make that group as inactive</p>
    <table border="1" width="60%">
	<caption> Group Notification </caption>
	<tr>
	    <th>On Completed Workflow Step</th>
	    <td><s:select name="groupNotification.step_id" value="%{step_id}" list="steps" listKey="id" listValue="name" headerKey="-1" headerValue="Pick A Step" /></td>
	</tr>
	<tr>
	    <th>Group to Be Notified</th>
	    <td><s:select name="groupNotification.group_id" value="%{group_id}" list="groups" listKey="id" listValue="name" headerKey="-1" headerValue="Pick A Group" /></td>
	</tr>
	<s:if test="groupNotification.id == ''">
	    <tr>
		<td>
		    <s:submit name="action" type="button" value="Save" class="fn1-btn"/>
		</td>
	    </tr>
	</s:if>
	<s:else>
	    <tr>
		<th>Inactive</th>
		<td><s:checkbox name="groupNotification.inactive" value="%{inactive}" />? Yes</td>
	    </tr>
	    <tr>
		<td>
		    <s:submit name="action" type="button" value="Save Changes"/>
		</td>
	    </tr>
	</s:else>
    </table>
    </s:form>    
    <s:if test="hasGroupNotifications()">
	<s:set var="groupNotifications" value="groupNotifications" />
	<%@  include file="groupNotifications.jsp" %>
    </s:if>

<%@  include file="../gui/footer.jsp" %>


