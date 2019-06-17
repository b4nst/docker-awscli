workflow "Build and deploy" {
  on = "push"
}

action "build" {
  uses = "actions/docker/cli@master"
  runs = "./build.sh"
}

action "login" {
  uses = "actions/docker/login@master"
  needs = "build"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "publish" {
  uses = "actions/docker/cli@master"
  args = "push banst/awscli"
}

action "github tag" {
  uses = "docker://appropriate/curl:latest"
  needs = "publish"
  secrets = ["GITHUB_TOKEN"]
  args = "-X POST -H 'Accept: application/json' -H \"Authorization: Bearer $GITHUB_TOKEN\" -d @./post_tag.json https://api.github.com/repos/$GITHUB_REPOSITORY/git/refs"
}
