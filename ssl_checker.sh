#!/bin/bash

DOMAIN="google.com"
PORT=443

# 1. Get the expiration date from the website
# openssl s_client = connects to the site securely
# -servername = needed for modern hosting
# | openssl x509 = reads the certificate information
END_DATE=$(echo | openssl s_client -servername $DOMAIN -connect $DOMAIN:$PORT 2>/dev/null | openssl x509 -noout -enddate | cut -d= -f2)

# 2. Convert dates to seconds (for math)
EXP_DATE_SECONDS=$(date -d "$END_DATE" +%s)
NOW_SECONDS=$(date +%s)

# 3. Calculate days remaining
DAYS_LEFT=$(( ($EXP_DATE_SECONDS - $NOW_SECONDS) / 86400 ))

# 4. Alert if it expires in less than 30 days
if [ "$DAYS_LEFT" -lt 30 ]; then
    echo "[WARNING] SSL Certificate for $DOMAIN expires in $DAYS_LEFT days!"
else
    echo "[OK] SSL Certificate for $DOMAIN is valid for $DAYS_LEFT more days."
fi