dev-pkg:
  pkg.installed:
    - names:
      - lsof
      - strace
      - vim
      - pciutils
      - build-essential
      - python-dev
      - python-pip
      - oracle-java8-jdk
      - gcc-4.9
      - libssl-dev

uninstall-pkg:
  pkg.removed:
    - names: 
      - nano
      - gcc-4.6-base

tornado:
  pip.installed

pyOpenSSL:
  pip.installed
