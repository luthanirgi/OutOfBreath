local isSprinting, isSwimming, isUnderwater = false, false, false

Citizen.CreateThread(function()
	while true do
	local sleep = 1500
	local stamina = GetPlayerSprintStaminaRemaining(PlayerId())
	if isSprinting then
		sleep = 5
		if stamina == 100 then
			if not isSwimming and not isUnderwater then
				RequestAnimDict("re@construction")
				while not HasAnimDictLoaded("re@construction") do
				Citizen.Wait(100)
				end			
				TaskPlayAnim(PlayerPedId(), "re@construction", "out_of_breath", 8.0, 8.0,-1, 32, 0, false, false, false)
			end
		end
	end
	Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
    while true do
	local lPed = GetPlayerPed(-1)
	isSprinting = IsPedSprinting(lPed)
	isSwimming = IsPedSwimming(lPed)
	isUnderwater = IsPedSwimmingUnderWater(lPed)
        Citizen.Wait(500)
    end
end)
