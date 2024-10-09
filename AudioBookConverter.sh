#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 -i <input_dir> -o <output_dir> [-t <title>] [-a <artist>] [-l <album>] [-y <year>] [-g <genre>] [-c <composer>] [-b <album_artist>] [-m <comment>] [-r <track>] [-d <disc>] [-p <copyright>] [-e <encoded_by>] [-D <date>] [-A <album_art>] [-h]"
    echo "  -i <input_dir>   Directory containing MP3 files"
    echo "  -o <output_dir>  Directory to save the output M4B file"
    echo "  -t <title>       Title metadata (optional)"
    echo "  -a <artist>      Artist metadata (optional)"
    echo "  -l <album>       Album metadata (optional)"
    echo "  -y <year>        Year metadata (optional)"
    echo "  -g <genre>       Genre metadata (optional)"
    echo "  -c <composer>    Composer metadata (optional)"
    echo "  -b <album_artist> Album Artist metadata (optional)"
    echo "  -m <comment>     Comment metadata (optional)"
    echo "  -r <track>       Track metadata (optional)"
    echo "  -d <disc>        Disc metadata (optional)"
    echo "  -p <copyright>   Copyright metadata (optional)"
    echo "  -e <encoded_by>  Encoded by metadata (optional)"
    echo "  -D <date>        Date metadata (optional)"
    echo "  -A <album_art>   Album Art metadata (optional)"
    echo "  -h               Display this help message"
    exit 1
}

# Parse command line arguments
while getopts "i:o:t:a:l:y:g:c:b:m:r:d:p:e:D:A:h" opt; do
    case ${opt} in
        i) input_dir="$OPTARG" ;;
        o) output_dir="$OPTARG" ;;
        t) metadata_title="$OPTARG" ;;
        a) metadata_artist="$OPTARG" ;;
        l) metadata_album="$OPTARG" ;;
        y) metadata_year="$OPTARG" ;;
        g) metadata_genre="$OPTARG" ;;
        c) metadata_composer="$OPTARG" ;;
        b) metadata_album_artist="$OPTARG" ;;
        m) metadata_comment="$OPTARG" ;;
        r) metadata_track="$OPTARG" ;;
        d) metadata_disc="$OPTARG" ;;
        p) metadata_copyright="$OPTARG" ;;
        e) metadata_encoded_by="$OPTARG" ;;
        D) metadata_date="$OPTARG" ;;
        A) metadata_album_art="$OPTARG" ;;
        h) usage ;;
        *) usage ;;
    esac
done

# Check required arguments
if [ -z "$input_dir" ] || [ -z "$output_dir" ]; then
    usage
fi

# Create output directory if it doesn't exist
mkdir -p "$output_dir"

# Create a temporary file for the concatenated list
concat_list="concat_list.txt"
> $concat_list

# Loop through each MP3 file and add it to the concatenation list
for file in "$input_dir"/*.mp3; do
    echo "file '$file'" >> $concat_list
done

# Get the bitrate of the first MP3 file
bitrate=$(ffprobe -v error -select_streams a:0 -show_entries stream=bit_rate -of default=noprint_wrappers=1:nokey=1 "$input_dir"/*.mp3 | head -n 1)

# Extract essential metadata from the first MP3 file if not provided
if [ -z "$metadata_title" ]; then
    metadata_title=$(ffprobe -v error -show_entries format_tags=title -of default=noprint_wrappers=1:nokey=1 "$input_dir"/*.mp3 | head -n 1)
    metadata_title=${metadata_title:-"Unknown Title"}
fi

if [ -z "$metadata_artist" ]; then
    metadata_artist=$(ffprobe -v error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 "$input_dir"/*.mp3 | head -n 1)
    metadata_artist=${metadata_artist:-"Unknown Artist"}
fi

if [ -z "$metadata_album" ]; then
    metadata_album=$(ffprobe -v error -show_entries format_tags=album -of default=noprint_wrappers=1:nokey=1 "$input_dir"/*.mp3 | head -n 1)
    metadata_album=${metadata_album:-"Unknown Album"}
fi

if [ -z "$metadata_year" ]; then
    metadata_year=$(ffprobe -v error -show_entries format_tags=date -of default=noprint_wrappers=1:nokey=1 "$input_dir"/*.mp3 | head -n 1)
    metadata_year=${metadata_year:-"Unknown Year"}
fi

if [ -z "$metadata_genre" ]; then
    metadata_genre=$(ffprobe -v error -show_entries format_tags=genre -of default=noprint_wrappers=1:nokey=1 "$input_dir"/*.mp3 | head -n 1)
    metadata_genre=${metadata_genre:-"Unknown Genre"}
fi

# Prepare metadata options
metadata_opts=(
    -metadata title="$metadata_title"
    -metadata artist="$metadata_artist"
    -metadata album="$metadata_album"
    -metadata date="$metadata_year"
    -metadata genre="$metadata_genre"
)

# Add non-essential metadata if provided
[ -n "$metadata_composer" ] && metadata_opts+=(-metadata composer="$metadata_composer")
[ -n "$metadata_album_artist" ] && metadata_opts+=(-metadata album_artist="$metadata_album_artist")
[ -n "$metadata_comment" ] && metadata_opts+=(-metadata comment="$metadata_comment")
[ -n "$metadata_track" ] && metadata_opts+=(-metadata track="$metadata_track")
[ -n "$metadata_disc" ] && metadata_opts+=(-metadata disc="$metadata_disc")
[ -n "$metadata_copyright" ] && metadata_opts+=(-metadata copyright="$metadata_copyright")
[ -n "$metadata_encoded_by" ] && metadata_opts+=(-metadata encoded_by="$metadata_encoded_by")
[ -n "$metadata_date" ] && metadata_opts+=(-metadata date="$metadata_date")

# Concatenate MP3 files into a single M4B file with chapter markers
ffmpeg -f concat -safe 0 -i $concat_list -c:a aac -b:a ${bitrate} \
    "${metadata_opts[@]}" \
    -f mp4 -start_time 0 -c:v copy "$output_dir/output.m4b"

# Add album art if provided
if [ -n "$metadata_album_art" ]; then
    ffmpeg -i "$output_dir/output.m4b" -i "$metadata_album_art" -map 0 -map 1 -c copy -disposition:v attached_pic "$output_dir/output_with_art.m4b"
    mv "$output_dir/output_with_art.m4b" "$output_dir/output.m4b"
fi

# Clean up temporary file
rm $concat_list

echo "M4B file created successfully: $output_dir/output.m4b"
