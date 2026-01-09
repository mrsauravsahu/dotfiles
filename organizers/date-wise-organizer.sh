#!/bin/bash

# for i in `find . -maxdepth 1 -type f`; do
#   dir="$(echo "${i}" | grep -E '^\./DJI_[0-9]{8}' -o |  grep -oE '[0-9]{8}$')"
#
#   if [ -d "${dir}" ]; then
#     mv "${i}" "${dir}" ;
#   else 
#     mkdir "${dir}";
#   fi
# done
# ```bash

organize_files() {
  local dir="$1"
  shift
  for file in `find "${IPHONE_DIR}" -maxdepth 1 -type f`; do
    echo checking file "${file}"
    # Extract creation date from file using exiftool (for images) or stat (for other files)
    if [[ $file =~ \.(jpg|jpeg|png|gif|heic|heif)$ ]]; then
      created_date=$(exiftool -s3 -DateTimeOriginal "$file")
    else
      created_date=$(stat -c "%Y" "$file")
    fi

    # Create directory for the date if it doesn't exist
    dir_name="${created_date:0:4}/${created_date:5:2}/${created_date:8:2}"
    mkdir -p "${dir_name}"

    # Move file to its corresponding directory
    mv "$file" "${dir_name}/"

  done
}

