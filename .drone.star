def main(ctx):
    return {
        "kind": "pipeline",
        "name": "default",
        "steps": [
            step("first"),
            step("second")
        ]
    }

def step(name):
    return {
        "name": "stage-%s" % name,
        "image": "busybox",
        "commands": [
            "id"
        ]
    }