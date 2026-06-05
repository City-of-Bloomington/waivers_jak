<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->

<s:form action="emailLog" id="form_id" method="post">
    <h1>Notification Logs</h1>
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
    <table border="1" width="80%">
	<caption>You can limit the logs to certain waiver or task by using the waiver #, id or task id </caption>
	<tr>
	    <th>Waiver #</th>
	    <td><s:textfield name="waiver_num" size="10" value="%{waiver_num}" /></td>
	</tr>
	<tr>
 	    <th>Waiver ID</th>
	    <td><s:textfield name="waiver_id" size="10" value="%{waiver_id}" /></td>
	</tr>
	<tr>
	    <th>Task ID</th>
	    <td><s:textfield name="task_id" size="10" value="%{task_id}" /></td>
	</tr>
	<tr>
	    <td>
		<s:submit name="action" type="button" value="Submit"/>
	    </td>
	</tr>
    </table>
</s:form>
<s:if test="hasEmailLogs()">
    <s:set var="emailLogs" value="emailLogs" />
    <s:set var="logsTitle" value="logsTitle" />
    <%@  include file="emailLogs.jsp" %>
</s:if>

<%@  include file="../gui/footer.jsp" %>	
