## This file contains couple of commands that help managing the project.
##
## Below you can find information about repositories where the project is deployed. The original information about destination repositories is available at http://central.sonatype.org/pages/ossrh-guide.html.

## Deploy the project to the snapshot repository. It will be deployed to the https://oss.sonatype.org/content/repositories/snapshots/ public repository. Note that the version string of the project must end with "-SNAPSHOT".
deploy-snapshot:
	mvn clean deploy

## Deploy the project to the public repository containing release versions of the libraries. The public repository is available at https://oss.sonatype.org/content/repositories/releases/. This repository is synced with Maven's Central Repository.
deploy-release:
	mvn clean deploy -P release

## Create HTML version of the README file
readme-html:
	pandoc -N -t html -s --no-wrap --toc -o README.html README.mkd

