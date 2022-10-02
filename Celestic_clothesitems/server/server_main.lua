local QBCore = exports['qb-core']:GetCoreObject()

------------------- FUnktionen/Functions ---------------------------------------------------------------------
local function save_info(Player, item, ID)
    if Player.PlayerData.items[item.slot] then
        if not (type(Player.PlayerData.items[item.slot].info) == "table") then 
            Player.PlayerData.items[item.slot].info = {}
            Player.PlayerData.items[item.slot].info.ID = ID 
        else 
            Player.PlayerData.items[item.slot].info.ID = ID 
        end
    end
    Player.PlayerData.SetInventory(Player.PlayerData.items, true)
end


local function save_password(Player, item, password)
    if Player.PlayerData.items[item.slot] then 
        Player.PlayerData.items[item.slot].info.password = password
    end
    Player.Functions.SetInventory(Player.PlayerData.items, true)
end


local function get_clothes(Player, ID)
    for key, value in pairs(Config.items) do
        local tmp = Player.Functions.GetItemsByName(Key)
        for k, item in pairs(tmp) do 
            if item.info.ID == ID then 
                return {
                    item = item,
                    setting = value 
                }
            end 
        end 
    end
    return 
end

----- Database-----

local function SaveStashItems(stashId, items)
    if stashId and items then 
        for slot, item in pairs(items) do 
            item.description = nil 
        end 
        MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
        ,{
            ['stash'] = stashId,
            ['items'] = json.encode(items)
        })
    end
end 


local function isClothes(item)
    for item_name, _ in pairs (Config.items) do 
        if item.name == item_name then 
            return true 
        end 
    end
    return false 
end 
 
---- Database END ----

---- Blacklisted ---- 

local function isBlacklisted(item)
    if not Config.Blacklist_items.active then return false end 
    for _, item_name in pairs(Config.Blacklist_items.list) do 
        if item.name == item_name then 
            return true 
        end 
    end 
    return false 
end 


----- Keine Kleidungs Items / GetNonClothesItems -----

local function getNonClothesItems(source, items)
    local Player = QBCore.Functions.GetPlayer(source)
    local non_clothes_items = {}
    for key, item in pairs(items) do 
        local is_C_Cloth = isClothesCloth(items)
        local is_B_Listed = isBlacklisted(item)
        if is_C_Cloth or is_B_Listed then 
            Player.Functions.AddItem(item.name, item.amount, nil, item.info)
            TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item.name], "add")
            if is_C_Cloth then 
                TriggerClientEvent('QBCore:Notify', source, "Du kannst keine anderen Kleidungen Haben", "error") ---- ENG : You can not have another Clothes.
            end 
            if is_B_Listed then 
                TriggerClientEvent('QBCore:Notify', source, "Du kannst diesen Gegendstand nicht verstauen", "error") ----- ENG : You can not put this item inside your Clothes.
            end 
        else 
            non_clothes_items[#non_clothes_items + 1 ] = item 
        end 
    end 
    return non_clothes_items
end 

RegisterNetEvent('Celestic_clothesitems:server:saveClothes', function(sourve, stashId, items, cb)
local non_clothes_items = getNonClothesItems(source, items)
SaveStashItems(stashId, non_clothes_items)
cb (true)
end)


---------- Erstelle ITEMS --------------------


local function isOnHotbar(slot)
    for _, _slot in pairs(Config.Hotbar) do 
        if slot  == _slot then 
            return true 
        end 
    end 
    return false 
end 

for item_name, value in pairs(Config.items) do 
    QBCore.Functions.CreateUsableItem(item_name, function(souce, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end 
    local metadata = {}
    if item.info == '' or (type(item.info) == "table" and item.info.ID == nil) then 
    metadata.ID = RandomID(10)
    save_info(Player, item, metadata.ID)
    if value.locked then 
        TriggerClientEvent('Celestic_clothesitems:client:create_password', source, metadata.ID)
    end
    return
end
metadata.ID = item.info.ID
metadata.source = source
metadata.password = nil
metadata.locked = value.locked or false 

if isOnHotbar(item.slot) then 
---Fix to create blank password 

    if item.info.password == nil or item.info.password == '' then 
         if value.locked then 
                 TriggerClientEvent('Celestic_clothesitems:client:create_password', source, metadata.ID)
        return
    end 
end 
----  Fix end 

TriggerClientEvent('Celestic_clothesitems:client:enter_password', source, metadata)
else
TriggerClientEvent('QBCore:Notify', source, 'Du kannst die Kleidung nicht nutzen', "error")
end
end)
end


---- Öffnen / Lockpick -----

local function pickable ()
    local tmp = {}
    for key, value in pairs(Config.items) do 
        if value.locked then 
            tmp[#tmp + 1] = key 
        end 
    end 
    return tmp 
end 


local function isWhitelisted(Player)
    if not Config.whitelist.lockpick.active  then return true end
    local cid = Player.PlayerData.citizenid 
    local jobname = Player.PlayerData.job.name

for key, w_cid in pairs(Config.whitelist.lockpick.citizenid) do 
    if w_cid == cid then 
        return true 
    end 
end 

for key, w_job in pairs(Config.whitelist.lockpick.jobs) do 
    if w_job == jobname then 
        return true
    end 
end 
return false 
end 



QBCore.Functions.CreateUseableItems('clotheslockpicker', function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if not Player then return end
    if not isWhitelisted(Player) then 
        TriggerClientEvent('QBCore:Notify', source 'Du kannst dieses Item nicht benutzen', "error")
        return 
    end 
    local picables = pickable()
    for _, name in pairs(picables) do 
     local _item = Player.Functions.GetItemByName(name)
    local metadata = {}
    metadata.ID = _item.info.ID
    metadata.source = source
    metadata.password = nil
    metadata.locked = true 
    TriggerClientEvent('Celestic_clothesitems:client:lockpick', source, metadata)
    Player.Functions.RemoveItem('clotheslockpicker', 1)
    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items['clotheslockpicker'], "remove")
    return
    end 
end)



---- PASSWORD ----

RegisterNetEvent('Celestic_clothesitems:server:add_password', function(data)
    local Player = QBCore.Functions.GetPlayer(source)
    local clothes = get_clothes(Player, data.ID)
    if clothes then 
        save_password(Player, clothes.item, data.password)
        TriggerClientEvent('QBCore:Notify', source, 'Added Password', "success")
        return 
    else 
        TriggerClientEvent('QBCore:Notify', source, 'Failed to add password', "error")
    end 
end)

---- Open Clothes-Lockpick --------------

RegisterNetEvent('Celestic_clothesitems:server:open_clothes', function(clothes_metadata, lockpick)
    local Player = QBCore.Functions.GetPlayer(clothes_metadata.source)
    local clothes = get_clothes(Player, clothes_metadata.ID)
    local safe_data = {
        ID = clothes.item.info.ID,
        setting = clothes.setting 
    }
    if not clothes_metadata.locked then 
        TriggerClientEvent('Celestic_clothesitems:client:open', clothes_metadata.source, safe_data)
        return 
    end 

    if (clothes.item.info.password == clothes_metadata.password) or lockpick then 
        TriggerClientEvent('Celestic_clothesitems:client:open', clothes_metadata.source, safe_data)
        return 
    else 
        TriggerClientEvent('QBCore:Notify', clothes_metadata.source, 'Falsches Password', "error")
        return 
    end 
end)