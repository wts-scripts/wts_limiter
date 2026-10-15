--[[
    WTS Limiter - Standalone speed limiter for FiveM
    Copyright (C) 2026 WTS Scripts

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

------------------------------------------------------------
-- ETAT
------------------------------------------------------------

local limiterActive = false
local limiterSpeedMs = 0.0          -- vitesse limite en m/s (interne)

local currentVehicle = 0
local currentVehicleMaxSpeed = nil


------------------------------------------------------------
-- UNITE
------------------------------------------------------------

local UNIT_FACTOR = (Config.Unit == 'mph') and 2.236936 or 3.6
local UNIT_LABEL  = (Config.Unit == 'mph') and 'mp/h' or 'km/h'

local function MsToUnit(ms)
    return math.ceil(ms * UNIT_FACTOR)
end


------------------------------------------------------------
-- NOTIFICATION (NUI)
------------------------------------------------------------
-- kind : 'enable' (vert) | 'disable' (rouge) | 'info' (gris)
-- speed : nombre déjà converti dans l'unité configurée (optionnel)

local function Notify(text, kind, speed)

    -- wts_notify démarré : notifications unifiées
    if Config.UseWtsNotify ~= false and GetResourceState('wts_notify') == 'started' then
        local kindMap = { enable = 'success', disable = 'error', info = 'info' }
        exports.wts_notify:Notify({
            id       = 'wts_limiter',
            title    = Config.NotifyTitle,
            message  = text,
            type     = kindMap[kind] or 'info',
            value    = speed,
            unit     = speed and UNIT_LABEL or nil,
            duration = Config.NotifyDuration
        })
        return
    end

    local accent = Config.Colors.neutral

    if kind == 'enable' then
        accent = Config.Colors.enable
    elseif kind == 'disable' then
        accent = Config.Colors.disable
    end

    SendNUIMessage({
        action   = 'notify',
        title    = Config.NotifyTitle,
        text     = text,
        speed    = speed,
        unit     = UNIT_LABEL,
        accent   = accent,
        colors   = Config.Colors,
        duration = Config.NotifyDuration
    })
end


------------------------------------------------------------
-- VEHICULE ACTUEL
------------------------------------------------------------

local function GetCurrentVehicle()
    local ped = PlayerPedId()

    if not IsPedInAnyVehicle(ped, false) then
        return 0
    end

    return GetVehiclePedIsIn(ped, false)
end


------------------------------------------------------------
-- RESTAURER LA VITESSE ORIGINALE
------------------------------------------------------------

local function RestoreVehicleSpeed()

    if currentVehicle == 0 then
        return
    end

    if not DoesEntityExist(currentVehicle) then
        return
    end

    if currentVehicleMaxSpeed then
        SetEntityMaxSpeed(currentVehicle, currentVehicleMaxSpeed)
    end

end


------------------------------------------------------------
-- DESACTIVER
------------------------------------------------------------

local function DisableLimiter()

    local lastSpeed = MsToUnit(limiterSpeedMs)

    limiterActive = false
    limiterSpeedMs = 0.0

    RestoreVehicleSpeed()

    Notify(Config.Text.disabled, 'disable', lastSpeed)

end


------------------------------------------------------------
-- ACTIVER
------------------------------------------------------------

local function EnableLimiter(vehicle)

    if vehicle == 0 then
        return
    end

    currentVehicle = vehicle

    -- Sauvegarde de la vitesse maximale originale
    currentVehicleMaxSpeed = GetVehicleMaxSpeed(vehicle)

    local speedMs = GetEntitySpeed(vehicle)

    if MsToUnit(speedMs) < 1 then
        Notify(Config.Text.stopped, 'info')
        return
    end

    limiterSpeedMs = speedMs
    limiterActive = true

    Notify(Config.Text.enabled, 'enable', MsToUnit(speedMs))

end


------------------------------------------------------------
-- TOUCHE DU LIMITEUR
------------------------------------------------------------

RegisterCommand('togglelimiter', function()

    local vehicle = GetCurrentVehicle()

    if vehicle == 0 then
        Notify(Config.Text.noVehicle, 'info')
        return
    end

    if limiterActive then
        DisableLimiter()
    else
        EnableLimiter(vehicle)
    end

end, false)


------------------------------------------------------------
-- RACCOURCI CLAVIER
------------------------------------------------------------

RegisterKeyMapping(
    'togglelimiter',
    'WTS Limiter : toggle',
    'keyboard',
    Config.Key
)


------------------------------------------------------------
-- APPLICATION DU LIMITEUR
------------------------------------------------------------

CreateThread(function()

    while true do

        if limiterActive then

            local vehicle = GetCurrentVehicle()

            -- Sortie du véhicule ou changement de véhicule
            if vehicle == 0 or vehicle ~= currentVehicle then
                DisableLimiter()
            else
                SetEntityMaxSpeed(vehicle, limiterSpeedMs)
            end

            Wait(50)

        else

            Wait(500)

        end

    end

end)


------------------------------------------------------------
-- RESTAURATION A L'ARRET DU SCRIPT
------------------------------------------------------------

AddEventHandler('onResourceStop', function(resource)

    if resource ~= GetCurrentResourceName() then
        return
    end

    RestoreVehicleSpeed()

end)
