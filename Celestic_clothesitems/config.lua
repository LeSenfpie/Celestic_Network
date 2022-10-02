
--- Die Config ist Ganz einfach erstellt.... ----
---- Config For Celestic_clothesitems ----
Config = Config or {}

--- Animation ----



----- end -----




----Props ----- 

--- Dont need Props ---



---- Welche Slots du benutzen kannst in der hotbar / ENG : wich slots are your hot bar  ----

Config.Hotbar = {
    1, 2, 3, 4, 5, 41
}


------ Duration / Öffnungs oder schließzeit -----

Config.duration = {
    open = 1, --- Sekunden / sec 
    close = 1
}


---- Wichtig !!!! --- Items 

Config.items {

    ['tshirt1'] = {
        slots = 7,
        size = 100000,
        male = {
             ["torso2"] = { item = 1, texture = 0 }
        },

        female = {
             ["torso2"] = { item = 0, texture = 0 },
             ["arms"] = { item = 0, texture = 0}
        }


   },
}



---- Blacklisted Items / weapons ----

Config.Blacklist_items = {
    active = true, 
    list = {
        'weapon_rpg'
    }
}

----- Welche JOBS reinschauen dürfen -----

Config.whitelist = {
    lockpick = {
        active = true, 
        jobs = { 'police' },
        citizenid = {}
    }
}