--   _____                           _
--  / ____|                         | |
-- | |  __  ___ _ __   ___ _ __ __ _| |
-- | | |_ |/ _ \ '_ \ / _ \ '__/ _` | |
-- | |__| |  __/ | | |  __/ | | (_| | |
--  \_____|\___|_| |_|\___|_|  \__,_|_|

function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(5)
  end
end

--  _  __                _                  _                 _   _
-- | |/ /               | |     /\         (_)               | | (_)
-- | ' / _ __   ___  ___| |    /  \   _ __  _ _ __ ___   __ _| |_ _  ___  _ __
-- |  < | '_ \ / _ \/ _ \ |   / /\ \ | '_ \| | '_ ` _ \ / _` | __| |/ _ \| '_ \
-- | . \| | | |  __/  __/ |  / ____ \| | | | | | | | | | (_| | |_| | (_) | | | |
-- |_|\_\_| |_|\___|\___|_| /_/    \_\_| |_|_|_| |_| |_|\__,_|\__|_|\___/|_| |_|

RegisterNetEvent('pa:kneelhu')

AddEventHandler('pa:kneelhu',
  function()
    local player = GetPlayerPed(-1)
    if (DoesEntityExist(player) and not IsEntityDead(player)) then
      loadAnimDict("random@arrests")
      loadAnimDict("random@arrests@busted")
      if (IsEntityPlayingAnim(player, "random@arrests@busted", "idle_a", 3)) then
        TaskPlayAnim(player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        Wait(3000)
        TaskPlayAnim(player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0)
      else
        TaskPlayAnim(player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        Wait(4000)
        TaskPlayAnim(player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        Wait(500)
        TaskPlayAnim(player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        Wait(1000)
        TaskPlayAnim(player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0)
      end
    end
  end
)

--Disables the player's controls during the Kneel animation
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests@busted", "idle_a", 3) then
        DisableControlAction(1, 140, true)
        DisableControlAction(1, 141, true)
        DisableControlAction(1, 142, true)
        DisableControlAction(0, 21, true)
        DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
        DisablePlayerFiring(ped, true) -- Disable weapon firing
      end
    end
  end
)

--  _____           _ _                        _                 _   _
-- |  __ \         | (_)           /\         (_)               | | (_)
-- | |__) |__ _  __| |_  ___      /  \   _ __  _ _ __ ___   __ _| |_ _  ___  _ __
-- |  _  // _` |/ _` | |/ _ \    / /\ \ | '_ \| | '_ ` _ \ / _` | __| |/ _ \| '_ \
-- | | \ \ (_| | (_| | | (_) |  / ____ \| | | | | | | | | | (_| | |_| | (_) | | | |
-- |_|  \_\__,_|\__,_|_|\___/  /_/    \_\_| |_|_|_| |_| |_|\__,_|\__|_|\___/|_| |_|

RegisterNetEvent('pa:radio')

AddEventHandler('pa:radio',
  function()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
      Citizen.CreateThread(
        function()
          RequestAnimDict("random@arrests")
          while (not HasAnimDictLoaded("random@arrests")) do
            Citizen.Wait(100)
          end
          if IsEntityPlayingAnim(ped, "random@arrests", "generic_radio_chatter", 3) then
            ClearPedSecondaryTask(ped)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
          else
            TaskPlayAnim(ped, "random@arrests", "generic_radio_chatter", 8.0, 2.5, -1, 49, 0, 0, 0, 0)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
          end
        end
      )
    end
  end
)

--  _   _       _     _               ___        _                 _   _             
-- | | | |     | |   | |             / _ \      (_)               | | (_)            
-- | |_| | ___ | |___| |_ ___ _ __  / /_\ \_ __  _ _ __ ___   __ _| |_ _  ___  _ __  
-- |  _  |/ _ \| / __| __/ _ \ '__| |  _  | '_ \| | '_ ` _ \ / _` | __| |/ _ \| '_ \ 
-- | | | | (_) | \__ \ ||  __/ |    | | | | | | | | | | | | | (_| | |_| | (_) | | | |
-- \_| |_/\___/|_|___/\__\___|_|    \_| |_/_| |_|_|_| |_| |_|\__,_|\__|_|\___/|_| |_|
                                                                                  


--- DO NOT EDIT THIS
local holstered = true

-- RESTRICTED PEDS --
-- local skins = {
-- 	"s_m_y_cop_01",
-- 	"s_f_y_cop_01",
-- 	"s_m_y_hwaycop_01",
-- 	"s_m_y_sheriff_01",
-- 	"s_f_y_sheriff_01",
-- 	"s_m_y_ranger_01",
-- 	"s_f_y_ranger_01",
-- }

-- Add/remove weapon hashes here to be added for holster checks.
local weapons = {
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_STUNGUN",
}

-- HOLD WEAPON HOLSTER ANIMATION --

Citizen.CreateThread( function()
	while true do 
		Citizen.Wait( 0 )
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) and CheckSkin(ped) then 
			DisableControlAction( 0, 20, true ) -- INPUT_MULTIPLAYER_INFO (Z)
			if not IsPauseMenuActive() then 
				loadAnimDict( "reaction@intimidation@cop@unarmed" )		
				if IsDisabledControlJustReleased( 0, 20 ) then -- INPUT_MULTIPLAYER_INFO (Z)
					ClearPedTasks(ped)
					SetEnableHandcuffs(ped, false)
					SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
				else
					if IsDisabledControlJustPressed( 0, 20 ) and CheckSkin(ped) then -- INPUT_MULTIPLAYER_INFO (Z)
						SetEnableHandcuffs(ped, true)
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true) 
						TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
					end
					if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "reaction@intimidation@cop@unarmed", "intro", 3) then 
						DisableActions(ped)
					end	
				end
			end 
		end 
	end
end )

-- HOLSTER/UNHOLSTER PISTOL --
 
 Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) then
			-- if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) and CheckSkin(ped) then
			loadAnimDict( "rcmjosh4" )
			loadAnimDict( "weapons@pistol@" )
			if CheckWeapon(ped) then
				if holstered then
					TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(600)
					ClearPedTasks(ped)
					holstered = false
				end
				SetPedComponentVariation(ped, 9, 0, 0, 0)
			elseif not CheckWeapon(ped) then
				if not holstered then
					TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(500)
					ClearPedTasks(ped)
					holstered = true
				end
				SetPedComponentVariation(ped, 9, 1, 0, 0)
			end
		end
	end
end)

function CheckSkin(ped)
	for i = 1, #skins do
		if GetHashKey(skins[i]) == GetEntityModel(ped) then
			return true
		end
	end
	return false
end

function CheckWeapon(ped)
	for i = 1, #weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end