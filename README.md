## Leave A Star
---
## 🌟 Features
- ⚙️ Fully customizable system via `config.lua`
- 🔄 Synced behavior between all players
- 💨 Lightweight & performance-friendly
- 🌐 Works with **QB-Core, lb-phone**

---


## 📦 Installation & Setup
1. Download or clone this repository.  
2. Place the folder in your `resources` directory and rename it to `ar-tracker`.  
3. Add the following lines to your **server.cfg**:
    ```bash
    ensure ox_lib
    ensure lb-phone
    ensure ar-tracker
    ```
4. Adjust the settings in your `config.lua` file.  
 
 ---

## 💻 Requirements
- ⚙️ 
[ox_lib](https://github.com/overextended/ox_lib)  [Free]
[lb-phone](https://lbscripts.com)  [Paid]
[minigames](https://cdn.discordapp.com/attachments/956985723800678440/1431621576360460319/minigames.zip?ex=68fe14fe&is=68fcc37e&hm=156fcd578dacd0ed61f0e565269272a65e791a7d6a14cde2f37a613af8fef094&) [Free]
> 🧩 **Mandatory:** Requires **ox_lib , lb-phone , minigames** .

---


## ⚙️ Configuration Example (`config.lua`)

![Config Preview](https://cdn.discordapp.com/attachments/956985723800678440/1431625619417858190/code-snapshot.png?ex=68fe18c1&is=68fcc741&hm=b1f14b381d901decd18c509de291e41922e6abe828cbe8df3cd42c7e64968c16&)

---


 ```lua
5 . Put This in qb-core/shared/items.lua

['tracker'] = {
    ['name'] = 'tracker',
    ['label'] = 'Phone Tracker',
    ['weight'] = 500,
    ['type'] = 'item',
    ['image'] = 'tracker.png',
    ['unique'] = false,
    ['useable'] = true,
    ['shouldClose'] = true,
    ['combinable'] = nil,
    ['description'] = 'A device used to track phone'
},
```
---

## 📝 License

This project is released under the [MIT License](https://opensource.org/licenses/MIT).


---


