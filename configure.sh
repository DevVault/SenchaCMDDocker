#!/usr/bin/env bash

_build_images=$1
_image_name="devvault/senchacmd"
_links=$(curl -L -s https://www.sencha.com/products/extjs/cmd-download | grep -ioP "http:\/\/cdn\.sencha\.com\/cmd\/[\d.]+\/.*amd64\.sh\.zip" | sort -u)
_versions=$(echo "${_links}" | grep -ioP "\d+\.\d+\.\d+\.{0,1}\d{0,}" | sort -u)

if [[ "${_build_images}" == "1" ]]; then
	echo "WARNING! Images are begin build and sent to docker hub!"
fi

while IFS= read -r _version; do
  sed -e "s/\%SENCHA\_VERSION\%/${_version}/g" "$(pwd)/Dockerfile.template" > "$(pwd)/Dockerfile"

  git push origin ":refs/tags/${_version}"
  git tag -d "${_version}"

  git add Dockerfile
  git commit -m "Generated version ${_version}"

  git tag "${_version}"

  if [[ "${_build_images}" == "1" ]]; then
    docker build --tag="${_image_name}:${_version}" "$(pwd)"
    docker push "${_image_name}:${_version}"
  fi
done <<< "$_versions"

git push origin --tags
git push origin master

exit 0
