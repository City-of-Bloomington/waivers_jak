<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
-->
<s:if test="id == ''">
    <h1>New Entity/Business</h1>
</s:if>
<s:else>
    <h1>Edit Entity <s:property value="id" /></h1>
</s:else>
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
<s:form action="entity" id="form_id" method="post" >
    <s:hidden name="action2" id="action2" value="" />
    <s:if test="id !=''">
	<s:hidden name="entity.id" value="%{id}" />
    </s:if>
    <s:if test="hasWaiver()">
	<s:hidden name="entity.waiver_id" value="%{waiver_id}" />
    </s:if>
    
    <p>* Name is required <br />
	<b>Notes:</b>
	For people names use 'last name, first name' format. <br />
	Check if this entity is a business or a trust. <br />
	For business managers and trust executers you may add signers title <br />
	<s:if test="id != ''">
	    If you make any change, please hit the 'Save Changes' button
	</s:if>
	<s:else>
	    You must hit 'Save' button to save data.
	</s:else>
    </p>
    <table border="1" width="80%">
	<caption>Entity Info </caption>
	<tr>
	    <td>Name </td>
	    <td><s:textfield name="entity.name" value="%{name}" size="30" maxlength="70" required="true" placeholder="last name, first name or business name"/> *</td>
	</tr>
	<tr>
	    <td>Title </td>
	    <td><s:textfield name="entity.title" value="%{title}" size="30" maxlength="30" placeholder="Owner, Agent, Manager, etc" /> </td>
	</tr>		
	<tr>
	    <td>Is Business? </td>
	    <td><s:checkbox name="entity.isBusiness" value="%{isBusiness}" /> Yes </td>
	</tr>
	<tr>
	    <td>Is Trust? </td>
	    <td><s:checkbox name="entity.isTrust" value="%{isTrusts}" /> Yes </td>			
	</tr>
	<s:if test="entity.hasWaiver()">
	    <tr>
		<td>Related Waiver </td>
		<td><a href="<s:property value='#application.url'/>waiver.action?id=<s:property value='waiver_id' />"> Back To Waiver</a>	
	    </tr>
	</s:if>
	<tr>
	    <td>
	    <s:if test="id == ''">
		<s:submit name="action" type="button" value="Save"/> 
	    </s:if>
	    <s:else>
		<s:submit name="action" type="button" value="Save Changes"/>
	    </s:else>
	    </td>
	</tr>
    </table>
</s:form>
<s:elseif test="entities != null">
    <s:set var="entities" value="entities" />
    <s:set var="entitiesTitle" value="entitiesTitle" />
    <%@  include file="entities.jsp" %>
</s:elseif>
<%@  include file="../gui/footer.jsp" %>


