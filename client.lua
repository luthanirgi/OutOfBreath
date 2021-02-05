local isSprinting = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100) -- check every 100 ticks, performance matters
		local letSleep = true
		if isSprinting then
			local stamina = GetPlayerSprintStaminaRemaining(PlayerId())
			letSleep = false
			if stamina == 100 then
				local playerPed = PlayerPedId()
				if not(IsPedSwimming(playerPed)) and not(IsPedSwimmingUnderWater(playerPed)) then
					RequestAnimDict("re@construction")
					while not HasAnimDictLoaded("re@construction") do
					Citizen.Wait(100)
					end			
					DisableControlAction(0, 73, true) -- Disable X - I have to disable cancel animation
				
					TaskPlayAnim(PlayerPedId(), "re@construction", "out_of_breath", 8.0, 8.0,5000, 32, 0, false, false, false)
					Citizen.Wait(5000)
					DisableControlAction(0, 73, false) -- Enabled X - I have to disable cancel animation
					RemoveAnimDict("re@construction")
				end
			end
		end
		if letSleep then
		Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
    while true do
	local lPed = GetPlayerPed(-1)
	isSprinting = IsPedSprinting(lPed)
        Citizen.Wait(500)
    end
end)
