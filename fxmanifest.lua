fx_version 'adamant'
game 'gta5'
author 'malizniak'
lua54 "yes"

shared_script "config.lua"
client_script "client.lua"

escrow_ignore {
    "client.lua",
    "config.lua",
    "readme.md",
}

dependency '/assetpacks'
