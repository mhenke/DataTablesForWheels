<!--- place in /controllers folder--->
<cfcomponent extends="Controller">
	
	<!--- my action for the datatables --->
	<cffunction name="example" returntype="Query" access="private" >
		<cfset var entries = model("entry").findAll(select="BODY,CATEGORYID,TITLE,dateCreated") />
		<cfreturn entries />
	</cffunction>
	
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
	
</cfcomponent>