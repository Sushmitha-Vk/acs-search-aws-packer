#!/bin/bash

DIST_DIR='/tmp/acs-61-files/stagemonitor/insight'
SEARCH_DIR='/opt/alfresco-search-services'

WEB_XML='<listener><listener-class>org.alfresco.stagemonitor.servlet.StagemonitorServletContextListener</listener-class></listener>'
grep "^$WEB_XML" $SEARCH_DIR/solr/server/solr-webapp/webapp/WEB-INF/web.xml || sed -i '/<\/web-app>/i\'"$WEB_XML" $SEARCH_DIR/solr/server/solr-webapp/webapp/WEB-INF/web.xml

/bin/cp -u $DIST_DIR/solr/server/lib/jackson-*.jar $SEARCH_DIR/solr/server/solr-webapp/webapp/WEB-INF/lib/

/bin/cp -u $DIST_DIR/solr/server/lib/*.jar $SEARCH_DIR/solr/server/lib

sed -i "s/^#SOLR_JAVA_HOME.*/SOLR_JAVA_HOME=/g" $SEARCH_DIR/solr.in.sh

# echo 'SOLR_OPTS="$SOLR_OPTS -javaagent:/opt/alfresco-search-services/server/lib/byte-buddy-agent-1.9.5.jar -Dstagemonitor.property.overrides=/opt/alfresco-search-services/solr/server/stagemonitor.properties"' >> $SEARCH_DIR/solr.in.sh
echo 'SOLR_OPTS="$SOLR_OPTS -Dstagemonitor.property.overrides=/opt/alfresco-search-services/solr/server/stagemonitor.properties"' >> $SEARCH_DIR/solr.in.sh
