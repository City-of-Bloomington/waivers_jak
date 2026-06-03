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
     var entity_id = document.getElementById("entity_id").value;
     var entity_name = document.getElementById("entity_name").value;
     var old_ids = window.opener.document.getElementById("entity_ids").value;
     var old_names = window.opener.document.getElementById("entity_names").innerHTML;
     if(old_ids && old_ids != ""){
	 old_ids +=",";
	 old_names +=", ";
     }
     if(old_ids == null) old_ids="";
     if(old_names == null) old_names="";
     old_ids += entity_id;
     old_names += entity_name;
     window.opener.document.getElementById("entity_ids").value = old_ids;
     window.opener.document.getElementById("entity_names").innerHTML = old_names;
     window.close();
 }
 // for an existing waiver
 function refreshOpener(){
     window.opener.location="<s:property value='application_url' />waiver.action?id=<s:property value='entity.waiver_id' />&action=Edit";
     window.close();
 }
</script>
</head>
<s:if test="entity.id == ''">
    <body>
</s:if>
<s:else>
    <s:if test="entity.waiver_id == ''">	
	<body onload="updateOpener()">
    </s:if>
    <s:else>
	<body onload="refreshOpener()">
    </s:else>
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
    <s:hidden name="type" value="popup" />
    <s:if test="entity.waiver_id != ''">
	<s:hidden name="entity.waiver_id" value="%{entity.waiver_id}" />
	<s:hidden name="entity.id" value="%{entity.id}" id="entity_id" />
	<s:hidden name="entity.name2" value="%{entity.name}" id="entity_name" />
    </s:if>
    <h1>Entity Info</h1>
    <p>* Name is required. <br />
	<table>
	<s:if test="entity.id == ''">
	    <caption>New Owner, Business or Trust</caption>
	</s:if>
	<s:else>
	    <caption>Edit Entity <s:property value="id" /></caption>

	</s:else>
	<tr>
	    <td>Name </td>
	    <td><s:textfield name="entity.name" value="%{entity.name}" size="30" maxlength="70" placeholder="last name, first name or business name" /></td>
	</tr>
	<tr>
	    <td>Title </td>
	    <td><s:textfield name="entity.title" value="%{entity.title}" size="30" maxlength="30" placeholder="Owner, Agent, Manager, etc" /> </td>
	</tr>
	<tr>
	    <td>Is Business? </td>
	    <td><s:checkbox name="entity.isBusiness" value="%{entity.isBusiness}" /> Yes </td>
	</tr>
	<tr>
	    <td>Is Trust? </td>
	    <td><s:checkbox name="entity.isTrust" value="%{entity.isTrusts}" /> Yes </td>			
	</tr>
	<tr>
	    <td>
		<s:if test="entity.id == ''">
		    <s:submit name="action" type="button" value="Save" class="fn1-btn"/> <input name="action" type="button" value="Cancel" onclick="javascript:window.close()" class="fn1-btn"/>		
		</s:if>
		<s:else>
		    <s:submit name="action" type="button" value="Save Changes" class="fn1-btn"/> <input name="action" type="button" value="Cancel" onclick="javascript:window.close()" class="fn1-btn"/>								
		</s:else>
	    </td> 
	</tr>
	</table>
	<div><a href="javascript:window.close();">Close This Window</a></div>
</s:form>
<%@  include file="../gui/footer.jsp" %>


