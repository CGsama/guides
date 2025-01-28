SET OWNCAST_URL="rtmp://live.rd540.local:1935/live/live_"
SET TWITCH_URL="rtmp://live.twitch.tv/app/live_"
SET BILIBILI_URL="rtmp://bdy.live-push.bilivideo.com/live-bvc/?streamname=live_"

SET CMD=ffmpeg -listen 1 -i rtmp://0.0.0.0:1935
SET CMD=%CMD% -c copy -f flv %OWNCAST_URL%
SET CMD=%CMD% -c:v libx264 -vf scale=1280:720 -preset veryfast -x264-params "nal-hrd=cbr" -b:v 2500k -minrate 2500k -maxrate 2500k -bufsize 6000k -r 30 -pix_fmt yuv420p -g 60 -c:a aac -b:a 160k -ac 2 -ar 44100 -f flv %BILIBILI_URL%
SET CMD=%CMD% -c:v libx264 -preset veryfast -x264-params "nal-hrd=cbr" -b:v 2500k -minrate 2500k -maxrate 2500k -bufsize 6000k -r 30 -pix_fmt yuv420p -g 60 -c:a aac -b:a 160k -ac 2 -ar 44100 -f flv %TWITCH_URL%
%CMD%
pause
