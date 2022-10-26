function ambient_get_ssid
    if not set -q ambient_ssid
        if test (uname) = "Darwin" # On macOS, query the airport tool.
            set -g ambient_ssid (/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | sed -n 's/^ *SSID: //p')
        else
            # Try to get the SSID via `iw`. This is the quickest, most widely supported option.
            if command -q iw
                set -g ambient_ssid (iw dev | grep ssid | sed -n 's/^\s*ssid //p' | string trim)
            end

            # In some setups (why?), `iw dev` can't show an SSID. Try querying NetworkManager?
            if test -z $ambient_ssid; and command -q nmcli
                set -g ambient_ssid (nmcli -t -f type,name connection show --active |\
                    string match -rg '802-11-wireless:(.*)')
            end
        end
    end
    echo $ambient_ssid
end
