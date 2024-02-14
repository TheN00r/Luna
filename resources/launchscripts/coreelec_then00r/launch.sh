#!/usr/bin/sh
curl -H "Content-type: application/json" -d '{"jsonrpc":"2.0","method":"Settings.SetSettingValue","params":{"setting":"audiooutput.audiodevice","value":"ALSA:hdmi:CARD=AMLAUGESOUND,DEV=0"},"id":1}' http://localhost:8080/jsonrpc
sleep 1
killall -STOP librespot
killall -STOP kodi.bin
echo "rm default" > /sys/class/vfm/map
echo "add default vdec.h265.00 amlvideo ppmgr deinterlace amvideo" > /sys/class/vfm/map
#mv logfile logfile.old
#moonlight stream -app "$@" >> logfile 2>&1
moonlight stream -app "$@" >/dev/null 2>&1
echo "rm default" > /sys/class/vfm/map
echo "add default decoder amvideo" > /sys/class/vfm/map
killall -CONT kodi.bin
killall -CONT librespot
curl -H "Content-type: application/json" -d '{"jsonrpc":"2.0","method":"Settings.SetSettingValue","params":{"setting":"audiooutput.audiodevice","value":"ALSA:surround71:CARD=AMLAUGESOUND,DEV=0"},"id":1}' http://localhost:8080/jsonrpc
