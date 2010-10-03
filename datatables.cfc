<cfcomponent output="false">

	 <cffunction name="init">
		<cfset this.version = "1.0.5">
		<cfreturn this>
	</cffunction>
	
	<cffunction name="getdatatablesJS">
		<cfargument name="myController" type="string" required="true" />
		<cfargument name="myAction" type="string" required="true" />
		<cfargument name="sIndexColumn" type="string" default="1" />
		
		<cfset var myActionID = "#arguments.myAction#_table_id" />
		<cfset var datasorter_js = "" />
		
		<cfsavecontent variable="datasorter_js">
			<cfoutput>
			#javaScriptIncludeTag("jquery.dataTables.min")#
			</cfoutput>
			<script type="text/javascript" charset="utf-8">
				$(document).ready(function() {
					$('#<cfoutput>#myActionID#</cfoutput>').dataTable( {
						"bProcessing": true,
						"bServerSide": true,
						"sPaginationType": "full_numbers",
						"sAjaxSource": "/index.cfm/<cfoutput>#arguments.myController#</cfoutput>/dataTablesprocessing?qFunctionName=<cfoutput>#arguments.myAction#</cfoutput>&sIndexColumn=<cfoutput>#arguments.sIndexColumn#</cfoutput>"
					} );
				} );
			</script>
		</cfsavecontent>
		
		<cfhtmlhead text = "#datasorter_js#">
	</cffunction>
	
</cfcomponent>