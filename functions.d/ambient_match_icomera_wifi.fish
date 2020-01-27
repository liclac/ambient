function ambient_match_icomera_wifi
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
end
