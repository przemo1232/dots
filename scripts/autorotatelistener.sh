monitor-sensor | grep --line-buffered "Accelerometer orientation changed:" | while read -r line; do
    if [[ "$line" == "Accelerometer orientation changed: normal" ]]; then
        echo "Detected orientation: normal"
        # Replace this with your desired command for 'normal'
        hyprctl keyword monitor eDP-1,1920x1080,auto,1,transform,0
    else
        echo "Detected orientation: not normal"
        # Replace this with your desired command for other orientations
        hyprctl keyword monitor eDP-1,1920x1080,auto,1,transform,2
    fi
done
