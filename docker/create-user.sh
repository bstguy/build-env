#!/bin/bash -e

[ -n "${IMAGE_USER}" ] || IMAGE_USER="root"
[ -n "${IMAGE_PWD}" ] || IMAGE_PWD="${IMAGE_USER}"
[ -n "${IMAGE_GROUP}" ] || IMAGE_GROUP="${IMAGE_USER}"
[ -n "${IMAGE_HOME}" ] || IMAGE_HOME="/home/${IMAGE_USER}"
[ -n "${IMAGE_SHELL}" ] || IMAGE_SHELL="/bin/bash"

add_args=()

[ -z "${IMAGE_GID}" ] || args+=(--gid "${IMAGE_GID}")
if [ -n "${IMAGE_GROUP}" ] && [ "${IMAGE_GROUP}" != 'root' ]; then
  groupadd "${add_args[@]}" "${IMAGE_GROUP}"
fi

[ -z "${IMAGE_UID}" ] || add_args+=(--uid "${IMAGE_UID}")
if [ -n "${IMAGE_USER}" ] && [ "${IMAGE_USER}" != 'root' ]; then
  useradd --create-home\
    "${add_args[@]}" \
    --groups "sudo" \
    "${IMAGE_USER}"
fi

cat <<EOF >> "${IMAGE_HOME}/.bashrc"
[ ! -e "${IMAGE_ENV_DIR}/import-profile" ] || source "${IMAGE_ENV_DIR}/import-profile" "${IMAGE_ETC_DIR}/profile.d"
EOF

cat <<EOF >> "${IMAGE_HOME}/profile"
[ ! -e "${IMAGE_ENV_DIR}/import-profile" ] || source "${IMAGE_ENV_DIR}/import-profile" "${IMAGE_ETC_DIR}/profile.d"
EOF
