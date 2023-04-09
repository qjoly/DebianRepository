"""Run all Dagger script in parallel using threads."""
import sys
import anyio

import docker_build

if __name__ == "__main__":
        anyio.run(docker_build.docker_image_build)
        print("Docker image build finished")

