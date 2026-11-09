# Intrusion Detection System with Suricata

CP 81 Comprehension, Project 4. **Student:** Ekari Emmanuel Moyo (23311351007)

Suricata 8.0.8 running on Windows 11 (with Npcap) monitoring my own Wi-Fi network, with six custom detection rules. In testing it raised 13 alerts across four of the six rules: ICMP ping, TCP SYN port scan, SSH brute-force pattern and SQL injection.

## Contents
- `rules/local.rules`: the six custom rules
- `scripts/`: `start_ids.ps1` (test config + start Suricata), `view_alerts.ps1` (live alert view)
- `documentation/setup.md`: install, configuration, problems and fixes, test method
- `evidence/fast.log`: the real alert log from my test run (9 Nov 2026)
- `docs/`: the three-page portfolio website (GitHub Pages)
  - `docs/screenshots/`: screenshots of the alerts

## Portfolio website
https://kayrie18.github.io/Intrusion-Detection-System/

## Note
Only use these tests on your own devices and network.
