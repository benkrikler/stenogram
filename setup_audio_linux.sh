#! /bin/bash
ScriptDir="$(readlink -f "$(dirname "${BASH_SOURCE[0]}")")"

mod_dupl=$(pactl load-module module-null-sink sink_name=duplex_out sink_properties=device.description="Duplex_Output")
mod_web_conf=$(pactl load-module module-null-sink sink_name=web_conf_out sink_properties=device.description="Web_Conf_output")
mod_loop_conf=$(pactl load-module module-loopback source=web_conf_out.monitor)
mod_loop_rec=$(pactl load-module module-loopback source=web_conf_out.monitor sink=duplex_out)
mod_loop_out=$(pactl load-module module-loopback sink=duplex_out)

StoreIndexFile="$ScriptDir/reset_audio_modules.sh"

cat > "$StoreIndexFile" <<EOF
#! /bin/bash
pactl unload-module $mod_dupl
pactl unload-module $mod_web_conf
pactl unload-module $mod_loop_conf
pactl unload-module $mod_loop_rec
pactl unload-module $mod_loop_out
EOF

cat <<EOF
Set up sound system for recording.  To undo, run:
  bash $StoreIndexFile
EOF
