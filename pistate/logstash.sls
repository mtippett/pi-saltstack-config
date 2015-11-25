logstash:
  pkg.installed:
    - sources:
      - logstash: https://download.elastic.co/logstash/logstash/packages/debian/logstash_2.0.0-1_all.deb
  service.running:
    - enable: True
    - reload: True
