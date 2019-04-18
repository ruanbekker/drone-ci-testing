# drone-ci-testing [![Build Status](https://cloud.drone.io/api/badges/ruanbekker/drone-ci-testing/status.svg)](https://cloud.drone.io/ruanbekker/drone-ci-testing)
testing cloud.drone.io

## Usage

### Run shell commands in a step

```
kind: pipeline
name: default

steps:
  - name: test
    image: alpine
    environment:
      MYUSERNAME:
        from_secret: myusername
    commands:
      - echo "echo secret"
      - echo $${MYUSERNAME}
      - echo "run env command"
      - env
```

or:

```
pipeline:
  docker:
    image: alpine
    secrets: [ myusername ]
    commands:
      - echo "echo secret"
      - echo $${MYUSERNAME}
      - echo "run env command"
      - env
```

This will output:

```
+ echo "echo secret"
echo secret
+ echo ${MYUSERNAME}
********
+ echo "run env command"
run env command
+ env
DRONE_SYSTEM_HOST=cloud.drone.io
DRONE_COMMIT_AUTHOR_AVATAR=https://avatars0.githubusercontent.com/u/567298?v=4
DRONE_BRANCH=master
DRONE_GIT_SSH_URL=git@github.com:ruanbekker/drone-ci-testing.git
DRONE_JOB_FINISHED=1555573281
CI=true
HOSTNAME=7a20b000f25c
CI_BUILD_STARTED=1555573280
DRONE_REPO_LINK=https://github.com/ruanbekker/drone-ci-testing
DRONE_TARGET_BRANCH=master
DRONE_REPO_NAMESPACE=ruanbekker
DRONE_STAGE_OS=linux
DRONE_COMMIT_AUTHOR=ruanbekker
CI_WORKSPACE=/drone/src
DRONE_GIT_HTTP_URL=https://github.com/ruanbekker/drone-ci-testing.git
DRONE_RUNNER_HOSTNAME=15e89c0f84f1
SHLVL=1
DRONE_COMMIT_BRANCH=master
HOME=/root
DRONE_REPO_SCM=
DRONE_REPO_PRIVATE=false
DRONE_SYSTEM_PROTO=https
DRONE_STEP_NUMBER=2
DRONE_REPO_VISIBILITY=public
DRONE_BUILD_STATUS=success
DRONE_BUILD_ACTION=
DRONE_RUNNER_PLATFORM=linux/amd64
DRONE_WORKSPACE_BASE=/drone/src
DRONE_COMMIT_BEFORE=138bc48338f44be2ef4ad8a57d63d4bf2403da3c
CI_JOB_STARTED=1555573280
DRONE_STAGE_ARCH=amd64
CI_WORKSPACE_PATH=
DRONE_STAGE_STATUS=success
DRONE_SOURCE_BRANCH=master
DRONE_STAGE_NAME=default
DRONE_REPO_BRANCH=master
DRONE_COMMIT_MESSAGE=add envvar
DRONE_DEPLOY_TO=
CI_BUILD_FINISHED=1555573281
DRONE_SYSTEM_HOSTNAME=cloud.drone.io
DRONE_REMOTE_URL=https://github.com/ruanbekker/drone-ci-testing.git
DRONE_JOB_STATUS=success
MYUSERNAME=********
DRONE_REPO_OWNER=ruanbekker
DRONE_STAGE_KIND=pipeline
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
DRONE=true
DRONE_BUILD_NUMBER=15
DRONE_BUILD_STARTED=1555573280
DRONE_BUILD_LINK=https://cloud.drone.io/ruanbekker/drone-ci-testing/15
CI_JOB_FINISHED=1555573281
DRONE_WORKSPACE=/drone/src
DRONE_STAGE_VARIANT=
DRONE_STAGE_DEPENDS_ON=
DRONE_COMMIT_AFTER=05818a52403e07b2cab4d980522e7264be4aa18c
DRONE_STAGE_NUMBER=1
DRONE_STAGE_STARTED=1555573280
DRONE_COMMIT=05818a52403e07b2cab4d980522e7264be4aa18c
DRONE_RUNNER_HOST=15e89c0f84f1
DRONE_JOB_STARTED=1555573280
DRONE_WORKSPACE_PATH=
DRONE_BUILD_EVENT=push
DRONE_COMMIT_SHA=05818a52403e07b2cab4d980522e7264be4aa18c
DRONE_BUILD_CREATED=1555573279
DRONE_COMMIT_AUTHOR_EMAIL=ruan.ru.bekker@gmail.com
DRONE_REPO_NAME=drone-ci-testing
DRONE_STAGE_MACHINE=15e89c0f84f1
DRONE_COMMIT_REF=refs/heads/master
CI_BUILD_STATUS=success
DRONE_MACHINE=15e89c0f84f1
CI_WORKSPACE_BASE=/drone/src
PWD=/drone/src
DRONE_BUILD_FINISHED=1555573281
DRONE_COMMIT_LINK=https://github.com/ruanbekker/drone-ci-testing/compare/138bc48338f4...05818a52403e
DRONE_REPO=ruanbekker/drone-ci-testing
DRONE_STEP_NAME=test
DRONE_SYSTEM_VERSION=1.0.0
DRONE_COMMIT_AUTHOR_NAME=Ruan Bekker
CI_JOB_STATUS=success
DRONE_STAGE_FINISHED=1555573281
```

### Publish to Dockerhub

- Clone
- Build Docker Image
- Publish to Dockerhub with `latest` and `git_commit_id` and use credentials from stored secrets

The `.drone.yml`

```
kind: pipeline
name: default

steps:
  - name: test
    image: alpine
    environment:
      MYUSERNAME:
        from_secret: myusername
    commands:
      - echo "echo secret"
      - echo $${MYUSERNAME}
      - echo "run env command"
      - env
      - echo $${MYUSERNAME} > /tmp/file
      - mkdir -p /tmp/foo/dir
      - touch /tmp/foo/dir/test.txt
      
  - name: publish
    image: plugins/docker
    settings:
      repo: ruanbekker/dronetest
      auto_tag: false
      auto_tag_suffix: alpine
      tags:
        - ${DRONE_COMMIT}
        - latest
      username: 
        from_secret: dockerhub_username
      password:
        from_secret: dockerhub_password
```
