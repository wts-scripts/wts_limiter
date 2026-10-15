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

Config = {}

------------------------------------------------------------
-- TOUCHE
------------------------------------------------------------
-- Touche par défaut (modifiable par le joueur dans
-- Paramètres > Touches > FiveM).
-- Exemples : 'L', 'SEMICOLON', 'COMMA', 'PERIOD', 'OEM_102'...
Config.Key = 'L'

------------------------------------------------------------
-- UNITE DE VITESSE
------------------------------------------------------------
-- 'kmh' ou 'mph'
Config.Unit = 'kmh'

------------------------------------------------------------
-- NOTIFICATIONS
------------------------------------------------------------
Config.NotifyTitle    = 'WTS Limiter'
Config.NotifyDuration = 4000   -- ms

-- Utiliser wts_notify s'il est démarré (style unifié).
-- Sinon le limiteur affiche ses propres notifications.
Config.UseWtsNotify = true

-- Couleurs (hex)
Config.Colors = {
    background = '#1f1f23',   -- gris sombre
    text       = '#e5e5e5',
    neutral    = '#8a8a8f',   -- liseré gris (infos)
    enable     = '#22c55e',   -- vert : activer
    disable    = '#ef4444'    -- rouge : désactiver
}

------------------------------------------------------------
-- TEXTES
------------------------------------------------------------
Config.Text = {
    enabled   = 'Limiter enabled',
    disabled  = 'Limiter disabled',
    stopped   = "You can't enable the limiter while stopped",
    noVehicle = 'You must be in a vehicle to use the limiter!'
}

-- Français :
-- Config.Text = {
--     enabled   = 'Limiteur activé',
--     disabled  = 'Limiteur désactivé',
--     stopped   = "Impossible d'activer le limiteur à l'arrêt",
--     noVehicle = 'Vous devez être dans un véhicule pour utiliser le limiteur !'
-- }
