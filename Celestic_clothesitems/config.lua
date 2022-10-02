
--- Die Config ist Ganz einfach erstellt.... ----
---- Config For Celestic_clothesitems ----
Config = Config or {}

--- Animation ----
local animations = {
    tshirt1 = {
         dict = 'amb@world_human_hiker_standing@female@base',
         anim = 'base',
         bone = 'Back',
         attaching_position = {
              x = -0.15,
              y = -0.15,
              z = -0.05,
              x_rotation = -5.0,
              y_rotation = 90.0,
              z_rotation = 0.0,
         }
    },
}


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

Config.items = {

    ['tshirt1'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 0, texture = 0 },
             ["arms"] = { item = 0, texture = 0}
        }
    },
    ['tshirt2'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 1, texture = 0 },
             ["arms"] = { item = 5, texture = 0}
        }
    },
    ['tshirt3'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 2, texture = 0 },
             ["arms"] = { item = 11, texture = 0}
        }
    },
    ['tshirt4'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 5, texture = 0 },
             ["arms"] = { item = 4, texture = 0}
        }
    },
    ['tshirt5'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 6, texture = 0 },
             ["arms"] = { item = 11, texture = 0}
        }
    },
    ['tshirt6'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 8, texture = 0 },
             ["arms"] = { item = 11, texture = 0}
        }
    },
    ['tshirt7'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 9, texture = 0 },
             ["arms"] = { item = 9, texture = 0}
        }
    },
    ['tshirt8'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 10, texture = 0 },
             ["arms"] = { item = 11, texture = 0}
        }
    },
    ['tshirt9'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 14, texture = 0 },
             ["arms"] = { item = 9, texture = 0}
        }
    },
    ['tshirt10'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 17, texture = 0 },
             ["arms"] = { item = 9, texture = 0}
        }
    },
    ['tshirt11'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 18, texture = 0 },
             ["arms"] = { item = 15, texture = 0}
        }
    },
    ['tshirt12'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 19, texture = 0 },
             ["arms"] = { item = 0, texture = 0}
        }
    },
    ['tshirt13'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 20, texture = 0 },
             ["arms"] = { item = 0, texture = 0}
        }
    },
    ['tshirt14'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 22, texture = 0 },
             ["arms"] = { item = 15, texture = 0}
        }
    },
    ['tshirt15'] = {
        slots = 7,
        size = 100000,
        female = {
             ["torso2"] = { item = 0, texture = 0 },
             ["arms"] = { item = 0, texture = 0}
        }
    },


    --- Männer/Male ---

    
        ['tshirt1male'] = {
            slots = 2,
            size = 100000,
            male = {
                 ["torso2"] = { item = 0, texture = 0 },
                 ["arms"] = { item = 0, texture = 0}
            },

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
