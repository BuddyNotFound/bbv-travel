Main = {blip={}}

CreateThread(function()
    Main:Blip(Config.Teleports.CayoPerico.Teleport, 'CP')
    Main:Blip(Config.Teleports.LosSantos.Teleport, 'LS')
    while true do
        Wait(0)
        Main:Teleport(Config.Teleports.CayoPerico.Teleport, 'CP')
        Main:Teleport(Config.Teleports.LosSantos.Teleport, 'LS')
    end
end)

function Main:Teleport(data,type)
    if type == 'LS' then 
        local pos = data
        local pedpos = GetEntityCoords(PlayerPedId())
        local dist = #(pedpos - pos)
        if dist < 10 then 
            DrawMarker(2,Config.Teleports.LosSantos.Teleport, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.2, 0.2, 0.2, 255, 5, 5, 255, false, true, 2, nil, nil, false)
            if dist < 3 then 
                self:Prompt(Lang.GoToCayo)
                if IsControlJustReleased(1, 38) then 
                    self:TpCayo()
                end
            end
        end
    end
    if type == 'CP' then 
        local pos = data
        local pedpos = GetEntityCoords(PlayerPedId())
        local dist = #(pedpos - pos)
        if dist < 10 then 
            DrawMarker(2,Config.Teleports.CayoPerico.Teleport, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.2, 0.2, 0.2, 255, 5, 5, 255, false, true, 2, nil, nil, false)
            if dist < 3 then 
                self:Prompt(Lang.GoToLs)
                if IsControlJustReleased(1, 38) then 
                    self:TpLs()
                end
            end
        end
    end
end

function Main:Blip(data,type)
    if type == "LS" then 
        self.blip[type] = AddBlipForCoord(data.x, data.y, data.z)
        SetBlipSprite( self.blip[type], Config.Teleports.LosSantos.Blip.Sprite)
        SetBlipDisplay( self.blip[type], Config.Teleports.LosSantos.Blip.Display)
        SetBlipScale( self.blip[type], Config.Teleports.LosSantos.Blip.Size)
        SetBlipColour( self.blip[type], Config.Teleports.LosSantos.Blip.Colour)
        SetBlipAsShortRange( self.blip[type], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Teleports.LosSantos.Blip.Label)
        EndTextCommandSetBlipName( self.blip[type])
    end
    if type == "CP" then 
        self.blip[type] = AddBlipForCoord(data.x, data.y, data.z)
        SetBlipSprite( self.blip[type], Config.Teleports.CayoPerico.Blip.Sprite)
        SetBlipDisplay( self.blip[type], Config.Teleports.CayoPerico.Blip.Display)
        SetBlipScale( self.blip[type], Config.Teleports.CayoPerico.Blip.Size)
        SetBlipColour( self.blip[type], Config.Teleports.CayoPerico.Blip.Colour)
        SetBlipAsShortRange( self.blip[type], true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(Config.Teleports.CayoPerico.Blip.Label)
        EndTextCommandSetBlipName( self.blip[type])
    end
end

function Main:TpCayo()
    RequestCutscene('hs4_lsa_take_nimb2', 8)
    local timeout = GetGameTimer() + 10000
    while not HasCutsceneLoaded() and GetGameTimer() < timeout do
        Wait(0)
    end
    if HasCutsceneLoaded() then
        DoScreenFadeOut(1300)
        Wait(1500)
        StartCutscene('hs4_lsa_take_nimb2')
        SetEntityCoords(PlayerPedId(), Config.Teleports.CayoPerico.Spawn)
        SetEntityHeading(PlayerPedId(), Config.Teleports.CayoPerico.Spawn.w)
        DoScreenFadeIn(500)
        CreateThread(function()
            SetTimeout(100, function()
                if IsCutsceneActive() then
                    local coords = GetWorldCoordFromScreenCoord(0.5, 0.5)
                    NewLoadSceneStartSphere(coords.x, coords.y, coords.z, 1000, 0)
                end
            end)
        end)
    end
end

function Main:TpLs()
    RequestCutscene('hs4_isd_take_nimb2', 8)
    local timeout = GetGameTimer() + 10000
    while not HasCutsceneLoaded() and GetGameTimer() < timeout do
        Wait(0)
    end
    if HasCutsceneLoaded() then
        DoScreenFadeOut(1300)
        Wait(1500)
        StartCutscene('hs4_isd_take_nimb2')
        SetEntityCoords(PlayerPedId(), Config.Teleports.LosSantos.Spawn)
        SetEntityHeading(PlayerPedId(), Config.Teleports.LosSantos.Spawn.w)
        DoScreenFadeIn(500)
        CreateThread(function()
            SetTimeout(100, function()
                if IsCutsceneActive() then
                    local coords = GetWorldCoordFromScreenCoord(0.5, 0.5)
                    NewLoadSceneStartSphere(coords.x, coords.y, coords.z, 1000, 0)
                end
            end)
        end)
    end
end

function Main:Prompt(msg) 
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg) 
	DrawNotification(true, false)
end