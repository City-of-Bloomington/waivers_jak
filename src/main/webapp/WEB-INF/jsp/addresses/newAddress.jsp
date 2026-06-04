<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<h1>New address</h1>
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
<s:form action="verify" id="form_id" method="post" >
    <s:hidden name="action2" id="action2" value="" />
    <s:hidden name="address.waiver_id" value="%{waiver_id}" />
  <table border="1" width="80%">
      <caption>Enter an address then click on Save</caption>
      <tr>
	  <td>Street Num </td>
	  <td><s:textfield name="address.streetNum" value="" size="30" maxlength="150" title="street num could be one, multiple separated by comma or range separated by dash such as (10), (10,12,14) or (10-14)" />
	  </td>
      </tr>
      <tr>
	  <td>Street Name </td>
	  <td><s:textfield name="address.streetName" value="" size="30" maxlength="150" title="one street name only, for multiple street names, use this window multiple times" />
	  </td>
      </tr>		
      <tr>
	  <td>
	      <s:submit name="action" type="button" value="Save"/>
	  </td> 
      </tr>
</s:form>
<%@  include file="../gui/footer.jsp" %>


