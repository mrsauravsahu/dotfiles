#!/usr/bin/env bash

set -e

INPUT_DIR="$1"
OUTPUT_DIR="$2"

if [ -z "$INPUT_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
  echo "Usage: mrss_make_proxies <input_dir> <output_dir>"
  exit 1
fi

mkdir -p "$OUTPUT_DIR"

# --- CONFIGURATION ---
TARGET_WIDTH=3840
TARGET_HEIGHT=2160

# Choose output codec:
#   proxy)   Fastest decode (recommended)
#   prores)  ProRes Proxy (larger, but extremely smooth)
CODEC="proxy"
# CODEC="prores"

# --- FUNCTIONS ---
convert_proxy_h264() {
  input="$1"
  output="$2"

  ffmpeg -i "$input" \
    -vf "scale=$TARGET_WIDTH:$TARGET_HEIGHT:flags=lanczos" \
    -c:v libx264 -preset veryfast -crf 30 -pix_fmt yuv420p \
    -x264opts keyint=1 \
    -c:a aac -b:a 128k \
    "$output"
}

convert_proxy_prores() {
  input="$1"
  output="$2"

  ffmpeg -i "$input" \
    -vf "scale=$TARGET_WIDTH:$TARGET_HEIGHT:flags=lanczos" \
    -c:v prores_ks -profile:v 0 \
    -c:a pcm_s16le \
    "$output"
}

# --- MAIN LOOP ---
find "$INPUT_DIR" -type f \( -iname "*.mp4" -o -iname "*.lrf" -o -iname "*.webm" \) | while read -r file; do
  base="$(basename "$file")"
  name="${base%.*}"
  out="$OUTPUT_DIR/${name}_editproxy.mp4"

  echo "Processing: $file"
  
  if [ "$CODEC" = "proxy" ]; then
    convert_proxy_h264 "$file" "$out"
  else
    convert_proxy_prores "$file" "$out"
  fi

  echo "Done → $out"
done

echo "All proxies created in: $OUTPUT_DIR"

