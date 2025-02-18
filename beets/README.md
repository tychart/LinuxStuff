# Beets Usage Guide

## Accessing Beets
Beets is running inside a Docker container on TrueNAS, managed via Dockge. To access it:

1. **SSH into TrueNAS:**
   ```sh
   ssh tychart@192.168.10.31
   ```
2. **Enter the Beets container terminal:**
   ```sh
   sudo docker exec -it beets bash
   ```

---

## Configuring Beets
### Verify Configuration File
Ensure that the Beets configuration file is correct before using it:

- Config file location on TrueNAS:
  ```
  /mnt/pool/StorageNAS/Media/Audio/Music/Beets/config/config.yaml
  ```
- Compare it with `config.yml` in this repository.
- You can also run the following command inside the container to check the active configuration:
  ```sh
  beet config
  ```
  This outputs the current config settings, helping you verify that the correct file is being used.

---

## Using Beets
Once inside the Beets container, use it as you normally would with the `beet` command:

- **Folder Mappings:**
  - `/music` → `/mnt/pool/StorageNAS/Media/Audio/Music`
  - `/downloads` → `/mnt/pool/StorageNAS/Media/Audio/Music/IngestFolder`

### Importing Music
- **Re-import entire library:**
  ```sh
  beet import /music/Library/
  ```
- **Import a new album:**
  ```sh
  beet import /downloads/<album-folder>
  ```

---

This guide ensures a clear and structured approach to managing your Beets setup on TrueNAS. 🎵

