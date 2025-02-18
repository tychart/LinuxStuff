How to use:

Beets is running on a docker container on Truenas through Dockge.
Need to access it by sshing into truenas at `ssh tychart@192.168.10.31`
Then you can run `sudo docker exec -it beets bash` to enter the terminal on the beets container

Double check that the beet config file is correct:
  Located at `/mnt/pool/StorageNAS/Media/Audio/Music/Beets/config/config.yaml`
  Match it up with the config.yml file in this repo
  Can run `beet config` and look at the output to extra make sure that everything is correct and you are looking at the right config file

From there, use `beet [command]` like normal
  The `/music` folder leads to the `/mnt/pool/StorageNAS/Media/Audio/Music` folder
  The `/downloads` folder leads to the `/mnt/pool/StorageNAS/Media/Audio/Music/IngestFolder` folder

Easy way to re-import whole library is `beet import /music/Library/`
Easy way to import new album `beet
