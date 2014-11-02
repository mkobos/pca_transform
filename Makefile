## This file contains couple of commands that help managing the project.
##
## Below you can find information about repositories where the project is deployed. The original information about destination repositories is available at http://central.sonatype.org/pages/ossrh-guide.html.

## Deploy the project to the snapshot repository. It will be deployed to the https://oss.sonatype.org/content/repositories/snapshots/ public repository. Note that the version string of the project must end with "-SNAPSHOT".
deploy-to-snapshot:
	mvn clean deploy

## Deploy the project to the staging repository. This repository is meant for internal use of the developers of given project and it is located at https://oss.sonatype.org/service/local/staging/deploy/maven2. 
deploy-to-staging:
	mvn clean deploy -P release

## Copy the project deployed to the staging repository to the public repository. The public repository is available at https://oss.sonatype.org/content/repositories/releases/
publish-from-staging:
	mvn nexus-staging:release

## Create HTML version of the README file
readme-html:
	pandoc -N -t html -s --no-wrap --toc -o README.html README.mkd

