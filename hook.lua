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
        title = "NatHub Fisch Finder",
        description = "Enter this job id using nathub below to join.",
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
        username = "NatHub Fisch-Finder",
        avatar_url = "https://media.discordapp.net/attachments/1360941350224396411/1361879600442904707/98e3df0604bdabe7b37ad4ccaf02ad0d.webp?ex=68005cb7&is=67ff0b37&hm=b742141585401eb1e6554eb0916ea757a7bcf8e9759ae181eb92493dd009ce56&=&format=webp",
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
        print("NatHub Fisch-Finder: Webhook sent for event - " .. eventName)
    else
        warn("NatHub Fisch-Finder: Failed to send webhook!")
    end
	task.wait(2)
end

return SendFischFinderWebhook
