# mocker-java
Docker emulated Cloud Foundry Java Buildpack

## Description

This docker image will try to emulate Cloud Foundry runtime for the [Java Buildpack](https://github.com/cloudfoundry/java-buildpack). It is based on the new Cloud Foundry Stack - [cflinuxfs2](https://github.com/cloudfoundry/stacks) which is based in Ubuntu 14.04.

> **WARNING: cf-release v204** was the first release to support cflinuxfs2 stack. Buildpacks prior to this cf-release version could not work.
