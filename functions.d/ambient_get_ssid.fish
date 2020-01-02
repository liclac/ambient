function ambient_get_ssid
    if not set -q ambient_ssid
        set -g ambient_ssid (iw dev | grep ssid | awk '{print $2}')
    end
    echo $ambient_ssid
end
