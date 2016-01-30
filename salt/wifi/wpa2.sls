/etc/wpa_supplicant/wpa_supplicant.conf:
    file.managed:
    - source: salt://wifi/wpa_supplicant-wpa2.conf
    - template: jinja
    - makedirs: True
