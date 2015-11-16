base: 
  '*': 
    - pistate.user
    - pistate.packages

  'roles:elasticsearch':
    - match: grain
    - pistate.elasticsearch

  'roles:logstash':
    - match: grain
    - pistate.logstash
