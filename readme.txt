CFWheels plugin for LESS v0.1
http://github.com/mhenke/lessForWheels

Third party software:
http://javaloader.riaforge.org/
http://www.mozilla.org/rhino/
http://www.asual.com/lesscss/

Requires:
# Wheels 1.0.5
# javaloaderCFWheels plugin
# http://github.com/mhenke/javaloaderCFWheels
 
TO USE
1) Place the LessEngine-X.X.zip in your plugins folder

2) Make sure you have the JavaLoader-xx.xx.zip installed.
http://github.com/mhenke/javaloaderCFWheels

4) Add to events/onapplicationstart.cfm this code 
	<cfset application.javaloader = javaLoader() />
	<cfset doLessGeneration = LessEngine() />

You should be good to go now and generate css files from less files.

EXAMPLES OF USE
Create your less files in /stylesheets/less
On Application Start your less files will be generated and created in the stylesheets folder
 
ADDITIONAL FOR DEMO 
Unzip the Demo-x.x.zip file into CFWheel's webroot.
 
Reload your Wheels application.
Example: http://localhost/index.cfm?reload=true