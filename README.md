# Java-dummy-elastic-APM
CRUD Java Service with Elastic Java APM forked from  https://github.com/slgobinath/Java-Helps-Java/tree/master/webservices/microservices/javalin/student-crud


# Requirements to see APM traces
1.Running Elasticsearch ( tested on Elastic cloud version 8.7.1 )
2.Running Kibana ( tested on Elastic cloud version 8.7.1 )
3.Running APM server ( tested on Elastic cloud version 8.7.1 with integration server)

# Setup
1.install Java JDK version 17.0.7 2023-04-18 LTS
2.install maven version Apache Maven 3.9.1
3.install gradle version 8.1.1

# Pre-launch
change values in file 

src/main/resources/elasticapm.properties

server_urls=<your_url>
secret_token=<your_token>

Download version of java APM client , here is used elastic-apm-agent-1.22.0.jar from https://oss.sonatype.org/service/local/repositories/releases/content/co/elastic/apm/elastic-apm-agent/1.22.0/elastic-apm-agent-1.22.0.jar

# Launch
In main catalog run

mvn clean 

mvn install 

then run applicaion 

java -javaagent:elastic-apm-agent-1.22.0.jar -jar target/javalin-student-1.0-SNAPSHOT.jar

also you can run application without config file provided by pointinf proper flags in command like

java -javaagent:elastic-apm-agent-1.22.0.jar -Delastic.apm.service_name=my-service-name -Delastic.apm.secret_token=<your_token> -Delastic.apm.server_url=<your_url> -Delastic.apm.environment=my-environment -Delastic.apm.application_packages=org.example -jar target/javalin-student-1.0-SNAPSHOT.jar

the following line of logs ensure you that APm agent has started

[main] INFO  co.elastic.apm.agent.impl.ElasticApmTracer - Tracer switched to RUNNING state

And tose lines shows that there is connection between your apm server and application agent
[elastic-apm-server-healthcheck] INFO  co.elastic.apm.agent.report.ApmServerHealthChecker - Elastic APM server is available: {..}
[elastic-apm-remote-config-poller] INFO  co.elastic.apm.agent.configuration.ApmServerConfigurationSource - Received new configuration from APM Server: {}

# Examples of use
Create some traces by sending requests to your lunched app
create sudents:
curl -X POST -H "Content-Type: application/json" http://localhost:8080/students -d '{ "id": "002","name": "John","age": 22}'
curl -X POST -H "Content-Type: application/json" http://localhost:8080/students -d '{ "id": "003","name": "Dave","age": 30}'
curl -X POST -H "Content-Type: application/json" http://localhost:8080/students -d '{ "id": "001","name": "Ivan","age": 12}'

Get students:
curl -X GET http://localhost:8080/students

curl -X GET http://localhost:8080/students/003

delete students:

curl -X DELETE http://localhost:8080/students/001

# Screenshots

![Screenshot 2023-05-10 at 18 06 31](https://github.com/44zero0000/Java-dummy-elastic-APM/assets/56760569/ff7da4ad-8950-4061-ac0d-c401bc55a522)
![Screenshot 2023-05-10 at 18 07 29](https://github.com/44zero0000/Java-dummy-elastic-APM/assets/56760569/b4573599-55cb-4e88-8aa2-6b814734f05d)

# Troubleshooting

1. Unsupported class file major version 64

if during launching app problem with agent occurs with below error:

Failed to start agent
java.lang.reflect.InvocationTargetException
        at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:119)
        at java.base/java.lang.reflect.Method.invoke(Method.java:578)
        at co.elastic.apm.agent.premain.AgentMain.loadAndInitializeAgent(AgentMain.java:155)
        at co.elastic.apm.agent.premain.AgentMain.init(AgentMain.java:100)
        at co.elastic.apm.agent.premain.AgentMain.premain(AgentMain.java:56)
        at java.base/jdk.internal.reflect.DirectMethodHandleAccessor.invoke(DirectMethodHandleAccessor.java:104)
        at java.base/java.lang.reflect.Method.invoke(Method.java:578)
        at java.instrument/sun.instrument.InstrumentationImpl.loadClassAndStartAgent(InstrumentationImpl.java:491)
        at java.instrument/sun.instrument.InstrumentationImpl.loadClassAndCallPremain(InstrumentationImpl.java:503)
Caused by: java.lang.IllegalArgumentException: Unsupported class file major version 64

it is probably cause of java version, please make sure to run on 17.0.7, in this case java of 20.0.1 was causing this issue
