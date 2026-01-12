#!/usr/bin/env bash
set -euo pipefail

UNIT="auto-fix-vscode-server.service"
SRC="/run/current-system/etc/systemd/user/$UNIT"
DST="$HOME/.config/systemd/user/$UNIT"

# 确保目标目录存在
mkdir -p "$(dirname "$DST")"

# 不存在才创建符号链接
if [ ! -e "$DST" ]; then
  ln -sfT "$SRC" "$DST"
fi

# 重新加载 user systemd
systemctl --user daemon-reload

# 判断是否已 enable
if systemctl --user is-enabled --quiet "$UNIT"; then
  # 已启用：重启
  systemctl --user restart "$UNIT"
else
  # 未启用：启用并启动
  systemctl --user enable --now "$UNIT"
fi

systemctl --user status auto-fix-vscode-server.service
