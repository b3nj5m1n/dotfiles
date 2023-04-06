#!/usr/bin/env sh

set -e

INPUT="$1"

if grep -q "$INPUT" /drivemecrazy/transcoded.log; then
  echo "$INPUT seems to have already been transcoded"
  exit 1
fi

# ffmpeg -threads 10 -init_hw_device vaapi=foo:/dev/dri/renderD128 -hwaccel vaapi -hwaccel_output_format vaapi -hwaccel_device foo -i "$INPUT" -filter_hw_device foo -c:v hevc_vaapi -vf 'format=nv12,scale=640:-2,hwupload' -qp 28 -f mp4 "$INPUT.transcode"
ffmpeg -threads 10 -init_hw_device vaapi=foo:/dev/dri/renderD128 -hwaccel vaapi -hwaccel_output_format vaapi -hwaccel_device foo -i "$INPUT" -filter_hw_device foo -c:v hevc_vaapi -vf 'hwupload' -qp 24 -f mp4 "$INPUT.transcode"
printf "%s\n%s" "$(du -h "$INPUT")" "$(du -h "$INPUT.transcode")"
if [ "$(du -bs "$INPUT" | cut -f1)" -gt "$(du -bs "$INPUT.transcode" | cut -f1)" ]; then
  mv "$INPUT.transcode" "$INPUT"
  printf "%s\nSUCCESS\n" "$INPUT" >> /drivemecrazy/transcoded.log
else
  printf "%s\nFUCK\n" "$INPUT" >> /drivemecrazy/transcoded.log
fi

