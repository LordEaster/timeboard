
# 🕒 TimeBoard

**TimeBoard** is a beautiful, terminal-based dashboard written entirely in shell script. It shows your current time, weather, events, and even a motivational quote — all right inside your terminal.

> ✨ Be Simple but Outstanding – by [@LordEaster](https://github.com/LordEaster) | BSO Space


```
  _____ _                ____                      _ 
 |_   _(_)_ __ ___   ___| __ )  ___   __ _ _ __ __| |
   | | | | '_ ` _ \ / _ \  _ \ / _ \ / _` | '__/ _` |
   | | | | | | | | |  __/ |_) | (_) | (_| | | | (_| |
   |_| |_|_| |_| |_|\___|____/ \___/ \__,_|_|  \__,_|
                                                                             
```

---

## 🚀 Features

- 🕒 Live **clock** with `figlet` display  
- 🌦 Real-time **weather** with condition, temperature, humidity  
- 📅 Upcoming Event (Coming soon)  
- 💬 Inspirational **random quotes** (Coming soon)
- 🖥️ Fully terminal-based & portable
- 🎨 Clean layout with interactive navigation

---

## 🧱 Project Structure

```
timeboard/
├── bin/
│   └── timeboard
├── modules/
│   ├── clock.sh
│   ├── dashboard.sh
│   ├── events.sh
│   ├── weather.sh
│   ├── help.sh
│   └── utils.sh
├── data/
│   └── events.json
├── setup/
│   └── boot.sh
├── Makefile
└── README.md
```

---

## ⚙️ Requirements

- `bash`, `curl`, `jq`, `figlet`, `tput`

---

## 🛠️ Setup Instructions

```bash
# Clone the project
git clone https://github.com/LordEaster/timeboard.git
cd timeboard
```

```bash
# Make all scripts executable
chmod +x bin/timeboard modules/*.sh fetch_gcal_events.sh

# Run the dashboard
./bin/timeboard
```

Or use:
```bash
make install
make run
```

---

## 🖥️ Keyboard Shortcuts

| Key | Feature        |
|-----|----------------|
| `c` | Clock          |
| `w` | Weather        |
| `e` | Events         |
| `h` | Help/About     |
| `i` | Back to Dashboard |

---

## 📅 `data/events.json` format

```json
[
  { "date": "2025-04-01", "title": "Project Deadline" },
  { "date": "2026-01-05", "title": "Yamroll's Birthday" }
]
```

---

## ✨ Credits

- [wttr.in](https://wttr.in) for weather  
- `figlet`, `jq`, and `bash` for CLI magic

---

## 🧑‍💻 Author

Built with ❤️ by [@LordEaster](https://github.com/LordEaster)  
🎓 BSO Space | TimeBoard Project  
"**Be Simple but Outstanding**"
