/etc/salt/minion.d/salt-master.conf:
  file.managed:
    - source: salt://files/conf/salt-master.conf
    - template: jinja
    - makedirs: True
