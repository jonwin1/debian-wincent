# See LICENSE file for copyright and license details.
#!/bin/bash
curl https://pkg.cloudflareclient.com/pubkey.gpg |sudo gpg --yes --dearmor --output /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/cloudflare-client.list
sudo apt-get update && sudo apt-get install cloudflare-warp
warp-cli register
warp-cli connect
warp-cli set-mode warp+doh
warp-cli set-families-mode malware
if !(curl https://www.cloudflare.com/cdn-cgi/trace/ | grep "warp=on"); then
	echo "Error: Unable to configure warp" >> /dev/stderr
fi
