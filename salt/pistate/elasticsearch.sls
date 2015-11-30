{% if pillar['roles']['elasticsearch'] is defined %}
elasticsearchn:
  pkg.installed:
    - sources:
      - elasticsearch: https://download.elasticsearch.org/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/2.0.0/elasticsearch-2.0.0.deb
  service.running:
    - enable: True
    - reload: True
#    - require:
#      - pkg : oracle-java8-jdk

/etc/elasticsearch/elasticsearch.yml:
  file.managed:
    - source: salt://files/conf/elasticsearch.yml
    - template: jinja
{% endif %}
