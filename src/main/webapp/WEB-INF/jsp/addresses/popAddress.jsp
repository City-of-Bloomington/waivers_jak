<%@  include file="../gui/headerBasic.jsp" %>
<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<script type="text/javascript">
var APPLICATION_URL = '<s:property value='#application.url' />';
function updateOpener(){
     var addr_id = document.getElementById("addr_id").value;
     var addressInfo = document.getElementById("address_info_id").value;
     var all_addr_ids = window.opener.document.getElementById("add_addr_ids").value;
     if(all_addr_ids != "") all_addr_ids += ",";
     all_addr_ids += addr_id;
     window.opener.document.getElementById("add_addr_ids").value = all_addr_ids;
     
     var all_addrs = window.opener.document.getElementById("addr_bulk_id").innerHTML;
     if(all_addrs != "") all_addrs  += ", ";
     all_addrs += addressInfo;
     window.opener.document.getElementById("addr_bulk_id").innerHTML = all_addrs;
     window.close();
 }
 function refreshOpener(){
     <s:if test="address.waiver_id == ''">
     window.opener.location.reload(true);
     </s:if>
     <s:else>
     window.opener.location="<s:property value='#application.url' />waiver.action?id=<s:property value='address.waiver_id' />&action=Edit";
     </s:else>
     window.close();
 }
</script>
</head>
<s:if test="address.id == ''">
    <body class="fn1-body">
</s:if>
<s:else>
    <s:if test="address.waiver_id == ''">	
	<body onload="updateOpener()">
    </s:if>
    <s:else>
	<body onload="refreshOpener()">
    </s:else>
</s:else>
<b>Instructions</b>
<ul>
    <li>Street # could be one or multiple or number range such as (10), (10,12,14) or (10-30)</li>
    <li>Street name has to be one name at a time, may include direction and type such as N Morton St</li>
    <li>For multiple street names use this form multiple times</li>
</ul>
<s:if test="hasActionErrors()">
    <div class="errors">
	<s:actionerror/>
    </div>
</s:if>	
<s:form action="address" id="form_id" method="post" >
    <s:hidden name="type" value="popup" />
    <s:if test="address.waiver_id != ''">
	<s:hidden name="address.waiver_id" value="%{address.waiver_id}" id="waiver_id" />
    </s:if>
    <s:if test="address.id == ''">
	<h1>New Address</h1>
    </s:if>
    <s:else>
	<s:hidden name="address.addressInfo" value="%{address.addressInfo}" id="address_info_id" />				
	<h1>Edit Address <s:property value="id" /></h1>
	<s:hidden name="address.id" value="%{address.id}" id="addr_id" />
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
    <p>* Street Name is required <br />
	After you click on 'Save' please wait couple seconds for the address to
	be verified with our master address and this may take some time. <br /> 
    </p>
    <table><caption>Address Info</caption>
    <tr>
	<td>Street Num </td>
	    <td><s:textfield name="address.streetNum" value="%{address.streetNum}" size="30" maxlength="70" title="you can enter one value, or multiple separated by comma or number range such as (401), (401,403,405) or (401-409)" placeHolder="401 or 401,403 or 401-409"/> </td>
    </tr>
    <tr>
	<td>Street Name </td>
	<td><s:textfield name="address.streetName" value="%{address.streetName}" size="30" maxlength="30" title="include direction and street type such as N Morton St" placeHolder="N Morton St" />* </td>
    </tr>
	<s:if test="address.id != ''">
	    <tr>
		<td>Street Address </td>
		<td><s:textfield name="address.streetAddress" value="%{address.streetAddress}" size="30" maxlength="150" id="street_addr_id" /> </td>
	    </tr>
	    <tr>
		<td>Invalid? </td>
		<td><s:checkbox name="address.inValid" value="%{address.inValid}" /> Yes </td>
	    </tr>
	    <tr>
		<td> </td>
		<td>
		    <s:submit name="action" type="button" value="Save Changes" class="fn1-btn"/>
		    <input name="action" type="button" value="Cancel" onclick="javascript:window.close()"/>	
		</td>
	    </tr>
	</s:if>
	<s:else>
	    <tr>
		<td>
		    <s:submit name="action" type="button" value="Save" class="fn1-btn"/>
		    <s:if test="address.invalid"><s:submit name="action" type="button" value="Save Any Way" class="fn1-btn"/></s:if>
		    <input name="action" type="button" value="Cancel" onclick="javascript:window.close()" class="fn1-btn"/>							
		</td>
	    </tr> 							
	</s:else>
    </table>
    <br />
    <a href="javascript:window.close();">Close This Window</a></div>
</s:form>
<%@  include file="../gui/footer.jsp" %>


