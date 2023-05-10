
FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
ADD out/artifacts/javalin_student_jar/javalin-student.jar javalin-student.jar
EXPOSE 8080
ENTRYPOINT exec java $JAVA_OPTS -jar javalin-student.jar
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
#ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar javalin-student.jar
