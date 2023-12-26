ambient_is_ssid "CDWiFi"; or exit

curl -s http://cdwifi.cz/portal/api/vehicle/realtime | jq -r '{
    "AMBIENT_CZ_CD_GPS_LAT": (.gpsLat),
    "AMBIENT_CZ_CD_GPS_LNG": (.gpsLng),
    "AMBIENT_CZ_CD_PREV_GPS_LAT": (.gpsLat),
    "AMBIENT_CZ_CD_PREV_GPS_LNG": (.gpsLng),
    "AMBIENT_CZ_CD_PREV_GPS_LNG": (.gpsLng),
    "AMBIENT_CZ_CD_SPEED": (.speed),
    "AMBIENT_CZ_CD_DELAY": (.delay),
    "AMBIENT_CZ_CD_ALTITUDE": (.altitude),
    "AMBIENT_CZ_CD_TEMPERATURE": (.temperature),
} | to_entries | map(select(.value != null)) | map(.key + "=" + (.value | tostring)) | join("\n")'
