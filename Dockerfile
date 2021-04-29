FROM anapsix/alpine-java
COPY target/*.jar /home/petclinic.jar
CMD ["java","-jar","/home/petclinic.jar"]
