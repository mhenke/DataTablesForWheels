CFWheels plugin for DataTables v0.3
http://github.com/mhenke/DataTablesForWheels

Third party software used:
http://www.datatables.net/
http://jquery.com/

Requires:
# Wheels 1.0.5
# DataTables jQuery plugin
# jQuery
 
TO USE
1) Place the DataTables-X.X.zip in your plugins folder

2) Add this code to your /Controllers/Controller.cfc

<cfinclude template="/plugins/datatables/datatables.cfm" />

3) Reload your Wheels application.
Example: http://localhost/index.cfm?reload=true

You should be good to go now.

EXAMPLES OF USE

In your view file include:
	<head>
		<cfoutput>
		#javaScriptIncludeTag("jquery-1.4.2.min")#
		#stylesheetLinkTag("demo_table")#
		<!--- pass in controller and ACTION NAME --->
		#getdatatablesJS("datatables","example")#
		
		<!--- pass in controller, action name, and sort order
		#getdatatablesJS("datatables","example","body desc, dateCreated desc")#
		 --->
		</cfoutput>
	</head>
	
	<!--- id name is your ACTION NAME appended with _table_id --->
	<cfoutput>#getdatatablesHTML(myActionName,myColumnNames)#</cfoutput>

In your Controller have a function called your ACTION NAME that returns a query.

	<!--- my ACTION NAME for the datatables --->
	<cffunction name="example" returntype="Query" access="private" >
		<cfset var entries = model("entry").findAll(select="BODY,CATEGORYID,TITLE,dateCreated") />
		<cfreturn entries />
	</cffunction>
	
	<!--- here is the demo action --->
	<cffunction name="demo" >
		<cfset myActionName = "example" />
		
		<cfset myColumnNames = ArrayNew(1) />
		<cfset myColumnNames[1] = "Body" />
		<cfset myColumnNames[2] = "Category ID" />
		<cfset myColumnNames[3] = "Title" />
		<cfset myColumnNames[4] = "Date Created" />
		
		<!--- pass in controller and action name 
		<cfset getdatatablesJS("datatables","example") />
		--->
		<!--- pass in controller, action name, and sort order --->
		<cfset getdatatablesJS("datatables",myActionName,"body desc, dateCreated desc") />
	</cffunction>

DEMO
Unzip the Demo-x.x.zip file into CFWheel's webroot.
You will need to place the jquery and dataTables js files in your javascripts folder
You will need to place the demo_table.css in your stylesheets folder
You will need to place the dataTables images in your images folder

Load - http://localhost/index.cfm/datatables/demo