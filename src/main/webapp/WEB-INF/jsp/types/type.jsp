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
<p>* Required field <br />
    <s:form action="type" id="form_id" method="post" >
    <s:hidden name="action2" id="action2" value="" />
    <s:if test="id == ''">
	<h1>New <s:property value="selection" /></h1>
    </s:if>
    <s:else>
	<h1>Edit <s:property value="selection" /></h1>
	<s:hidden id="type_id" name="type.id" value="%{id}" />
    </s:else>
	<s:if test="id != ''">
	    If you make any change, please hit the 'Save Changes' button
	</s:if>
	<s:else>
	    Pick a collection from list below to add or update.<br />
	    You must hit 'Save' button to save data.
	</s:else>
    </p>
    <table boder="1" width="60%">
	<caption>Type Collection</caption>
	<tr>
	    <th>Collection Name </th>
	    <td><s:select id="selection_id" name="selection" value="%{selection}" list="#{'category':'categories','organ':'Organizations','location':'Locations','recycle':'Recycle Location'}" /> </td>
	</tr>
	<s:if test="id != ''">
	    <tr>
		<th>ID </th>
		<td><s:property value="id" /> </td>
	    </tr>
	</s:if>
	<tr>
	    <th>Name </th>
	    <td><s:textfield name="type.name" value="%{type.name}" size="30" maxlength="70" requiredLabel="true" required="true" id="type_name_id" />* </td>
	</tr>
	<tr>
	    <th>Inactive?</th>
	    <td><s:checkbox name="type.inactive" value="%{type.inactive}" fieldValue="true" />Yes </td>
	</tr>
	<tr>
	    <td>
		<s:if test="id == ''">
		    <s:submit name="action" type="button" value="Save" class="fn1-btn"/></dd>
		</s:if>
		<s:else>
		    <s:submit name="action" type="button" value="Save Changes" class="fn1-btn"/>
		</s:else>
	    </td>
	</tr>
    </table>
</s:form>
<s:if test="types != null">
    <s:set var="types" value="types" />
    <s:set var="typesTitle" value="typesTitle" />
    <%@  include file="types.jsp" %>
</s:if>
<%@  include file="../gui/footer.jsp" %>


