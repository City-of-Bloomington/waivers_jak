<%@  include file="../gui/header.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<s:form action="search" id="form_id" method="post">
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
  <h3> Search </h3>
  <table border="1" width="80%">
      <caption>Search Options</caption>
      <tr>
	  <td>ID </td>
	  <td><s:textfield name="waiverList.id" value="%{id}" size="10" maxlength="10" /> 
	  </td>
      </tr>
      <tr>
	  <td>Waiver #</td>
	  <td><s:textfield name="waiverList.waiverNum" value="%{waiverNum}" size="10" maxlength="10" /> 
	  </td>
      </tr>			
      <tr>
	  <td>Deed/Waiver Instrumnet # </td>
	  <td><s:textfield name="waiverList.instrumentNum" value="%{instrumentNum}" size="25" maxlength="25" /> </td>
      </tr>
      <tr>
	  <td>Service Address </td>
	  <td><s:textfield name="waiverList.hookupAddress" value="%{hookupAddress}" size="25" maxlength="30" /> </td>
      </tr>			
      <tr>
	  <td>Entity Name </td>
	  <td><s:textfield name="waiverList.name" value="%{name}" size="25" maxlength="25" /> </td>
      </tr>
      <tr>
	  <td>Pin/Tax ID </td>
	  <td><s:textfield name="waiverList.parcelTaxId" value="%{parcelTaxId}" size="25" maxlength="30"  /> </td>
      </tr>
      <tr>
	  <td>Develop. Subdiv.</td>
	  <td><s:textfield name="waiverList.developmentSubdivision" value="%{developmentSubdivision}" size="25" maxlength="25" /> </td>
      </tr>

      <tr>
	  <td>Legal Desc.</td>
	  <td><s:textfield name="waiverList.legalDescription" value="%{legalDescription}" size="25" maxlength="25" /> </td>
      </tr>			
      <tr>
	  <td>Related Entity Type </td>
	  <td><s:radio name="waiverList.type" value="%{type}" list="#{'-1':'All','business':'Business only','individual':'Individuals only','trust':'Trusts only'}"  /> </td>
      </tr>			
      <tr>
	  <td>Data Entry? </td>
	  <td><s:radio name="waiverList.imported" value="%{imported}" list="#{'-1':'All','y':'Imported','n':'Entered'}" /> </td>
      </tr>
      <tr>
	  <td>Status </td>
	  <td><s:radio name="waiverList.status" value="%{status}" list="#{'-1':'All','Open':'Open','Closed':'Closed','Completed':'Completed'}" /> </td>
      </tr>
      <tr>
	  <td>Records </td>
	  <td><s:checkbox name="waiverList.noMappedDate" value="%{noMappedDate}" /> have no mapped date</td>
      </tr>
      <tr>
	  <td> In/Out City </td>
	  <td><s:radio name="waiverList.inOutOption" value="%{inOutOption}" list="#{'-1':'All','In':'In','Out':'Out','noInOut':'In/Out City not set'}" /></td>
      </tr>
      <tr>
	  <td>Show All </td>
	  <td><s:checkbox name="waiverList.showAll" value="%{showAll}" /> Yes</td>
      </tr>
      <tr>
	  <td> Date Selection</td>
	  <td><s:radio name="waiverList.whichDate" value="%{whichDate}" list="#{'w.date':'Request Date','w.signed_date':'Signed Date','w.recorder_date':'Recorded Date','w.expire_date':'Expire Date','w.mapped_date':'Mapped Date'}" /></td>
      </tr>
      <tr>
	  <td> Date </td>
	  <td>from: <s:textfield name="waiverList.dateFrom" value="%{dateFrom}" size="10" maxlength="10" cssClass="date" /> to:
	      <s:textfield name="waiverList.dateTo" value="%{dateTo}" size="10" maxlength="10" cssClass="date" />					
	  </td>
      </tr>
      <tr>  
	  <td> Output Type:</td>   
	  <td>
	      <s:checkbox name="outputCsv" value="%{outputCsv}" /> CSV file
	  </td>  
      </tr>
      <tr>
	  <td>
	      <s:submit name="action" type="button" value="Submit"/>
	  </td>
      </tr>
  </table>
</s:form>
<s:if test="waivers != null">
    <s:set var="waivers" value="waivers" />	
    <s:set var="waiversTitle" value="waiversTitle" />
    <%@  include file="waivers.jsp" %>
</s:if>
<%@  include file="../gui/footer.jsp" %>

