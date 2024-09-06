# nvidia-multifan

## NVIDIA fan control script for Linux

*Minimal shell script adapted from [https://github.com/wotikama/nvidiafan](nvidiafan) to allow controlling multiple fans independently.*

This script doesn't use a config file like [https://github.com/nan0s7/nfancurve](nfancurve) but expects you to change the script directly with the desired values.

### Prerequisites

The script relies on the `nvidia-settings` command provided by the 'nvidia-settings' package on most distros. Make sure this is installed.

For Wayland, you also likely need NVIDIA driver version 520 or higher. Older versions don't support fan control.

### Copying and setting up the script

It's important the script can be run as super user (sudo), otherwise it won't work because the GPU commands won't have enough permissions to run.

Here's an example of copying and setting up the script:

```
sudo mkdir /opt/nvidia-multifan
sudo cp ~/Downloads/nvidia-multifan.sh /opt/nvidia-multifan
sudo chmod +x /opt/nvidia-multifan/nvidia-multifan.sh
```

Of course, you can also put it in a different location.

Then:

```
sudo vim /opt/nvidia-multifan/nvidia-multifan.sh
```

The comments in the script file itself should be clear enough, but basically, you need to define your own temperature categories and then add fan speed values (in percentages) to the `setfan` command.

### Run in background

Of course, it's convenient to have this script running in the background and in that way take over fan control from the GPU.

For that purpose, I've also included a simple systemd unit file. You can copy and enable it like this:

```
sudo cp ~/Downloads/nvidia-multifan.service /etc/systemd/system
sudo systemctl enable nvidia-multifan.service --now
```

If the script is in a different location than `/opt/nvidia-multifan` make sure to adjust the service file for this.
