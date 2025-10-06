# Dockerfile (Tomcat 10.1 + JDK17)
FROM tomcat:10.1-jdk17-temurin

ENV CATALINA_OPTS="-Dfile.encoding=UTF-8"

# (facultatif) Nettoie les apps par défaut de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copie le WAR construit par Maven
COPY target/iotplatform.war /usr/local/tomcat/webapps/

EXPOSE 8080
CMD ["catalina.sh", "run"]