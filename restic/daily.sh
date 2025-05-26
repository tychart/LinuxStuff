#!/bin/bash
set -euo pipefail

# Base directory for restic-related files (update this as needed)
BASE_DIR="/mnt/pool/StorageNAS/home/tychart/programs/restic"

# Configuration Variables
RESTIC_BINARY="${BASE_DIR}/restic_0.17.3_linux_amd64"
PASSWORD_FILE="${BASE_DIR}/passwordfile"
CACHE_DIR="${BASE_DIR}/cache"
BACKUP_SOURCE="/mnt/pool/StorageNAS/docker/immich/library"

# Rclone Backup Configuration
RCLONE_PROGRAM="${BASE_DIR}/rclone/rclone"
RCLONE_CONFIG="${BASE_DIR}/rclone/rcloneconfig"
RCLONE_CACHE="${BASE_DIR}/rclone/cache"
RCLONE_REPO="rclone:byuonedrive:/Backup/automatic/restic"
RCLONE_ARGS=(
  "--config" "$RCLONE_CONFIG"
  "--cache-dir" "$RCLONE_CACHE"
  "serve" "restic"
  "--stdio"
  "--b2-hard-delete"
)

# SFTP Backup Configuration
SFTP_REPO="sftp:tychart@192.168.10.35:/mnt/storagedrive/Backup/automatic/restic"

# Log file and lock file configuration (set these to appropriate locations)
LOG_FILE="${BASE_DIR}/backup_script.log"
LOCK_FILE="${BASE_DIR}/backup_script.lock"

# --- Logging function ---
log() {
  local msg="$1"
  echo "$(date '+%Y-%m-%d %H:%M:%S') - $msg" | tee -a "$LOG_FILE"
}

# Cleanup lock file on exit
cleanup() {
  rm -f "$LOCK_FILE"
}
trap cleanup EXIT

# Prevent overlapping runs
if [ -e "$LOCK_FILE" ]; then
  log "Backup already running. Exiting."
  exit 1
fi
touch "$LOCK_FILE"

# Change to the directory of the script (if needed)
cd "$(dirname "$0")"

# Function for Rclone Backup
backup_rclone() {
  log "Starting Rclone Backup..."
  "$RESTIC_BINARY" \
    -o "rclone.program=$RCLONE_PROGRAM" \
    -o "rclone.args=${RCLONE_ARGS[*]}" \
    -r "$RCLONE_REPO" \
    -p "$PASSWORD_FILE" \
    --cache-dir "$CACHE_DIR" \
    --verbose \
    backup "$BACKUP_SOURCE" 2>&1 | while IFS= read -r line; do log "$line"; done
  log "Rclone Backup Completed."
}

# Function for SFTP Backup
backup_sftp() {
  log "Starting SFTP Backup..."
  "$RESTIC_BINARY" \
    -p "$PASSWORD_FILE" \
    --cache-dir "$CACHE_DIR" \
    --verbose \
    -r "$SFTP_REPO" \
    backup "$BACKUP_SOURCE" 2>&1 | while IFS= read -r line; do log "$line"; done
  log "SFTP Backup Completed."
}

# --- Main Execution ---
log "Backup process started."
backup_rclone
backup_sftp
log "All backups completed successfully."
