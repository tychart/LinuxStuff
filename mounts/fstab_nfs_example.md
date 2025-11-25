```
sudo apt update
sudo apt install nfs-common
```

```
192.168.10.31:/mnt/pool/nas/media /mnt/media nfs nofail,noatime,nolock,intr,actimeo=60 0 0
192.168.10.31:/mnt/pool/nas/programs /mnt/programs nfs nofail,noatime,nolock,intr,actimeo=60 0 0
```
