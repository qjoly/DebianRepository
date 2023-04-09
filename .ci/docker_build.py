"""Build docker image for multiple architectures"""

import sys
import anyio
import dagger
import os
import threading

async def docker_image_build():
  platforms = ["linux/amd64"]

  async with dagger.Connection(dagger.Config(log_output=sys.stderr)) as client:

    src = client.host().directory(".")

    variants = []
    for platform in platforms:
      print(f"Building for {platform}")
      platform = dagger.Platform(platform)
      build = (
            client.container(platform=platform)
            .build(
                context = src,
                dockerfile = "Dockerfile",
            )
        )
      variants.append(build)
    
    await client.container().publish("qjoly/aptly:latest", platform_variants=variants)
    print("All build have finished")


if __name__ == "__main__":
    try:
      anyio.run(docker_image_build)
    except:
      print("Error in Docker image build")