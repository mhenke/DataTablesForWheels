<cffunction name="dataTablesprocessing">
	<cfset var objAttributes = structNew() />
	<cfset var thisColumn = "" />
	<cfset var listColumns = "" />
	<cfset var listColumnsCast = "" />
	<cfset var queryObject = "" />
	<cfset var arrayMetaData = "" />
	<cfset var json_output = "" />
	<cfset var thisS = "" />
	<cfset var flag_case = 0 />

	<!--- query to use, which is in a function --->
	<cfparam name="params.qFunctionName" type="string" />
	<cfparam name="params.sIndexColumn" type="string" />
	
	<cfparam name="params.iDisplayStart" type="integer" default="0"  />
	<cfparam name="params.iDisplayLength" type="integer" default="10"  />
	<cfparam name="params.sEcho" type="string" default="0"  />
	<cfparam name="params.sSearch" type="string" default="" />
	<cfparam name="params.iSortingCols" type="integer" default="1"  />
	
	<cfset queryObject = evaluate("#params.qFunctionName#()") />
	<cfset arrayMetaData = getMetaData(queryObject) />
	
	<cfloop index="thisColumn"  from="1" to="#arraylen(arrayMetaData)#">
		<cfset listColumns = ListAppend(listColumns, arrayMetaData[thisColumn]["Name"]) />
		<cfset listColumnsCast = ListAppend(listColumnsCast, "CAST(#arrayMetaData[thisColumn]["Name"]# as VARCHAR) as #arrayMetaData[thisColumn]["Name"]#") />
	
		<cfif arrayMetaData[thisColumn]["TypeName"] NEQ "VARCHAR">
			<cfset flag_case = 1 />
		</cfif>
	</cfloop>

	<!--- set query of queries --->
	<cfset objAttributes.dbtype = "query"/>
	
	<cfif flag_case>
	<!--- set columns to varchar --->
		<cfset objAttributes.name="queryObject" />
		<cfquery attributecollection="#objAttributes#">
			SELECT #listColumnsCast# 
			FROM queryObject
		</cfquery>
		
		<!--- reset query meta data --->
		<cfset arrayMetaData = getMetaData(queryObject) />
	</cfif>
	
	<!--- query name for filtering data set--->
	<cfset objAttributes.name="qFiltered" />
	
	<!--- Data set after filtering --->
	<cfquery attributecollection="#objAttributes#">
		SELECT #listColumns# 
		FROM queryObject
		
		<!--- setup where clause --->
		<cfif len(trim(params.sSearch))>
			WHERE 
			1 = 0
			<!--- filter --->
			<cfloop index="thisColumn"  from="1" to="#arraylen(arrayMetaData)#">
				OR upper(#arrayMetaData[thisColumn]["Name"]# ) LIKE <cfqueryparam value="%#ucase(trim(params.sSearch))#%" cfsqltype="cf_sql_varchar">
			</cfloop>
		</cfif>

		<!--- Ordering --->
		ORDER BY 
	    <cfif params.iSortingCols GT 0 and params.sEcho GT 1>
			<cfloop from="0" to="#params.iSortingCols-1#" index="thisS">
				<cfif thisS is not 0>, </cfif>
				#listGetAt(listColumns,(params["iSortCol_"&thisS]+1))# 
				<cfif listFindNoCase("asc,desc",params["sSortDir_"&thisS]) gt 0>#params["sSortDir_"&thisS]#</cfif> 
			</cfloop>
		<cfelse>
			#params.sIndexColumn#		
		</cfif>
	</cfquery>

	<!--- set length for the initial unfiltered data set --->
	<cfset qCount.total = queryObject.recordcount />
	
	<!--- Output --->
	<cfsavecontent variable="json_output">
	{"sEcho": <cfoutput>#val(params.sEcho)#</cfoutput>, 
	"iTotalRecords": <cfoutput>#qCount.total#</cfoutput>, 
	"iTotalDisplayRecords": <cfoutput>#qFiltered.recordCount#</cfoutput>, 
	"aaData": [ 
		<cfoutput query="qFiltered" startrow="#val(params.iDisplayStart+1)#" maxrows="#val(params.iDisplayLength)#">
			<cfif currentRow gt (params.iDisplayStart+1)>,</cfif>
			[<cfloop list="#listColumns#" index="thisColumn">
				<cfif thisColumn neq listFirst(listColumns)>,</cfif>
				#serializeJSON(qFiltered[thisColumn][qFiltered.currentRow])#
			</cfloop>
			]
		</cfoutput> 
		] }
	</cfsavecontent>
	<cfcontent reset="true" />
	<cfsetting showDebugOutput="No">
	<cfset renderText(json_output)>
</cffunction>