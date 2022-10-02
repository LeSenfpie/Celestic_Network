local Translations = {
    error = {

    },
    success = {

    },
    info {

    },
    mail = {

    },

    menu = {
        back = 'Zurück', --- ENG : back 
        leave = 'Verlassen', --- ENG : leave 
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})