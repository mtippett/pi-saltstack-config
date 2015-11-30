# need common files 
{% if pillar['roles']['sensu-client'] is defined or pillar['roles']['sensu-server'] is defined%}
rabbitmq-repo:
  pkgrepo.managed:
    - humanname: RabbitMQ
    - name: deb http://www.rabbitmq.com/debian/ testing main
    - dist: testing
    - file: /etc/apt/sources.list.d/rabbitmq.list
    - key_url: https://www.rabbitmq.com/rabbitmq-signing-key-public.asc

sensu-common-pkg:
  pkg.installed:
    - names:
      - rabbitmq-server
      - erlang-nox

sensu-pkg:
  pkg.installed:
    - sources:
      - sensu: salt://files/pkgs/sensu_0.20.6-11_armhf.deb 

sensu:
  group.present:
    - gid: 1500
  user.present:
    - fullname: Sensu User
    - shell: /bin/bash
    - home: /opt/sensu
    - uid: 1500
    - gid: 1500

/etc/sensu:
  file.directory:
    - user: sensu
    - group: sensu
    - makedirs: True

/var/log/sensu:
  file.directory:
    - user: sensu
    - group: sensu
    - makedirs: True

/opt/sensu/sv:
  file.directory:
    - user: sensu
    - group: sensu
    - makedirs: True
    - recurse: 
      - user
      - group

/etc/sensu/conf.d/rabbitmq.json:
  file.managed:
    - source: salt://files/sensu/rabbitmq.json
    - template: jinja
    - makedirs: True

/etc/sensu/conf.d/client.json:
  file.managed:
    - source: salt://files/sensu/client.json
    - template: jinja
    - makedirs: True


{% endif %}

{% if pillar['roles']['sensu-server'] is defined %}
sensu-server-pkg:
  pkg.installed:
    - names:
      - redis-server

/etc/sensu/conf.d/api.json:
  file.managed:
    - source: salt://files/sensu/api.json
    - template: jinja
    - makedirs: True

/etc/sensu/conf.d/checks.json:
  file.managed:
    - source: salt://files/sensu/checks.json
    - template: jinja
    - makedirs: True

/etc/sensu/conf.d/redis.json:
  file.managed:
    - source: salt://files/sensu/redis.json
    - template: jinja
    - makedirs: True


golang:
  pkg.installed

nodejs:
  pkg.installed

npm:
  pkg.installed

{% endif %}
