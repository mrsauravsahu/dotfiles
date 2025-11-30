for i in `find . -maxdepth 1 -type f`; do
  dir="$(echo "${i}" | grep -E '^\./DJI_[0-9]{8}' -o |  grep -oE '[0-9]{8}$')"

  if [ -d "${dir}" ]; then
    mv "${i}" "${dir}" ;
  else 
    mkdir "${dir}";
  fi
done

