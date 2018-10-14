--   _____                           _
--  / ____|                         | |
-- | |  __  ___ _ __   ___ _ __ __ _| |
-- | | |_ |/ _ \ '_ \ / _ \ '__/ _` | |
-- | |__| |  __/ | | |  __/ | | (_| | |
--  \_____|\___|_| |_|\___|_|  \__,_|_|

local BlockControls = false

function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(5)
  end
end

--Disables the player's controls during the some animations
Citizen.CreateThread(
  function()
    while true do
      Citizen.Wait(0)
      if BlockControls == true then
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

--  _  __                _                  _                 _   _
-- | |/ /               | |     /\         (_)               | | (_)
-- | ' / _ __   ___  ___| |    /  \   _ __  _ _ __ ___   __ _| |_ _  ___  _ __
-- |  < | '_ \ / _ \/ _ \ |   / /\ \ | '_ \| | '_ ` _ \ / _` | __| |/ _ \| '_ \
-- | . \| | | |  __/  __/ |  / ____ \| | | | | | | | | | (_| | |_| | (_) | | | |
-- |_|\_\_| |_|\___|\___|_| /_/    \_\_| |_|_|_| |_| |_|\__,_|\__|_|\___/|_| |_|

RegisterNetEvent('pa:kneelhu')
local isKneeling = false

AddEventHandler('pa:kneelhu',
  function()
    local player = GetPlayerPed(-1)
    if (DoesEntityExist(player) and not IsEntityDead(player)) then
      loadAnimDict("random@arrests")
      loadAnimDict("random@arrests@busted")
      if (IsEntityPlayingAnim(player, "random@arrests@busted", "idle_a", 3)) then
        isKneeling = false
        ClearPedTasksImmediately(ped)
        ClearPedTasks(ped)
        ClearPedSecondaryTask(ped)
        TaskPlayAnim(player, "random@arrests@busted", "exit", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        Wait(3000)
				TaskPlayAnim(player, "random@arrests", "kneeling_arrest_get_up", 8.0, 1.0, -1, 128, 0, 0, 0, 0)
				BlockControls = false
			else
        BlockControls = true
        isKneeling = true
        
        TaskPlayAnim(player, "random@arrests", "idle_2_hands_up", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        if isKneeling == false then
          return
        end
        Wait(4000)
        TaskPlayAnim(player, "random@arrests", "kneeling_arrest_idle", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        if isKneeling == false then
          return
        end
        Wait(500)
        TaskPlayAnim(player, "random@arrests@busted", "enter", 8.0, 1.0, -1, 2, 0, 0, 0, 0)
        if isKneeling == false then
          return
        end
        Wait(1000)
        TaskPlayAnim(player, "random@arrests@busted", "idle_a", 8.0, 1.0, -1, 9, 0, 0, 0, 0)
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

--  _____ _ _   _   _             
-- / ____(_) | | | (_)            
--| (___  _| |_| |_ _ _ __   __ _ 
-- \___ \| | __| __| | '_ \ / _` |
-- ____) | | |_| |_| | | | | (_| |
--|_____/|_|\__|\__|_|_| |_|\__, |
--                           __/ |
--                          |___/ 

RegisterNetEvent('pa:sit')

AddEventHandler('pa:sit',
  function()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
      Citizen.CreateThread(
        function()
          RequestAnimDict("amb@world_human_picnic@male@base")
          while (not HasAnimDictLoaded("amb@world_human_picnic@male@base")) do
            Citizen.Wait(100)
          end
          if IsEntityPlayingAnim(ped, "amb@world_human_picnic@male@base", "base", 3) then
            BlockControls = false
            ClearPedTasksImmediately(ped)
            ClearPedTasks(ped)
            ClearPedSecondaryTask(ped)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
          else
            BlockControls = true
            TaskPlayAnim(ped, "amb@world_human_picnic@male@base", "base", 8.0, 2.5, -1, 1, 0, 0, 0, 0)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
          end
        end
      )
    end
  end
)

--  _      _        _____                      
-- | |    (_)      |  __ \                     
-- | |     _  ___  | |  | | _____      ___ __  
-- | |    | |/ _ \ | |  | |/ _ \ \ /\ / / '_ \ 
-- | |____| |  __/ | |__| | (_) \ V  V /| | | |
-- |______|_|\___| |_____/ \___/ \_/\_/ |_| |_|

RegisterNetEvent('pa:liedown')

AddEventHandler('pa:liedown',
  function()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
      Citizen.CreateThread(
        function()
          RequestAnimDict("mini@cpr@char_b@cpr_str")
          while (not HasAnimDictLoaded("mini@cpr@char_b@cpr_str")) do
            Citizen.Wait(100)
          end
          if IsEntityPlayingAnim(ped, "mini@cpr@char_b@cpr_str", "cpr_kol_idle", 3) then
            BlockControls = false
            ClearPedTasksImmediately(ped)
            ClearPedTasks(ped)
            ClearPedSecondaryTask(ped)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
          else
            BlockControls = true
            TaskPlayAnim(ped, "mini@cpr@char_b@cpr_str", "cpr_kol_idle", 8.0, 2.5, -1, 1, 0, 0, 0, 0)
            SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
          end
        end
      )
    end
  end
)

--   _____ _____  _____  
--  / ____|  __ \|  __ \ 
-- | |    | |__) | |__) |
-- | |    |  ___/|  _  / 
-- | |____| |    | | \ \ 
--  \_____|_|    |_|  \_\

RegisterNetEvent('pa:cpr')
local DoingCPR = false

AddEventHandler('pa:cpr',
  function()
    local ped = GetPlayerPed(-1)

    if (DoesEntityExist(ped) and not IsEntityDead(ped)) then
      Citizen.CreateThread(
        function()
          RequestAnimDict("mini@cpr@char_a@cpr_str")
          RequestAnimDict("mini@cpr@char_a@cpr_def")
          while (not HasAnimDictLoaded("mini@cpr@char_a@cpr_str")) do
            Citizen.Wait(100)
          end
          while (not HasAnimDictLoaded("mini@cpr@char_a@cpr_def")) do
            Citizen.Wait(100)
          end
          if IsEntityPlayingAnim(ped, "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 3) then
            DoingCPR = false
            ClearPedTasksImmediately(ped)
            ClearPedTasks(ped)
            ClearPedSecondaryTask(ped)
						SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
						BlockControls = false
          else
						BlockControls = true
            DoingCPR = true

            TaskPlayAnim(ped, "mini@cpr@char_a@cpr_str", "cpr_kol", 8.0, 0, -1, 0, 0, 0, 0, 0) -- CPR Breath (play first) mini@cpr@char_a@cpr_def  cpr_kol 7466 
            if DoingCPR == false then
              return
            end
            Wait(7466)
            TaskPlayAnim(ped, "mini@cpr@char_a@cpr_str", "cpr_kol_to_cpr", 8.0, 0, -1, 0, 0, 0, 0, 0) -- CPR Breath (play first) mini@cpr@char_a@cpr_def  cpr_kol 7466 
            if DoingCPR == false then
              return
            end
            Wait(1566)
            TaskPlayAnim(ped, "mini@cpr@char_a@cpr_str", "cpr_pumpchest", 8.0, 0, -1, 1, 0, 0, 0, 1) -- CPR Chest Pump (play second) mini@cpr@char_a@cpr_st cpr_pumpchest 1000
          end
        end
      )
    end
  end
)

function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end