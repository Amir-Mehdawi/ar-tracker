Config = {}

Config.ItemName = "tracker" -- Tracker Item Name
Config.TrackerDeviceName = "Phone Tracker"  -- Input Titel
Config.TrackingDuration = 60000 -- Tracking Time
Config.UpdateInterval = 600  -- How often does the circle Update 
Config.CooldownTime = 180000  -- CoolDown Before Another Track
Config.CanTrackSelf = true  -- If But It true you can track you self

Config.MiniGame = {  --Minigame Settings
    Letters = 16, 
    Time = 10000
}

Config.CircleSettings = {  
    Radius = 150.0
}

Config.Messages = {
    PlayerNotFound = "not found",
    TrackingStarted = "Tracking initiated...",
    TrackingSuccess = "Tracking successful! Check your GPS",
    TrackingFailed = "Tracking failed",
    BeingTracked = "Someone is trying to track your location!",
    TrackingEnded = "Tracking ended",
    InvalidPhone = "Invalid phone number",
    CannotTrackSelf = "You cannot track yourself",
    OnCooldown = "Tracker on cooldown.",
    TargetNoPhone = "not found",
     NoPhoneEquipped = "You need to equip your phone first"
}