#!/bin/bash
# change the api key with your api key to prevent upload limits (https://api.imgur.com/oauth2/addclient)
imgur_api='191fd32cfe60b39'
if [ -z "$1" ]; then
  filename=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13 ; echo '');
  gnome-screenshot -a -f /tmp/"$filename".jpg
  # encoded=$(base64 -w 0 /tmp/"$filename".jpg);
  upload=$(curl -X POST -F 'image=@/tmp/'"$filename"'.jpg' -H 'Authorization: Client-ID '"$imgur_api" https://api.imgur.com/3/image.json | jq -r '.data.link');
  rm /tmp/"$filename".jpg
  echo -n "$upload" | xclip -selection clipboard
  notify-send "The image uploaded successfuly!"
else
  upload=$(curl -X POST -F 'image=@'"$1" -H 'Authorization: Client-ID '"$imgur_api" https://api.imgur.com/3/image.json | jq -r '.data.link');
  echo -n "$upload" | xclip -selection clipboard
  notify-send "The image uploaded successfuly!"
fi
