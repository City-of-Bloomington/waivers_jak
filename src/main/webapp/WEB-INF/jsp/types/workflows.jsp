<!--
 * @copyright Copyright (C) 2014-2015 City of Bloomington, Indiana. All rights reserved.
 * @license http://www.gnu.org/copyleft/gpl.html GNU/GPL, see LICENSE.txt
 * @author W. Sibo <sibow@bloomington.in.gov>
 *
	-->
<table boder="1" width="80%">
    <caption><s:property value="#workFlowsTitle" /></caption>
    <thead>
	<tr>
	    <th align="center"><b>Workflow </b></th>
	    <th align="center"><b>Step Name </b></th>
	    <th align="center"><b>Next Step Name</b></th>
	</tr>
	</thead>
	<tbody>
	    <s:iterator var="one" value="#workFlows">
		<tr>
		    <td><a href="<s:property value='#application.url' />workflow.action?id=<s:property value='id' />">Edit </a></td>
		    <td><s:property value="step_name" /></td>
		    <td><s:property value="next_step_name" /></td>				
		</tr>
	    </s:iterator>
	</tbody>
</table>
