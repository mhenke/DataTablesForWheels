<!--- place in /controllers folder--->
<cfcomponent extends="Controller">
	
	<!--- my action for the datatables --->
	<cffunction name="example" returntype="Query" access="private" >
		<cfset var entries = model("entry").findAll(select="BODY,CATEGORYID,TITLE,dateCreated") />
		<cfreturn entries />
	</cffunction>
	
</cfcomponent>