ambient_match_icomera_wifi
if test -n $ambient_icomera_provider
	set PREFIX "AMBIENT_$ambient_icomera_prefix"
	ambient_get_icomera_endpoint position | jq --arg prefix "$PREFIX" -r '"
\($prefix)_POSITION_LONGITUDE=\(.longitude)
\($prefix)_POSITION_LATITUDE=\(.latitude)
\($prefix)_POSITION_ALTITUDE=\(.altitude)
\($prefix)_POSITION_SPEED=\(.speed)
\($prefix)_POSITION_SATELLITES=\(.satellites)
"'
	ambient_get_icomera_endpoint users | jq --arg prefix "$PREFIX" -r '"
\($prefix)_USERS_TOTAL=\(.total)
\($prefix)_USERS_ONLINE=\(.online)
"'
	ambient_get_icomera_endpoint user | jq --arg prefix "$PREFIX" -r '"
\($prefix)_USER_DATA_DOWNLOAD_USED=\(.data_download_used)
\($prefix)_USER_DATA_UPLOAD_USED=\(.data_upload_used)
\($prefix)_USER_DATA_TOTAL_USED=\(.data_total_used)
\($prefix)_USER_DATA_DOWNLOAD_LIMIT=\(.data_download_limit)
\($prefix)_USER_DATA_UPLOAD_LIMIT=\(.data_upload_limit)
\($prefix)_USER_DATA_TOTAL_LIMIT=\(.data_total_limit)
\($prefix)_USER_BANDWIDTH_DOWNLOAD_LIMIT=\(.bandwidth_download_limit)
\($prefix)_USER_BANDWIDTH_UPLOAD_LIMIT=\(.bandwidth_upload_limit)
\($prefix)_USER_TIME_USER=\(.timeused)
\($prefix)_USER_TIME_LEFT=\(.timeleft)
\($prefix)_USER_EXPIRES=\(.expires)
\($prefix)_USER_CLASS=\(.userclass)
\($prefix)_USER_ONLINE=\(.online)
\($prefix)_USER_CAP_LEVEL=\(.cap_level)
\($prefix)_USER_AUTHENTICATED=\(.authenticated)
"'
end
