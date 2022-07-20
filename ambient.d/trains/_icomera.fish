set -l ssid (ambient_get_ssid)
switch $ssid
case "GatwickExpress_WiFi"
  set ambient_icomera_country GB
  set ambient_icomera_provider "Gatwick Express"
case "Thameslink_WiFi"
  set ambient_icomera_country GB
  set ambient_icomera_provider Thameslink
case "Southern_WiFi"
  set ambient_icomera_country GB
  set ambient_icomera_provider Southern
case "GreatNorthern_WiFi"
  set ambient_icomera_country GB
  set ambient_icomera_provider "Great Northern"
case "SWR WiFi"
  set ambient_icomera_country GB
  set ambient_icomera_provider "South Western Railway"
case "VirginTrainsEC-WiFi"
  set ambient_icomera_country GB
  set ambient_icomera_provider "Virgin Trains East Coast"
case "TPE Wi-Fi"
  set ambient_icomera_country GB
  set ambient_icomera_provider "TransPennine Express"
case "SJ"
  set ambient_icomera_country SE
  set ambient_icomera_provider SJ
case "Irish Rail - WiFi"
  set ambient_icomera_country IE
  set ambient_icomera_provider "Irish Rail"
case "WIFIonICE"
  set ambient_icomera_country DE
  set ambient_icomera_provider "Deutsche Bahn"
case "THALYSNET"
  set ambient_icomera_country FR
  set ambient_icomera_provider Thalys
end
test -n "$ambient_icomera_provider"; or exit

function ambient_get_icomera_endpoint
	set url https://www.ombord.info/api/jsonp/$argv/

	if test (uname) = "Darwin"
		curl -s $url | tail -c +2 | ghead -c -3
	else
		curl -s $url | tail -c +2 | head -c -3
	end
end

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
