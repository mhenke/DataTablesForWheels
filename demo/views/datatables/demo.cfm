<!--- place in /views/datatables folder--->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
	
	<head>
		<cfoutput>
		#javaScriptIncludeTag("jquery-1.4.2.min")#
		#stylesheetLinkTag("demo_table")#
		</cfoutput>
	</head>
	
	<body id="dt_example">
		<div id="dynamic">
			<!--- pass in caction name and names for column list--->
			<cfoutput>#getdatatablesHTML(myActionName,myColumnNames)#</cfoutput>
		</div>
	</body>
	
</html>