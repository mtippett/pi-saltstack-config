/etc/salt/grains:
  file.managed:
    - source: 
       - salt://minion-grains/grains.{{ grains['host'] }}
       - salt://minion-grains/grains.default
    - template: jinja

