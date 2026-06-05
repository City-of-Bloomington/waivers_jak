<%@  include file="../gui/header.jsp" %>
<!--
     * @copyright Copyright (C) 2014-2016 City of Bloomington, Indiana. All rights reserved.
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
<h1>Assign Users to Groups</h1>
<ul>
    <li>To start, pick a group from the list</li>
    <li>* Checkbox to add to the group </li>
    <li>** checkbox to remove from the group </li>
</ul>

<s:form action="groupUser" id="form_id" method="post">
    <s:hidden name="action2" id="action2" value="" />
    <table border="1" width="60%">
	<caption>Group and Users </caption>
	<tr>
	    <th>Groups</th>
	    <td><s:select name="groupUser.group_id" value="%{group_id}" list="groups" listKey="id" listValue="name" headerKey="-1" headerValue="Pick Group" id="selection_id" /></td>
	    <s:if test="hasOtherUsers()">
		<td>
		    <table>
			<caption>Add New Users to this group</caption>
			<tr><td>*</td><td>Name</td><td>Dept</td></tr>
			<s:iterator var="one" value="groupUser.other_users">
			    <tr>
				<td><input type="checkbox" name="groupUser.add_users" value="<s:property value='id' />" /></td>
				<td><s:property value="fullName" /></td>
				<td><s:property value="dept" /></td>
			    </tr>
			</s:iterator>
			<tr>
			    <td>
				<s:submit name="action" type="button" value="Add to this group"/>
			    </td>
			</tr>
		    </table>
		</td>
	    </s:if>
	</tr>
	<s:if test="hasGroupUsers()">
	    <tr>
		<td colspan="2">&nbsp;</td>
		<td>
		    <table width="60%">
			<caption>Users in this group</caption>
			<tr><td>**</td><td>Name</td><td>Dept</td></tr>			
			<s:iterator var="one" value="group_users">
			    <tr>
				<td><input type="checkbox" name="groupUser.del_users" value="<s:property value='id' />" /></td>
				<td><s:property value="fullName" /></td>
				<td><s:property value="dept" /></td>
			    </tr>
			</s:iterator>
			<tr>
			    <td>
				<s:submit name="action" type="button" value="Remove from this group" class="fn1-btn"/>
			    </td>
			</tr>
		    </table>
		</td>
	    </tr>
	</s:if>
</s:form>

<%@  include file="../gui/footer.jsp" %>


