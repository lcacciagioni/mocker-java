# mocker-java
Docker emulated Cloud Foundry Java Buildpack

## Description

This docker image will try to emulate Cloud Foundry runtime for the [Java Buildpack](https://github.com/cloudfoundry/java-buildpack). It is based on the new Cloud Foundry Stack - [cflinuxfs2](https://github.com/cloudfoundry/stacks) which is based upon Ubuntu 14.04.

> **WARNING: [cf-release v204](https://groups.google.com/a/cloudfoundry.org/forum/#!topic/vcap-dev/gU7rpD8MSC4)** was the first release to support cflinuxfs2 stack. Buildpacks prior to this cf-release version could not work.

## Configuration
This image has a few env vars that you can modify to alter the behavior at runtime. You can check it [here](https://github.com/lcacciagioni/mocker-java/blob/master/Dockerfile#L6) and [here](https://github.com/lcacciagioni/mocker-java/blob/master/entrypoint.sh#L3-L13). But the 3 more important are:
* **RUN_COMMAND**: This is the command to run your app. For most java apps this defaults to what `bin/expose` script creates([Details](http://docs.cloudfoundry.org/buildpacks/custom.html)).
* **BP_URL**: This is the java buildpack git url. This is mainly intended for custom java buildpacks. `default: https://github.com/cloudfoundry/java-buildpack.git`
* **BP_VERSION**: This is the version of the buildpack to checkout. `default: v2.7.1`

> Two important thing to know is that ***you must mount your code/object in the /object path of the image*** and ***Default listening port is 8080 (Remember to expose it)***, you can check the next examples to see how to do this.-

## Usage
For this examples we use the [spring-music](https://github.com/cloudfoundry-samples/spring-music#running-the-application-on-cloud-foundry) sample app. And for the check you can use your browser to see the [http://localhost:8080](http://localhost:8080) url.-
```bash
$ docker run -p 8080:8080 -v $HOME/workspace/spring-music/build/libs/spring-music.war:/object cacciald/mocker-java:latest
```

> For a more advanced deployment I can recommend you to use [fig/docker compose](https://docs.docker.com/compose/).-
