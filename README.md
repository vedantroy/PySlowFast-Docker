Repository for building PySlowFast using Docker
Dockerfile does *not* use best practices--this is for prototyping

bug-reproduction contains a set of files that crashes Docker Buildkit.
Before building the main folder or the bug-reproduction, 1st clone PySlowFast into the relevant directory and rename it to SlowFastBuild

## Nvidia Docker
Add package repository + GPG key:

```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```

then `sudo apt-get update && sudo apt-get install -y nvidia-docker2`  
then `sudo systemctl restart docker`