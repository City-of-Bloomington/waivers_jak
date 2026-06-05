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
<h1>Workflow Step</h1>
<s:form action="step" id="form_id" method="post" >
    <s:hidden name="action2" id="action2" value="" />
    <s:if test="id == ''">
	<h3>New Workflow Step</h3>
    </s:if>
    <s:else>
	<h1>Edit <s:property value="name" /></h1>
	<s:hidden id="step.id" name="step.id" value="%{id}" />
    </s:else>

    <p>* Required field <br />
	<s:if test="id != ''">
	    If you make any change, please hit the 'Save Changes' button <br />
	</s:if>
	<s:else>
	    You must hit 'Save' button to save data. <br />
	</s:else>
	You can assign the workflow to a specific group by selecting the a group from the assignment groups list
    </p>
    <table border="1" width="80%">
	<caption>Workflow Step Info</caption>
	<s:if test="id != ''">
	    <tr>
		<th>ID </th>
		<td><s:property value="step.id" /> </td>
	    </tr>
	</s:if>		
	<tr>
	    <th>Name </th>
	    <td><s:textfield name="step.name" value="%{name}" size="30" maxlength="70" requiredLabel="true" required="true" />* </td>
	</tr>
	<tr>
	    <th>Field Name</th>
	    <td><s:textfield name="step.field_name" value="%{field_name}" size="30" maxlength="70" />(date type) </td>
	</tr>
	<tr>
	    <th>Field Name</th>
	    <td><s:textfield name="step.field2_name" value="%{field2_name}" size="30" maxlength="70" /> </td>
	</tr>
	<tr>
	    <th>Part Name</th>
	    <td><s:textfield name="step.part_name" value="%{part_name}" size="30" maxlength="70" /> </td>
	</tr>
	<tr>
	    <th>Assignment</th>
	    <td><s:select name="step.group_id" value="%{group_id}" list="groups" listKey="id" listValue="name" headerKey="-1" headerValue="Pick group" /> </td>
	</tr>
	<tr>
	    <th>Attachment Required?</th>
	    <td><s:checkbox name="step.require_upload" value="%{require_upload}" fieldValue="true" />Yes </td>
	</tr>
	<tr>
	    <th>Suggested Upload Type</th>
	    <td><s:select name="step.suggested_upload_type" value="%{suggested_upload_type}" list="#{'Application':'Application','Deed':'Deed','Recorded Waiver':'Recorded Waiver'}" headerKey="-1" headerValue="Pick suggest upload type" /> </td> (optional)
	</tr>
	<tr>
	    <th>Inactive?</th>  
	    <td><s:checkbox name="step.inactive" value="%{inactive}" fieldValue="true" />Yes </td>
	</tr>
	<tr>
	    <td>
		<s:if test="step.id == ''">
		    <s:submit name="action" type="button" value="Save" class="fn1-btn"/></td>
		</s:if>
		<s:else>
		    <s:submit name="action" type="button" value="Save Changes" class="fn1-btn"/>
		</s:else>
	    </td>
	</tr>
    </table>
</s:form>
<s:if test="steps != null">
    <s:set var="steps" value="steps" />
    <s:set var="stepsTitle" value="stepsTitle" />
    <%@  include file="steps.jsp" %>
</s:if>
<%@  include file="../gui/footer.jsp" %>


