ambient_is_ssid "WIFI@DB" "WIFIonICE"; or exit

curl -s https://iceportal.de/api1/rs/status | jq -r '"
AMBIENT_DE_ICE_CONNECTION=\(.connection)
AMBIENT_DE_ICE_SERVICE_LEVEL=\(.servicelevel)
AMBIENT_DE_ICE_INTERNET=\(.internet)
AMBIENT_DE_ICE_SPEED=\(.speed)
AMBIENT_DE_ICE_SPEED_UNIT=km/h
AMBIENT_DE_ICE_GPS_STATUS=\(.gpsStatus)
AMBIENT_DE_ICE_TZN=\(.tzn)
AMBIENT_DE_ICE_SERIES=\(.series)
AMBIENT_DE_ICE_LATITUDE=\(.latitude)
AMBIENT_DE_ICE_LONGITUDE=\(.longitude)
AMBIENT_DE_ICE_SERVER_TIME=\(.serverTime / 1000 | round | tostring | strptime("%s") | todate)
AMBIENT_DE_ICE_WAGON_CLASS=\(.wagonClass)
AMBIENT_DE_ICE_NAVIGATION_CHANGE=\(.navigationChange | strptime("%Y-%m-%d-%H-%M-%S") | todate)
AMBIENT_DE_ICE_TRAIN_TYPE=\(.trainType)
"'

curl -s https://iceportal.de/api1/rs/tripInfo/trip | jq -r '"
AMBIENT_DE_ICE_TRIP_DATE=\(.trip.tripDate)
AMBIENT_DE_ICE_VZN=\(.trip.vzn)
AMBIENT_DE_ICE_ACTUAL_POSITION=\(.trip.actualPosition)
AMBIENT_DE_ICE_ACTUAL_DISTANCE_FROM_LAST_STOP=\(.trip.distanceFromLastStop)
AMBIENT_DE_ICE_ACTUAL_TOTAL_DISTANCE=\(.trip.totalDistance)

AMBIENT_DE_ICE_STOP_FIRST=\((.trip.stops | first).station.name)
AMBIENT_DE_ICE_STOP_FIRST_DEPART_SCHEDULED=\((.trip.stops | first).timetable.scheduledDepartureTime  / 1000 | round | tostring | strptime("%s") | todate)
AMBIENT_DE_ICE_STOP_FIRST_DEPART_ACTUAL=\((.trip.stops | first).timetable.actualDepartureTime/ 1000 | round | tostring | strptime("%s") | todate)
AMBIENT_DE_ICE_STOP_FIRST_DEPART_DELAY=\((.trip.stops | first).timetable.departureDelay)

AMBIENT_DE_ICE_STOP_LAST=\((.trip.stops | last).station.name)
AMBIENT_DE_ICE_STOP_LAST_ARRIVE_SCHEDULED=\((.trip.stops | last).timetable.scheduledArrivalTime  / 1000 | round | tostring | strptime("%s") | todate)
AMBIENT_DE_ICE_STOP_LAST_ARRIVE_ACTUAL=\((.trip.stops | last).timetable.actualArrivalTime/ 1000 | round | tostring | strptime("%s") | todate)
AMBIENT_DE_ICE_STOP_LAST_ARRIVE_DELAY=\((.trip.stops | last).timetable.arrivalDelay)

AMBIENT_DE_ICE_STOP_NEXT=\(([.trip.stops[] | select(.info.passed == false)] | first).station.name)
AMBIENT_DE_ICE_STOP_NEXT_DEPART_SCHEDULED=\(([.trip.stops[] | select(.info.passed == false)] | first).timetable.scheduledDepartureTime  / 1000 | round | tostring | strptime("%s") | todate)
AMBIENT_DE_ICE_STOP_NEXT_DEPART_ACTUAL=\(([.trip.stops[] | select(.info.passed == false)] | first).timetable.actualDepartureTime/ 1000 | round | tostring | strptime("%s") | todate)
AMBIENT_DE_ICE_STOP_NEXT_DEPART_DELAY=\(([.trip.stops[] | select(.info.passed == false)] | first).timetable.departureDelay)
AMBIENT_DE_ICE_STOP_NEXT_ARRIVE_SCHEDULED=\(([.trip.stops[] | select(.info.passed == false)] | first).timetable.scheduledArrivalTime  / 1000 | round | tostring | strptime("%s") | todate)
AMBIENT_DE_ICE_STOP_NEXT_ARRIVE_ACTUAL=\(([.trip.stops[] | select(.info.passed == false)] | first).timetable.actualArrivalTime/ 1000 | round | tostring | strptime("%s") | todate)
AMBIENT_DE_ICE_STOP_NEXT_ARRIVE_DELAY=\(([.trip.stops[] | select(.info.passed == false)] | first).timetable.arrivalDelay)
"'
