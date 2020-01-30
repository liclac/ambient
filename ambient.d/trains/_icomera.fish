set -l ssid (ambient_get_ssid)
switch $ssid
case "GatwickExpress_WiFi"
  set -g ambient_icomera_country GB
  set -g ambient_icomera_prefix GB_GATWICK_EXPRESS
  set -g ambient_icomera_provider "Gatwick Express"
case "Thameslink_WiFi"
  set -g ambient_icomera_country GB
  set -g ambient_icomera_prefix GB_THAMESLINK
  set -g ambient_icomera_provider Thameslink
case "Southern_WiFi"
  set -g ambient_icomera_country GB
  set -g ambient_icomera_prefix GB_SOUTHERN
  set -g ambient_icomera_provider Southern
case "GreatNorthern_WiFi"
  set -g ambient_icomera_country GB
  set -g ambient_icomera_prefix GB_GREAT_NORTHERN
  set -g ambient_icomera_provider "Great Northern"
case "SWR WiFi"
  set -g ambient_icomera_country GB
  set -g ambient_icomera_prefix GB_SWR
  set -g ambient_icomera_provider "South Western Railway"
case "VirginTrainsEC-WiFi"
  set -g ambient_icomera_country GB
  set -g ambient_icomera_prefix GB_VTEC
  set -g ambient_icomera_provider "Virgin Trains East Coast"
case "SJ"
  set -g ambient_icomera_country SE
  set -g ambient_icomera_prefix SE_SJ
  set -g ambient_icomera_provider SJ
case "Irish Rail - WiFi"
  set -g ambient_icomera_country IE
  set -g ambient_icomera_prefix IE_IRISH_RAIL
  set -g ambient_icomera_provider "Irish Rail"
case "WIFIonICE"
  set -g ambient_icomera_country DE
  set -g ambient_icomera_prefix DE_DEUTSCHE_BAHN
  set -g ambient_icomera_provider "Deutsche Bahn"
end

if test -n $ambient_icomera_provider
	function ambient_get_icomera_endpoint
		set url https://www.ombord.info/api/jsonp/$argv/

		if test (uname) = "Darwin"
			curl -s $url | tail -c +2 | ghead -c -3
		else
			curl -s $url | tail -c +2 | head -c -3
		end
	end	

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
