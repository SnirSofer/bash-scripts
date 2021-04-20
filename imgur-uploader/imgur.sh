#!/bin/bash
imgur_api='191fd32cfe60b39'
filename=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '');
gnome-screenshot -a -f /tmp/"$filename".jpg
# encoded=$(base64 -w 0 /tmp/"$filename".jpg);
upload=$(curl -X POST -F 'image=@/tmp/'"$filename"'.jpg' -H 'Authorization: Client-ID '"$imgur_api" https://api.imgur.com/3/image.json | jq -r '.data.link');
rm /tmp/"$filename".jpg
echo -n "$upload" | xclip -selection clipboard
notify-send "The image uploaded successfuly!"
