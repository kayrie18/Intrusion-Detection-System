# Setup guide: Suricata 8.0.8 on Windows 11

I first tried WSL2 + Ubuntu, but WSL on my laptop failed with `REGDB_E_CLASSNOTREG` ("Class not registered") even after repair attempts, so I ran Suricata natively on Windows.

## 1. Install Npcap (packet capture driver)
Download Npcap 1.90 from https://npcap.com/#download and install with "WinPcap API-compatible Mode" ticked.

**Problem I hit:** the install aborted with `Unknown error 80070005` (access denied). Cause: my third-party antivirus (360 Total Security) blocked the driver install. Fix: pause the antivirus, run the installer, then turn the antivirus back on.

## 2. Install Suricata
Download `Suricata-8.0.8-1-64bit.msi` from https://suricata.io/download/ and install with the defaults (installs to `C:\Program Files\Suricata`). Check:
```
cd "C:\Program Files\Suricata"
.\suricata.exe --build-info
```

## 3. Configure
- Find your Wi-Fi IPv4 address with `ipconfig`.
- `HOME_NET` in `suricata.yaml` already covers the private ranges (192.168.0.0/16, 10.0.0.0/8, 172.16.0.0/12).
- Custom rules are in `rules/local.rules`. The community rule files were not installed, so Suricata is started with `-S rules\local.rules` to load only the custom rules.

**Problem I hit:** the first threshold rules failed to parse. In Suricata 8 the syntax is `count 20, seconds 10` (space, not colon).

## 4. Test the config and start the IDS
```
.\suricata.exe -T -c suricata.yaml -S rules\local.rules -v
.\suricata.exe -c suricata.yaml -S rules\local.rules -i <your-wifi-IP>
```
Success looks like: `6 rules successfully loaded, 0 rules failed` and `Engine started`. Or run `scripts\start_ids.ps1 <your-wifi-IP>`.

## 5. Generate test traffic (own devices only)
My laptop was connected to my phone's hotspot, so the phone acted as the second device.
1. On the laptop: `python -m http.server 8080` (a simple web target).
2. On the phone browser: `http://<laptop-IP>:8080/?id=1%20UNION%20SELECT%201,2` (SQL injection pattern).
3. On the phone, Fing / Net Analyzer: port scan the laptop, range 1 to 1000.
4. On the laptop: `ping <phone-IP>`.

## 6. View alerts
```
Get-Content "C:\Program Files\Suricata\log\fast.log" -Wait
```
Results are in `evidence/fast.log` and on the portfolio Results page.
