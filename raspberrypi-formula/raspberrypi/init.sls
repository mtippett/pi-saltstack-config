# Writes given key value pairs from pillar.raspberrypi.config to /boot/config.txt

raspberrypi_config:
  file.managed:
    - name: '/boot/config.txt'
    - source: salt://raspberrypi/files/config.txt.jinja
    - template: jinja
