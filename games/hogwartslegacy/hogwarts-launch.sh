#!/usr/bin/env bash
set -euo pipefail

############################
# USER TOGGLES
############################

# Enable gamescope wrapper (true / false)
USE_GAMESCOPE=false

# Gamescope settings (used only if USE_GAMESCOPE=true)
GAMESCOPE_ARGS=(
  -W 1920
  -H 1080
  -f
  -r 60
)

############################
# ENVIRONMENT VARIABLES
############################

export HEROIC_APP_NAME="fa4240e57a3c46b39f169041b7811293"
export HEROIC_APP_RUNNER="legendary"
export HEROIC_APP_SOURCE="epic"
export GAMEID="umu-990080"
export STORE="egs"

export STEAM_COMPAT_INSTALL_PATH="/home/tychart/Games/Heroic/HogwartsLegacy"
export STEAM_COMPAT_CLIENT_INSTALL_PATH="/home/tychart/.steam/steam"
export STEAM_COMPAT_DATA_PATH="/home/tychart/Games/Heroic/Prefixes/default/Hogwarts Legacy"

export WINEPREFIX="/home/tychart/Games/Heroic/Prefixes/default/Hogwarts Legacy"
export PROTONPATH="/home/tychart/.local/share/Steam/compatibilitytools.d/GE-Proton10-28"

export PROTON_ENABLE_NVAPI=1
export DXVK_NVAPI_ALLOW_OTHER_DRIVERS=1
export WINE_FULLSCREEN_FSR=0

export PROTON_EAC_RUNTIME="/home/tychart/.config/heroic/tools/runtimes/eac_runtime"
export PROTON_BATTLEYE_RUNTIME="/home/tychart/.config/heroic/tools/runtimes/battleye_runtime"

export STEAM_COMPAT_APP_ID=0
export SteamAppId=0
export SteamGameId="heroic-HogwartsLegacy"

export PROTON_LOG_DIR="/home/tychart"
export WINEDEBUG="+fixme"
export DXVK_LOG_LEVEL="info"
export VKD3D_DEBUG="fixme"

export LEGENDARY_CONFIG_PATH="/home/tychart/.config/heroic/legendaryConfig/legendary"

# Explicit NVIDIA selection (recommended)
export __NV_PRIME_RENDER_OFFLOAD=1
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export VK_ICD_FILENAMES="/usr/share/vulkan/icd.d/nvidia_icd.json"

############################
# BASE LAUNCH COMMAND
############################

LEGENDARY_CMD=(
  /opt/Heroic/resources/app.asar.unpacked/build/bin/x64/linux/legendary
  launch
  fa4240e57a3c46b39f169041b7811293
  --no-wine
  --wrapper "/home/tychart/.config/heroic/tools/runtimes/umu/umu_run.py"
  --language en
)

############################
# FINAL EXECUTION
############################

echo "Launching Hogwarts Legacy"
echo "Gamescope enabled: ${USE_GAMESCOPE}"
echo

if [[ "${USE_GAMESCOPE}" == "true" ]]; then
  exec gamescope "${GAMESCOPE_ARGS[@]}" -- "${LEGENDARY_CMD[@]}"
else
  exec "${LEGENDARY_CMD[@]}"
fi
