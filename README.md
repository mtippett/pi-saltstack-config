# saltstack-config
This project is a prototype project used for exploring saltstack for a collection of Raspberry Pis on a home network.  YMMV

This is intended as a personal project, but feel free to fork and provide pull requests.

# Bootstrapping
Unfortunately as of this writing, raspbian has an old version of salt-minion available with the apt source.  So installing Raspberry Pi could be as easy as

    apt-get install salt-minion

and

    apt-get install salt-master

## Bootstrapping via salt-bootstrap.sh

However, to use modern features, you need to install the the minion via salt bootstrap - more information at https://docs.saltstack.com/en/latest/topics/tutorials/salt_bootstrap.html

Double Unfortunately, the current raspbian release of Jessie doesn't work with the current build of boostrap, failing to install with dependency failures.

However, the semi-manual boostrap install wil work.

### Semi-manual the system

You will need to install the set of packages that represent the dependencies for saltstack.   These are pulled from `install_salt.sh`

     apt-get install python-pip build-essential git-core python-yaml python-m2crypto python-crypto msgpack-python python-zmq python-jinja2 python-yaml python-jinja2

From there you want to install tornado

    pip install tornado

From there you can install saltstack with

    sh ./install_salt.sh -P -b git v2015.8.1

As of this submission, this will install (assuming dependencies) the 2015.8.1 version from git.  

# Initial Configuration

Although there are general references for configuration of a salt-minion, I'll go through the individual steps in painful detail to allow those looking for a specific list of what is needed to do saltstack on raspberry pi will be able to follow.

## Configuring Minions

Under a default configuration under raspbian, the configuration file can be found at `/etc/salt/minion` or in `/etc/salt/minion.d/*.conf` on a very clean installation this will be empty.  Note that the runparts.d model allows easy configuration and resalting of a minion with minimal effort.

For the purposes of testing, I manually configured the machine to be pointing to a local macbook explicitly via IP.  This gives the ability to get things started.  Note that for a home environment, having a static or collection of static IPs should allow both local home machines a home laptop manage the configuration.   Most routers provide the ability to do MAC address reservation for DHCP.  For convenience the two configuration I created `/etc/salt/minion.d/masterdebug.conf` with the contents of

    master: 192.168.1.102
    log_level: debug

Once configured, salt-minion on a raspberry pi can be run with `/etc/init.d/salt-minion restart` or `systemctl restart salt-minion`.

The successful start of the salt minion can be confirmed by looking at `/var/log/salt/minion` for

    2015-11-16 08:25:20,222 [salt.minion    ][WARNING ] Starting the Salt Minion

## Configuring Master

To ease configuration, I have dedicated one Raspberry Pi as a master.  Similar to the minions, it's easier to configure the system to log at at debug level.  The configuration file is `/etc/salt/master`.

# Sample execution

Once you have the two machines configured, you can restart them with the `init.d` command.  Watch for firewall configurations preventing the communication.

## Establishing trust

You should see the following on the server and client indicating the chatting is happening.  On the master

    2015-11-16 15:27:31,161 [salt.master    ][INFO    ] Authentication request from rasp03
    2015-11-16 15:27:31,163 [salt.master    ][INFO    ] Authentication failed from host rasp03, the key is in pending and needs to be accepted with salt-key -a rasp03


and on the minions (you may see a delay a "Generating minion key" and a delay instead of the "Loaded minion key").

    2015-11-16 15:25:40,606 [salt.minion    ][WARNING ] Starting the Salt Minion
    2015-11-16 15:25:40,611 [salt.minion    ][DEBUG   ] Attempting to authenticate with the Salt Master
    2015-11-16 15:25:40,624 [salt.crypt     ][DEBUG   ] Loaded minion key: /etc/salt/pki/minion.pem
    2015-11-16 15:25:40,650 [salt.crypt     ][ERROR   ] The Salt Master has cached the public key for this node, this salt minion will wait for 10 seconds before attempting to re-authenticate

To estabish this trust, you will see

    # salt-key -L
    Unaccepted Keys:
    rasp03
    Accepted Keys:
    rasp01
    Rejected:

To accept this key, you run the `salt-key` command to accept the key.

    # salt-key -a rasp03
    Key for rasp03 accepted.

You should then see the master respond with

    2015-11-16 15:30:23,760 [salt.master    ][INFO    ] Authentication accepted from rasp03

And a matching log message on the minion with

    2015-11-16 15:30:23,717 [salt.minion    ][INFO    ] Authentication with master successful!

## Testing the connection

A convenient way to test the connectivity is to run the `test.ping` command of which a all the configured minions will respond.

    # salt '*' test.echo 'ALL YOUR BASES ARE BELONG TO US.'
    rasp01: ALL YOUR BASES ARE BELONG TO US.
    rasp03: ALL YOUR BASES ARE BELONG TO US.

Congratulations.  Your saltstack configuration has been confirmed.



# Further useful references

## Raspberry Pi saltstack

Some useful forumulas for configuring the kernel configuration

    https://github.com/daschatten/raspberrypi-formula
