FROM maven:3-jdk-8-onbuild-alpine

RUN mkdir -p /usr/src/app

WORKDIR  /usr/src/app/

ADD . /usr/src/app/
RUN mvn  package -Dmaven.test.skip
FROM registry.redhat.io/openjdk/openjdk-8-rhel8:1.3-2.1595330282

WORKDIR /root/

COPY --from=0 /usr/src/app/target/spring-boot-helloworld-0.0.1-SNAPSHOT.jar .
EXPOSE 8080

CMD ["java","-jar","/root/spring-boot-helloworld-0.0.1-SNAPSHOT.jar"]
