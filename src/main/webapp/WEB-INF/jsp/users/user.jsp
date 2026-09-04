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
<h1> Waiver User </h1>
<s:form action="user" id="form_id" method="post">
    <s:hidden name="action2" id="action2" value="" />
    <table border="1" width="80%">
	<caption>
	    <s:if test="id == ''">
		New User
	    </s:if>
	    <s:else>
		User <s:property value="fullname" />
		<s:hidden name="user.id" value="%{id}" />
	    </s:else>
	</caption>
	<s:if test="id != ''">
	    <tr>
		<th>ID</th>
		<td><s:property value="%{id}" /></td>
	    </tr>
	</s:if>
	<tr>
	    <th>Username</th>
	    <td><s:textfield name="user.username" size="10" value="%{username}" /></td>
	</tr>
	<tr>
	    <th>Full Name </th>
	    <td><s:textfield name="user.fullName" value="%{fullName}" size="30" maxlength="70" /> </td>
	</tr>
	<tr>
	    <th>Roles</th>
	    <td><s:select name="user.role" value="%{role}" list="#{'View':'View Only','Edit':'Edit','Edit:Admin':'All (Admin)'}" /></td>
	</tr>
	<tr>
	    <th>Department</th>
	    <td><s:select name="user.dept" value="%{dept}" list="#{'Controller':'Controller','ITS':'ITS','Legal':'Legal','Utilities':'Utilities'}" /></td>
	</tr>
	<tr>
	    <th>Active Email</th>
	    <td><s:checkbox name="user.activeMail" value="%{activeMail}" /> Yes</td> 
	</tr>
	<tr>
	    <th>Inactive </th> 
	    <td><s:checkbox name="user.inactive" value="%{inactive}" /> Yes</td>   
	</tr>
	<tr>
	    <td>
		<s:if test="id == ''">
		    <s:submit name="action" type="button" value="Save" class="fn1-btn"/>
		</s:if>
		<s:else>
		    <s:submit name="action" type="button" value="Save Changes" class="fn1-btn"/>
		</s:else>
	    </td>
	</tr>
    </table>
    <a href="<s:property value='#application.url' />groupUser.action?"> Manage Users in Groups</a>
</s:form>
<s:if test="users != null">
    <s:set var="users" value="%{users}" />
    <s:set var="usersTitle" value="usersTitle" />
    <%@  include file="users.jsp" %>
</s:if>

<%@  include file="../gui/footer.jsp" %>


