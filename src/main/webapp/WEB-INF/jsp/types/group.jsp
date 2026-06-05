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
  <h1>Waiver Related Department Groups</h1>
  <s:form action="group" id="form_id" method="post" >
    <s:hidden name="action2" id="action2" value="" />
    <s:if test="group.id == ''">
	<h1>New group</h1>
    </s:if>
    <s:else>
	<h1>Edit <s:property value="name" /></h1>
	<s:hidden id="group.id" name="group.id" value="%{id}" />
    </s:else>

  <p>* Required field <br />
      <s:if test="id != ''">
	  If you make any change, please hit the 'Save Changes' button
      </s:if>
      <s:else>
	  You must hit 'Save' button to save data.
      </s:else>
  </p>
  <table border="1" width="60%">
      <caption>Group Info</caption>
      <s:if test="id != ''">
	  <tr>
	      <th>ID </th>
	      <td><s:property value="id" /> </td>
	  </tr>
      </s:if>		
      <tr>
	  <th>Name </th>
	  <td><s:textfield name="group.name" value="%{name}" size="30" maxlength="70" required="true" />* </td>
      </tr>
      <tr>
	  <th>Inactive?</th>
	  <td><s:checkbox name="group.inactive" value="%{inactive}" fieldValue="true" />Yes </td>
      </tr>
      <tr>
	  <td>
	      <s:if test="group.id == ''">
		  <s:submit name="action" type="button" value="Save"/></dd>
	      </s:if>
	      <s:else>
		  <s:submit name="action" type="button" value="Save Changes"/>
	      </s:else>
	  </td>
      </tr>
  </table>
</s:form>
<s:if test="groups != null">
    <s:set var="groups" value="groups" />
    <s:set var="groupsTitle" value="groupsTitle" />
    <%@  include file="groups.jsp" %>
</s:if>
<%@  include file="../gui/footer.jsp" %>


