workflow "Build and deploy" {
  on       = "push"
  resolves = "github tag"
}

action "build" {
  uses = "actions/docker/cli@master"
  runs = "./build.sh"
}

action "login" {
  uses    = "actions/docker/login@master"
  needs   = "build"

  secrets = [
    "DOCKER_USERNAME",
    "DOCKER_PASSWORD"
  ]
}

action "publish" {
  uses  = "actions/docker/cli@master"
  needs = "login"
  args  = "push banst/awscli"
}

action "github tag" {
  uses    = "docker://appropriate/curl:latest"
  needs   = "publish"

  runs    = [
    "sh",
    "-c",
    "curl -X POST -H 'Accept: application/json' -H \"Authorization: Bearer $GITHUB_TOKEN\" -d @./post_tag.json https://api.github.com/repos/$GITHUB_REPOSITORY/git/refs"
  ]

  secrets = [
    "GITHUB_TOKEN"
  ]
}
