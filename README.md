

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

![Config Preview](https://media.discordapp.net/attachments/956985723800678440/1431620580632957029/code-snapshot.png?ex=68fe1410&is=68fcc290&hm=19e0dee450665e296dfe0d9a37d2b67a3da47d9b0b12b09cc759425fd7755c7d&=&format=webp&quality=lossless&width=950&height=1511)

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
