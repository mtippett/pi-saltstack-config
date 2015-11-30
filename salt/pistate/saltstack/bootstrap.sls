download-saltstack-bootstrap:
  cmd.run: 
    - name: curl -L https://bootstrap.saltstack.com -o install_salt.sh

run-saltstack-bootstrap:
  cmd.run:
    - name: sh /root/install_salt.sh -P -b git v2015.8.1

