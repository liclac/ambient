ambient_is_ssid "EurostarTrainsWiFi"; or exit

# This is a horrible hack to get data out of a socket.io server, by pretending to be a broken
# client (which can't correctly do websockets), and a bunch of data mangling.
#
# The socket.io protocol consists of messages in the form: 96:0:..., where 96 is the length of the
# message, 0 is the message type, and ... is the actual data.
#
# First of all, the length is binary. By discarding all data that isn't a printable character, we
# get something which we can pipe into `jq`, which will split out all JSON objects it can find.
# Numbers are valid objects, which means that the type field will end up being one - so we further
# discard any lines containing just numbers.
#
# This is brittle as all heck, but it works because the Eurostar only sends short payloads anyhow.
function sio_poll
    set sid $argv[1]
    curl -s "https://onboard.eurostar.com:5555/socket.io/?EIO=3&transport=polling&sid=$sid" \
        | tr -cd '[:print:]' | jq -c | sed -E 's/^[0-9]+$//'
end

set -l sid (sio_poll "" | jq -r '.sid')
set -l payloads
while [ -z "$payloads" ]
    set payloads (sio_poll $sid)
end
set -l payload $payloads[-1]

echo $payload | jq -r '"
AMBIENT_EU_EUROSTAR_LAT=\(.[1].LAT)
AMBIENT_EU_EUROSTAR_LON=\(.[1].LON)
AMBIENT_EU_EUROSTAR_SPEED=\(.[1].SPEED)
AMBIENT_EU_EUROSTAR_TRAIN_ID=\(.[1].TRAIN_ID)
"'
