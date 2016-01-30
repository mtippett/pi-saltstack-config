/etc/wpa_supplicant/wpa_supplicant.conf:
    file.managed:
    - source: salt://wallboards/files/wpa_supplicant.conf
    - template: jinja
    - makedirs: True
