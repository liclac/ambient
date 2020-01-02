function ambient_is_ssid
    set -l ssid (ambient_get_ssid)
    for arg in $argv
        if [ "$arg" = "$ssid" ]
            return 0
        end
    end
    return 1
end
