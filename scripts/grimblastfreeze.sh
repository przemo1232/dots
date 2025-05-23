hyprpicker -r -v &
hyprpicker_pid=$!

grimblast copy area $@

kill "$hyprpicker_pid"
