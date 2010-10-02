<cffunction name="dataTablesprocessing">
		<cfset var objAttributes = structNew() />
		<cfset var thisColumn = "" />
		<cfset var listColumns = "" />
		<cfset var listColumnsCast = "" />
		<cfset var queryObject = "" />
		<cfset var arrayMetaData = "" />
		<cfset var json_output = "" />
		
		<!--- query to use, which is in a function --->
		<cfparam name="params.qFunctionName" type="string" />
		<cfparam name="params.sIndexColumn" type="string" default="1" />
		<cfparam name="params.iDisplayStart" type="integer" default="0"  />
		<cfparam name="params.iDisplayLength" type="integer" default="10"  />
		<cfparam name="params.sEcho" type="string" default="10"  />
		<cfparam name="params.sSearch" type="string" default="" />
		<cfparam name="params.iSortingCols" type="integer" default="0"  />
		
		<cfset queryObject = evaluate("#params.qFunctionName#()") />
		<cfset arrayMetaData = getMetaData(queryObject) />
		
		<cfloop index="thisColumn"  from="1" to="#arraylen(arrayMetaData)#">
			<cfset listColumns = ListAppend(listColumns, arrayMetaData[thisColumn]["Name"]) />
			<cfset listColumnsCast = ListAppend(listColumnsCast, "CAST(#arrayMetaData[thisColumn]["Name"]# as VARCHAR) as #arrayMetaData[thisColumn]["Name"]#") />
		</cfloop>

		<!--- set query of queries --->
		<cfset objAttributes.dbtype = "query"/>
		
		<!--- set columns to varchar --->
		<cfset objAttributes.name="queryObject" />
		<cfquery attributecollection="#objAttributes#">
			SELECT #listColumnsCast# 
			FROM queryObject
		</cfquery>
		
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