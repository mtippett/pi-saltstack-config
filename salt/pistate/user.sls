pi:
  user.present:
    - fullname: Raspberry Pi
    - shell: /bin/bash
    - home: /home/pi
    - uid: 1000
    - gid: 1000
  ssh_auth.present:
    - user: pi
    - source: salt://files/ssh/id_rsa.pub

