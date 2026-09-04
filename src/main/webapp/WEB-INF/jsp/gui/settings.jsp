<%@  include file="header.jsp" %>
<h3>Annex Waivers</h3>
<s:if test="hasActionErrors()">
  <div class="errors">
    <s:actionerror/>
  </div>
</s:if>
<h4>Settings</h4>
<ul>
    <li>
	<a href="<s:property value='#application.url'/>user.action">Users</a>
    </li>
    <li>
	<a href="<s:property value='#application.url'/>group.action">Groups</a>
    </li>
    <li>
	<a href="<s:property value='#application.url'/>groupNotification.action">Group Notification</a>
    </li>    
    <li>
	<a href="<s:property value='#application.url'/>groupUser.action">Manage Groups</a>
    </li>
    <li>
	<a href="<s:property value='#application.url'/>step.action">Workflow Steps</a>
    </li>
    <li>
	<a href="<s:property value='#application.url'/>workflow.action">Workflows</a>
    </li>
</ul>

<%@  include file="footer.jsp" %>
