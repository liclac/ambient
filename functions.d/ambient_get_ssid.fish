function ambient_get_ssid
    if not set -q ambient_ssid
        if test (uname) = "Darwin"
            set -g ambient_ssid (/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | sed -n 's/^ *SSID: //p')
        else
            set -g ambient_ssid (iw dev | grep ssid | sed -n 's/^\s*ssid //p')
        end
    end
    echo $ambient_ssid
end
