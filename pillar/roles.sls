roles:
# General rules
{% if not grains['host'] == 'WeatherPi' %}
  elasticsearch: true
  sensu-client: true
{% endif %}

# System specific items
{% if grains['host'] == 'rasp01' %}
  logstash: true
{% elif grains['host'] == 'rasp02' %}
  salt-master: true
{% elif grains['host'] == 'rasp11' %}
  sensu-server: true
{% elif grains['host'] == 'rasp09' %}
  phoromatic: true
{% elif grains['host'] == 'WeatherPi' %}
  weatherpi: true
{% endif %}

