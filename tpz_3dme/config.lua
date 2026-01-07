Config = {}

-- The command to use for displaying the 3DText.
Config.Command = "me"
Config.CommandSuggestion = 'Display a text above your player head.'
Config.CommandActionText = "What text you want to display?"

-- The RGBA color when the text is displayed.
Config.Color = { r = 255, g = 215, b = 0, a = 200 } -- Text color

-- How long should the displayed text last in milliseconds.
Config.Duration = 5000

-- The maximum distance to display to nearby players.
Config.DisplayDistance = 20.0

-- (!) Checkout tpz_core/server/discord/webhooks.lua to modify the webhook urls.
Config.Webhooks = {
    
    ['ALL'] = {
        Enabled = false, 
        Color = 10038562,
    },

}