<!--- place in /views/datatables folder--->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>

	<head>
		<cfoutput>
		#javaScriptIncludeTag("jquery-1.4.2.min")#
		#stylesheetLinkTag("demo_table")#
		<!--- pass in controller and action name --->
		#getdatatablesJS("datatables","example")#
		</cfoutput>
	</head>
	
	<body id="dt_example">
		<div id="dynamic">
			<table cellpadding="0" cellspacing="0" border="0" class="display" id="example_table_id">
				<thead>
					<tr>
						<th>Rendering engine</th>
						<th>Browser</th>
						<th>Platform(s)</th>
						<th>Engine version</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="4" class="dataTables_empty">Loading data from server</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<th>Rendering engine</th>
						<th>Browser</th>
						<th>Platform(s)</th>
						<th>Engine version</th>
					</tr>
				</tfoot>
			</table>
		</div>
	</body>
	
</html>