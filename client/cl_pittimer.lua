local pitTimerActive = false
local pitNotifyHandle = nil
local pitTimeRemaining = 0
local locale = lib.locale

RegisterNetEvent('hbd_pittimer:PitTimer', function()
    if pitTimerActive then
        pitTimeRemaining = 5 * 60
        lib.notify({
            title = locale('pit_timer.updated_title'),
            description = locale('pit_timer.updated_desc'),
            type = 'info',
            icon = 'car-burst',
            position = 'top-right'
        })
        return
    end

    pitTimerActive = true
    pitTimeRemaining = 5 * 60

    pitNotifyHandle = lib.notify({
        title = locale('pit_timer.started_title'),
        description = locale('pit_timer.started_desc'),
        type = 'info',
        icon = 'car-burst',
        position = 'top-right',
        duration = 0
    })

    CreateThread(function()
        while pitTimeRemaining > 0 do
            Wait(1000)
            pitTimeRemaining -= 1
        end

        PlaySoundFrontend(-1, "TIMER_STOP", "HUD_MINI_GAME_SOUNDSET", true)
        if pitNotifyHandle then
            pitNotifyHandle:Remove()
            pitNotifyHandle = nil
        end
        pitTimerActive = false
    end)
end)

CreateThread(function()
    while true do
        Wait(0)
        if pitTimerActive and pitTimeRemaining > 0 then
            local minutes = math.floor(pitTimeRemaining / 60)
            local seconds = pitTimeRemaining % 60
            local text = string.format("PIT-timer: %02d:%02d", minutes, seconds)

            SetTextFont(0)
            SetTextProportional(1)
            SetTextScale(0.35, 0.35)
            SetTextColour(255, 255, 255, 255)
            SetTextOutline()
            SetTextCentre(true)
            BeginTextCommandDisplayText("STRING")
            AddTextComponentSubstringPlayerName(text)
            EndTextCommandDisplayText(0.5, 0.05)
        end
    end
end)
