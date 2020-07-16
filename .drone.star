def main(ctx):
    return {
        "kind": "pipeline",
        "name": "default",
        "steps": [
            deploy("master", "production"),
            deploy("staging", "staging")
        ]
    }



def deploy(branch, stack):
    return {
        "name": "deploy-%s" % branch,
        "image": "choffmeister/pulumi-continuous-update",
        "pull": "always",
        "commands": [
            "ls -al"
        ],
        "environment": {
            "GITHUB_REPO": "airfocusio/airfocus-deployment",
            "GITHUB_USER": "airfocusbot",
            "GITHUB_ACCESS_TOKEN": {
                "from_secret": "deployment_github_access_token"
            },
            "PULUMI_DIRECTORY": "application",
            "PULUMI_STACK": "%s" % stack,
            "PULUMI_ACCESS_TOKEN": {
                "from_secret": "deployment_pulumi_access_token"
            },
            "DOCKER_TAG": "%s-${DRONE_COMMIT_SHA:0:8}" % stack
        },
        "when": {
            "branch": "%s" % branch,
            "event": "push"
        }
    }