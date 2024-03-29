FROM tomcat:8.0.51-jre8-alpine
COPY ./target/Amazon.com*.jar /usr/local/tomcat/webapps
EXPOSE  8080
USER year2023
WORKDIR /usr/local/tomcat/webapps
CMD ["catalina.sh","run"]