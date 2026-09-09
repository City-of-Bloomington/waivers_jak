<%@ taglib prefix="s" uri="/struts-tags" %>
<table border="1" width="80%">
    <caption>Recorder Input</caption>
    <tr>
	<th>Waiver Instrument # </th>
	<td><s:textfield name="waiver.waiverInstrumentNum" value="%{waiverInstrumentNum}" size="20" maxlength="20" />
	</td>
    </tr>
    <tr>
	<th>Recorded Date </th>
	<td><s:textfield name="waiver.recorderDate" value="%{recorderDate}" size="10" maxlength="10" class="date" />
	</td>
    </tr>
    <tr>
	<th>Waiver Book </th>
	<td><s:textfield name="waiver.waiverBook" size="10" maxlength="10" value="%{waiverBook}" /> Page: <s:textfield name="waiver.waiverPage" size="10" maxlength="10" value="%{waiverPage}" /> </td>
    </tr>
    <tr>
    <tr>
	<th>Waiver Notes </th>
	<td><s:textfield name="waiver.notes" size="80" maxlength="80" value="%{notes}" /></td>
    </tr>
    </tr>
</table>


