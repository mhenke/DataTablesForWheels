<cfcomponent output="false" mixin="controller">

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
						"sAjaxSource": "<cfoutput>#URLFor(controller=arguments.myController,action="dataTablesprocessing",params="qFunctionName=#arguments.myAction#&sIndexColumn=#arguments.sIndexColumn#")#</cfoutput>"
					} );
				} );
			</script>
		</cfsavecontent>
		
		<cfhtmlhead text = "#datasorter_js#">
	</cffunction>
	
	<cffunction name="getdatatablesHTML">
		<cfargument name="myAction" type="string" required="true" />
		<cfargument name="myColumnNamesArray" type="array"  required="true" />
		
		<cfset var myActionID = "#arguments.myAction#_table_id" />
		<cfset var datasorter_html = "" />
		<cfset var myColumnName = "" />
		
		<cfsavecontent variable="datasorter_html">
			<table cellpadding="0" cellspacing="0" border="0" class="display" id="<cfoutput>#myActionID#</cfoutput>">
				<thead>
					<tr>
						<cfloop index="myColumnName" array="#myColumnNamesArray#">
						   <cfoutput><th>#myColumnName#</th></cfoutput>
						</cfloop>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="4" class="dataTables_empty">Loading data from server</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<cfloop index="myColumnName" array="#myColumnNamesArray#">
						   <cfoutput><th>#myColumnName#</th></cfoutput>
						</cfloop>
					</tr>
				</tfoot>
			</table>
		</cfsavecontent>
		
		<cfreturn datasorter_html />
	</cffunction>
	
</cfcomponent>