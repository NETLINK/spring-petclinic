FROM tomcat:8
COPY target/*.jar $CATALINA_HOME/webapps/
EXPOSE 8080
