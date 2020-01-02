function ambient_get_ssid
    iw dev | grep ssid | awk '{print $2}'
end
