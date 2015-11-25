roles:
  - elasticsearch
{% if grains['host'] == 'rasp01' %}
  - logstash
{% elif grains['host'] == 'rasp02' %}
  - salt-master
{% endif %}

