if set -q AMBIENT_DE_ICE_STOP_NEXT
    echo "🚏 $AMBIENT_DE_ICE_STOP_NEXT"
end
if set -q AMBIENT_DE_ICE_STOP_NEXT_ARRIVE_SCHEDULED
    echo "⌚" (date -d "$AMBIENT_DE_ICE_STOP_NEXT_ARRIVE_SCHEDULED" +%H:%M)
end
if [ -n "$AMBIENT_DE_ICE_STOP_NEXT_ARRIVE_DELAY" ]
	echo "⏱ $AMBIENT_DE_ICE_STOP_NEXT_ARRIVE_DELAY"
end
if set -q AMBIENT_DE_ICE_TRAIN_TYPE
	echo -n "🚄 $AMBIENT_DE_ICE_TRAIN_TYPE"
	# If iceportal.de is having a moment, we may not have the train number.
	set -q AMBIENT_DE_ICE_VZN; and echo -n " $AMBIENT_DE_ICE_VZN"
	echo
end
if set -q AMBIENT_DE_ICE_SPEED
	echo "💨 $AMBIENT_DE_ICE_SPEED km/h"
end
switch "$AMBIENT_DE_ICE_CONNECTIVITY_STATE"
    case 'HIGH'
        echo "📶 🛜"
    case 'WEAK'
        echo "📶️ ♒"
    case 'UNSTABLE'
        echo "📶 〰️"
end
