-- WEBHOOK
local function SendFischFinderWebhook(eventName, WEBHOOK_URL, jobId)
	jobId = jobId or game.JobId
    local HttpService = game:GetService("HttpService")
    local placeId = game.PlaceId
    local players = #game.Players:GetPlayers()
    local maxPlayers = game.Players.MaxPlayers

	local Seaplace = game:GetService("ReplicatedStorage"):FindFirstChild("Place")
	local sea = (Seaplace and Seaplace.Value == "secondsea") and "Second Sea" or "First Sea"
	
    local embed = {
        title = "ThanHub Fisch Finder",
        description = "Enter this job id using ThanHub below to join.",
        color = 0x0080FF,
        fields = {
            {name = "[🔎] Event", value = "```" .. eventName .. "```"},
            {name = "[📂] JobId", value = "```" .. jobId .. "```"},
            {name = "[👥] Players", value = "```" .. players .. " / " .. maxPlayers .. "```", inline = true},
			{name = "[🌊] Sea Location", value = "```" .. sea .. "```", inline = true},
        },
        timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }

    local webhookData = {
        username = "ThanHub Fisch-Finder",
        avatar_url = "https://media.discordapp.net/attachments/1342846567094161488/1346724283753304084/Gambar_WhatsApp_2025-02-18_pukul_06.35.37_182c3226.jpg?ex=680c76ba&is=680b253a&hm=a9346accbf734d6aea99b7c6e7dd746f0a9a58136dec3c0329b8ca610b95511e&=&format=webp&width=1080&height=1079",
        embeds = {embed}
    }

    local success, response = pcall(function()
        return (syn and syn.request or http_request) {
            Url = WEBHOOK_URL,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode(webhookData)
        }
    end)

    if success then
        print("ThanHub Fisch-Finder: Webhook sent for event - " .. eventName)
    else
        warn("ThanHub Fisch-Finder: Failed to send webhook!")
    end
	task.wait(1)
end

return SendFischFinderWebhook
