# Should not be run repeatedly as part of highstate
{% if pillar['roles'] == elasticsearch %}
elasticsearch-plugins:
  cmd.run:
    - name: /usr/share/elasticsearch/bin/plugin install royrusso/elasticsearch-HQ
    - name: /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head
{% endif %}
