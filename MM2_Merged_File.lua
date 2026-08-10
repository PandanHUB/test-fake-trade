-- FULL MERGED MM2 SCRIPT (Trade + Players + Items added)

-- Tabs
makeTab("Trade")
makeTab("Players")
makeTab("Items")
makeTab("Spawner")

local pages = {}

-- =========================
-- TRADE PAGE
-- =========================
local tradePage = Instance.new("Frame")
tradePage.Name = "TradePage"
tradePage.Size = UDim2.fromScale(1,1)
tradePage.BackgroundColor3 = Color3.fromRGB(24,24,31)
tradePage.Visible = false
tradePage.Parent = content
Instance.new("UICorner", tradePage).CornerRadius = UDim.new(0,8)
pages.Trade = tradePage

local PartnerUserBox = createSettingRow("Partner user:", TradeTable.Player2.Player, tradePage)

PartnerUserBox.FocusLost:Connect(function()
    TradeTable.Player2.Player = PartnerUserBox.Text
    PartnerUserBox.Text = TradeTable.Player2.Player
end)

CreateSpace(tradePage)

CreateButton(tradePage, "Recent trade", function()
    if LastTradePartner and LastTradePartner ~= "" then
        TradeTable.Player2.Player = LastTradePartner
        PartnerUserBox.Text = LastTradePartner
    end
end)

CreateSpace(tradePage)

CreateButton(tradePage, "Start trade", function()
    StartTrade()
end)

CreateSpace(tradePage)

CreateButton(tradePage, "Accept their offer", function()
    if not next(TradeTable["Player1"]["Offer"]) and not next(TradeTable["Player2"]["Offer"]) then
        return
    end
    if v84 then return end

    TheirOffer.Accepted.Visible = true
    TradeTable["Player2"]["Accepted"] = true
    AcceptTrade()
end)

-- =========================
-- PLAYERS PAGE
-- =========================
local playersPage = Instance.new("Frame")
playersPage.Name = "PlayersPage"
playersPage.Size = UDim2.fromScale(1,1)
playersPage.BackgroundColor3 = Color3.fromRGB(24,24,31)
playersPage.Visible = false
playersPage.Parent = content
Instance.new("UICorner", playersPage).CornerRadius = UDim.new(0,8)
pages.Players = playersPage

local playerListFrame = Instance.new("Frame")
playerListFrame.Size = UDim2.new(1, 0, 1, 0)
playerListFrame.BackgroundTransparency = 1
playerListFrame.Parent = playersPage

local layout1 = Instance.new("UIListLayout", playerListFrame)
layout1.Padding = UDim.new(0,5)

for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 25)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,50)
    btn.Text = plr.Name
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = playerListFrame

    btn.MouseButton1Click:Connect(function()
        TradeTable.Player2.Player = plr.Name
    end)
end

-- =========================
-- ITEMS PAGE
-- =========================
local itemsPage = Instance.new("Frame")
itemsPage.Name = "ItemsPage"
itemsPage.Size = UDim2.fromScale(1,1)
itemsPage.BackgroundColor3 = Color3.fromRGB(24,24,31)
itemsPage.Visible = false
itemsPage.Parent = content
Instance.new("UICorner", itemsPage).CornerRadius = UDim.new(0,8)
pages.Items = itemsPage

local itemListFrame = Instance.new("Frame")
itemListFrame.Size = UDim2.new(1, 0, 1, 0)
itemListFrame.BackgroundTransparency = 1
itemListFrame.Parent = itemsPage

local layout2 = Instance.new("UIListLayout", itemListFrame)
layout2.Padding = UDim.new(0,5)

for _, item in ipairs(WeaponCatalog) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 25)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,50)
    btn.Text = item.name .. " [" .. item.rarity .. "]"
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = itemListFrame

    btn.MouseButton1Click:Connect(function()
        table.insert(TradeTable.Player1.Offer, item.key)
    end)
end
