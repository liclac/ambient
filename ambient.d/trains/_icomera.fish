ambient_match_icomera_wifi
if test -n $ambient_icomera_provider
	echo AMBIENT_ICOMERA_PROVIDER=$ambient_icomera_provider
	echo AMBIENT_ICOMERA_COUNTRY=$ambient_icomera_country
	ambient_get_icomera_endpoint position | jq -r '"
AMBIENT_ICOMERA_POSITION_LONGITUDE=\(.longitude)
AMBIENT_ICOMERA_POSITION_LATITUDE=\(.latitude)
AMBIENT_ICOMERA_POSITION_ALTITUDE=\(.altitude)
AMBIENT_ICOMERA_POSITION_SPEED=\(.speed)
AMBIENT_ICOMERA_POSITION_SATELLITES=\(.satellites)
"'
	ambient_get_icomera_endpoint users | jq -r '"
AMBIENT_ICOMERA_USERS_TOTAL=\(.total)
AMBIENT_ICOMERA_USERS_ONLINE=\(.online)
"'
	ambient_get_icomera_endpoint user | jq -r '"
AMBIENT_ICOMERA_USER_DATA_DOWNLOAD_USED=\(.data_download_used)
AMBIENT_ICOMERA_USER_DATA_UPLOAD_USED=\(.data_upload_used)
AMBIENT_ICOMERA_USER_DATA_TOTAL_USED=\(.data_total_used)
AMBIENT_ICOMERA_USER_DATA_DOWNLOAD_LIMIT=\(.data_download_limit)
AMBIENT_ICOMERA_USER_DATA_UPLOAD_LIMIT=\(.data_upload_limit)
AMBIENT_ICOMERA_USER_DATA_TOTAL_LIMIT=\(.data_total_limit)
AMBIENT_ICOMERA_USER_BANDWIDTH_DOWNLOAD_LIMIT=\(.bandwidth_download_limit)
AMBIENT_ICOMERA_USER_BANDWIDTH_UPLOAD_LIMIT=\(.bandwidth_upload_limit)
AMBIENT_ICOMERA_USER_TIME_USER=\(.timeused)
AMBIENT_ICOMERA_USER_TIME_LEFT=\(.timeleft)
AMBIENT_ICOMERA_USER_EXPIRES=\(.expires)
AMBIENT_ICOMERA_USER_CLASS=\(.userclass)
AMBIENT_ICOMERA_USER_ONLINE=\(.online)
AMBIENT_ICOMERA_USER_CAP_LEVEL=\(.cap_level)
AMBIENT_ICOMERA_USER_AUTHENTICATED=\(.authenticated)
"'
end