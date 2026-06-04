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
  <h1> Waivers Report </h1>
  <s:form action="report" id="form_id" method="post">
      <ul>
	  <li> You can get the list of waivers based on selection of the year or date range but not both</li>
	  <li> The output could be html (web format) or csv that you can open with spread sheet app such as Excel</li>
      </ul>
      <table border="1" width="80%">
	  <caption>Report Options</caption>
	  <tr>
	      <th>Status </th>
	      <td><s:radio name="waiverList.status" value="%{status}" list="#{'-1':'All','Open':'Open','Closed':'Closed','Completed':'Completed'}" /> </td>
	  </tr>
	  <tr>
	      <th>Year </th>
	      <td><s:select name="waiverList.year" value="%{year}" list="years" headerKey="-1" headerValue="All" /></td>
	  </tr>
	  <tr>
	      <th> Date Selection</th>
	      <td><s:radio name="waiverList.whichDate" value="%{whichDate}" list="#{'w.date':'Request Date','w.signed_date':'Signed Date','w.recorder_date':'Recorded Date','w.expire_date':'Expire Date','w.mapped_date':'Mapped Date'}" /></td>
	  </tr>
	  <tr>
	      <th> Date Range: </th>
	      <td>from: <s:textfield name="waiverList.dateFrom" value="%{dateFrom}" size="10" maxlength="10" cssClass="date" /> to:
		  <s:textfield name="waiverList.dateTo" value="%{dateTo}" size="10" maxlength="10" cssClass="date" />					
	      </td>
	  </tr>
	  <tr>
	      <th> Output Format:</th> 
	      <td>
		  <s:radio name="outputType" value="%{outputType}" list="#{'html':'HTML','csv':'CSV (spread sheet)'}" />
	      </td> 
	  </tr>
	  <tr>
	      <td>
		  <s:submit name="action" type="button" value="Submit"/>
	      </td>
	  </tr>
      </table>
  </s:form>
  <s:if test="hasWaivers()">
      <s:set var="waivers" value="waivers" />	
      <s:set var="waiversTitle" value="reportTitle" />
      <%@  include file="waivers.jsp" %>
  </s:if>
  <%@  include file="../gui/footer.jsp" %>
  
