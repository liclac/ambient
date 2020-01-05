ambient_is_ssid "OEBB"; or exit

curl -s https://railnet.oebb.at/assets/modules/fis/combined.json | jq -r '"
AMBIENT_AT_OEBB_SPEED=\(.operationalMessagesInfo.speed)
AMBIENT_AT_OEBB_SITUATION=\(.operationalMessagesInfo.situation)
AMBIENT_AT_OEBB_DELAY=\(.operationalMessagesInfo.delay)
AMBIENT_AT_OEBB_SPEED_UNIT=km/h
AMBIENT_AT_OEBB_LATITUDE=\(.mapInfo.latitude)
AMBIENT_AT_OEBB_LONGITUDE=\(.mapInfo.longitude)
AMBIENT_AT_OEBB_ORIENTATION=\(.mapInfo.orientation)
AMBIENT_AT_OEBB_SERVER_TIME=\(.operationalMessagesInfo.time | strptime("%s") | todate)
AMBIENT_AT_OEBB_TRAIN_TYPE=\(.currentJourney.trainType)
AMBIENT_AT_OEBB_VZN=\(.currentJourney.tripNumber)
AMBIENT_AT_OEBB_ACTUAL_DISTANCE_FROM_LAST_STOP=\(.operationalMessagesInfo.distance)
AMBIENT_AT_OEBB_STOP_FIRST=\(.currentJourney.start.all)
AMBIENT_AT_OEBB_STOP_FIRST_DEPART_SCHEDULED=\((.forecastTimes | first).departureSchedule)
AMBIENT_AT_OEBB_STOP_LAST=\(.currentJourney.destination.all)
AMBIENT_AT_OEBB_STOP_LAST_ARRIVE_SCHEDULED=\((.forecastTimes | last).arrivalSchedule)
AMBIENT_AT_OEBB_STOP_LAST_ARRIVE_ACTUAL=\((.forecastTimes | last).arrivalForecast)
"'

curl -s https://railnet.oebb.at/assets/modules/fis/combined.json | jq -r '"
AMBIENT_AT_OEBB_STOP_NEXT=\({stationList: .stationList[], station_id: .operationalMessagesInfo.situationStation} | select(.stationList.id == .station_id).stationList.name.all)
AMBIENT_AT_OEBB_STOP_NEXT_DEPART_SCHEDULED=\({forecastTimes: .forecastTimes[], station_id: .operationalMessagesInfo.situationStation} | select(.forecastTimes.station_id == .station_id) | .forecastTimes.departureSchedule)
AMBIENT_AT_OEBB_STOP_NEXT_DEPART_ACTUAL=\({forecastTimes: .forecastTimes[], station_id: .operationalMessagesInfo.situationStation} | select(.forecastTimes.station_id == .station_id) | .forecastTimes.departureForecast)
AMBIENT_AT_OEBB_STOP_NEXT_ARRIVE_SCHEDULED=\({forecastTimes: .forecastTimes[], station_id: .operationalMessagesInfo.situationStation} | select(.forecastTimes.station_id == .station_id) | .forecastTimes.arrivalSchedule)
AMBIENT_AT_OEBB_STOP_NEXT_ARRIVE_ACTUAL=\({forecastTimes: .forecastTimes[], station_id: .operationalMessagesInfo.situationStation} | select(.forecastTimes.station_id == .station_id) | .forecastTimes.arrivalForecast)
"'
