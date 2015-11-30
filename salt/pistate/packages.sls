util-pkg:
  pkg.installed:
    - names:
      - lsof
      - strace
      - vim
      - pciutils
      - build-essential

info-pkgs:
  pkg.installed:
    - names:
      - dmidecode
      - virt-what 

java-pkg:
  pkg.installed:
    - names:
      - oracle-java8-jdk

dev-pkg:
  pkg.installed:
    - names:
      - libffi-dev
      - libssl-dev

# Arguably a lot of these could be installed by running the under pip, but prefer the distribution versions
python-pkg:
  pkg.installed:
    - names:
      - python-yaml
      - python-jinja2
      - python-dev
      - python-pip
      - python-openssl
      - python-m2crypto
      - python-crypto
      - python-zmq
      - python-msgpack
      - python-singledispatch
      - python-apt

uninstall-pkg:
  pkg.removed:
    - names: 
      - nano
      - gcc-4.6-base

# Tornado in python-tornado resuts in a unresponsive minion 
tornado:
  pip.installed
