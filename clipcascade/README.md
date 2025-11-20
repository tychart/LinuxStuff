# ClipCascade Instalation

1. Follow the instructions on the [github README](https://github.com/Sathvik-Rao/ClipCascade)
	1. Unzip the folder into `programs` folder
	2. Run `sudo apt update` and `sudo apt install -y python3 python3-pip python3-gi xclip wl-clipboard dunst`
	3. Make and enter a new virtual enviornment `python3 -m venv venv` then `source venv/bin/activate`
	4. Pip install the requirements file `pip install -r requirements.txt`
	5. Test start it up `python3 main.py`
2. Copy clipcascade.service into the folder
3. Make a simlink from that file to the user's systemd folder `ln -s /home/tychart/programs/ClipCascade/clipcascade.service /home/tychart/.config/systemd/user/` 
	1. You can confirm that this worked properly by looking at the contents of that folder `ll ~/.config/systemd/user/`
4. Reload systemd for the user to pick up the new config file `systemctl --user daemon-reload`
5. Start the service: `systemctl --user start clipcascade`
6. Check the status of the service: `systemctl --user status clipcascade`
	1. If anything went wrong, check it out here: `journalctl --user -r -u clipcascade`
7. Once it is working, enable the service: `systemctl --user enable clipcascade`
8. Try rebooting

