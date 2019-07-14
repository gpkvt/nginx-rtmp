# Docker-Image for nginx with RTMP-Module based on Debian Stretch. 

The intended use is to have as an RTMP ressource for Tools like (https://streamlabs.com/streamlabs-obs)[Streamlabs OBS] or directly stream to (https://www.twitch.tv)[Twitch] in conjunction with IPTV encoding devices (e.g. (https://gosolo.tv/)[Live U Solo]).

## RTMP Endpoints

There are three RTMP-Endpoints configured (`local.conf`):

  * recode (Port `1735`)
    Recode the input (as `1080p60, veryfast, 6 MBit`) and send it directly to Twitch

  * direct2twitch (Port `1835`)
    Send the input directly to Twitch without any encoding

  * live (Port `1935`)
    Become an Standard-RTMP source for use with OBS, VLC, etc.

## Webserver / PHP-FPM

nginx is configured to serve file via http (Port 80). php-fpm is also available (PHP 7.0), to add content use the Volume `/var/www/`.

## Build

To build the image, check out this repo and run:

  ```docker build . -t 21x9/nginx-rtmp```

Instead of build the image on your own you can also download the Images directly from hub.docker.com.

## Start

To start the container run:

  ```docker run --rm -v /local/path:/var/www/ -p 80:80 -p 1935:1935 -p 1835:1835 -p 1735:1735 21x9/nginx-rtmp```

Please note, if you don't need the webserver you can omit the `-v` Parameter (including the Path) and `-p 80:80`. If you don't need certain RTMP endpoints you can omit the corresponding `-p` Parameters.

If you want to stream directly to Twitch (using the `recode` and/or `direct2twitch` Endpoints) you need to add your Twitch Steamkey using the `--env` Parameter (e.g. `--env TWITCH_STREAMKEY=$MYSECRETTWITCHSTREAMKEY`).