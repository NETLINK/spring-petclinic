FROM tomcat:8
#ADD target/*.war $CATALINA_HOME/webapps/

#FROM anapsix/alpine-java 
COPY target/*.jar $CATALINA_HOME/webapps/
#CMD ["java","-jar","/home/spring-petclinic-1.5.1.jar"]

EXPOSE 8080

#CMD ["catalina.sh", "run"]
