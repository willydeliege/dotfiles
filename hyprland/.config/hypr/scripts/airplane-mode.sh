#!/bin/bash
# Airplane Mode. Turning on or off all wifi using rfkill.

# Check if any wireless device is blocked
wifi_blocked=$(rfkill list wifi | grep -o "Soft blocked: yes")

if [ -n "$wifi_blocked" ]; then
    rfkill unblock wifi
else
    rfkill block wifi
fi
