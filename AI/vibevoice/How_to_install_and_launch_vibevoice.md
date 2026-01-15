# How to install and launch Microsoft VibeVoice

```bash
sudo docker run --privileged --net=host --ipc=host --ulimit memlock=-1:-1 --ulimit stack=-1:-1 -p 7860:7860 --gpus all --rm -it nvcr.io/nvidia/pytorch:24.07-py3

pip install flash-attn --no-build-isolation

git clone https://github.com/vibevoice-community/VibeVoice.git

cd VibeVoice

apt update && apt install ffmpeg -y

vim demo/gradio_demo.py

python demo/gradio_demo.py --model_path microsoft/VibeVoice-1.5b
```

Once the container is up and running, commit the created container to an image, then that can be used and restarted at will

```bash
docker commit \
  --change='EXPOSE 7860' \
  --change='CMD ["bash","-lc","cd /opt/VibeVoice && python demo/gradio_demo.py --model_path microsoft/VibeVoice-1.5b"]' \
  "$CONTAINER_NAME" \
  vibevoice:latest


docker run -d \
  --name vibevoice \
  --restart unless-stopped \
  --gpus all \
  --privileged \
  --ipc=host \
  --ulimit memlock=-1:-1 \
  --ulimit stack=-1:-1 \
  -p 7860:7860 \
  -v ~/.vibevoice-data:/data \
  vibevoice:latest
```
