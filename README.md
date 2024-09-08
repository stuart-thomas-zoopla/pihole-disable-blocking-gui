# pihole-disable-blocking-gui
A simple web application that provides a user freindly way to temporarily disable ad blocking services across a single or multiple instances of pihole.

## Why do you want this?
This is particular useful when you have users who sometimes want to interact with things like googles sponsored links etc. It provides a simple GUI for them to have access to temporarily disable adblocking. It is particularly useful when you are running multiple instances of pihole as it will disable across all instances at the same time.

It also comes with dark mode and light mode :grin:
![modes](https://github.com/user-attachments/assets/1fc06a9c-f0ba-4322-bffe-3e5902825771)


## How to install
On your pihole instance run the following command and keep note of the output, this will be required when running the install script.

```cat /etc/pihole/setupVars.conf | grep WEBPASSWORD```

Once you had the password has, run the following command on the container/vm you want to this applicaiton from. Note, it will run the node server on port 3000.

```wget https://raw.githubusercontent.com/stuart-thomas-zoopla/pihole-quick-disable/main/install.sh && bash install.sh```

You will then be prompted for a comma separated list of IP addresses for each pihole instance, this should be provided like so

```192.168.0.12,192.168.0.13``` etc.

You will then be prompted for the password hash. Currently this application assumes all instances share a common password.

Finally you will be prompted to provide a value for the number of seconds blocking should be disabled for. I find 60 seconds works for most users.

Installation will then complete and the service will be available on port 3000.
