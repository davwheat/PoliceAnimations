function loadAnimDict(dict)
  while (not HasAnimDictLoaded(dict)) do
    RequestAnimDict(dict)
    Citizen.Wait(5)
  end
end

RegisterNetEvent("pa:kneelhu")

AddEventHandler(
  "pa:kneelhu",
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

RegisterNetEvent("pa:radio")

AddEventHandler(
  "pa:radio",
  function()
    local ped = PlayerPedId()
    if DoesEntityExist(ped) and not IsEntityDead(ped) then
      if not IsPauseMenuActive() then
        loadAnimDict("random@arrests")
        if IsControlJustReleased(0, 88) then
          ClearPedTasks(ped)
          SetEnableHandcuffs(ped, false)
        else
          if not IsPlayerFreeAiming(PlayerId()) then
            TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
            SetEnableHandcuffs(ped, true)
          elseif IsPlayerFreeAiming(PlayerId()) then
            TaskPlayAnim(ped, "random@arrests", "radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
            SetEnableHandcuffs(ped, true)
          end
          if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "generic_radio_enter", 3) then
            DisableActions(ped)
          elseif IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "radio_chatter", 3) then
            DisableActions(ped)
          end
        end
      end
    end
  end
)

--Disables the player's controls during the RAdio animation
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

-- Disables the player's controls during the Radio animation.
function DisableActions(ped)
  DisableControlAction(1, 140, true)
  DisableControlAction(1, 141, true)
  DisableControlAction(1, 142, true)
  DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
  DisablePlayerFiring(ped, true) -- Disable weapon firing
end
