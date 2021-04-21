#FROM tomcat:8
#COPY target/*.jar $CATALINA_HOME/webapps/
#EXPOSE 8080

FROM anapsix/alpine-java
COPY target/*.jar /home/petclinic.jar
CMD ["java","-jar","/home/petclinic.jar"]
