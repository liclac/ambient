function ambient_get_ssid
    if not set -q ambient_ssid
    	set os (uname)
    	if [ $os = "Darwin" ]
        	set -g ambient_ssid (/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F: '/ SSID/{print $2}')
    	else 
    		set -g ambient_ssid (iw dev | grep ssid | awk '{print $2}')
		end
    end
    echo $ambient_ssid
end
