--[[
	Copyright 2008-2025 João Cardoso
	All Rights Reserved
--]]

local Broker = Scrap:NewModule('Broker', LibStub('LibDataBroker-1.1'):NewDataObject('Scrap', {
	type = 'data source', tocname = ...
}))

function Broker:OnLoad()
	for k,v in pairs(Scrap.Merchant) do
		if type(v) == 'function' then
			self[k] = self[k] or v
		end
	end

	self.OnEnter, self.OnLeave = nil
	self:RegisterEvent('BAG_UPDATE', 'OnUpdate')
	self:RegisterSignal('LIST_CHANGED', 'OnUpdate')
	self:OnUpdate()
end

function Broker:OnUpdate()
	local value = self:GetReport()
	self.icon = 'interface/addons/scrap/art/scrap-small' .. (value > 0 and '' or '-disabled')
	self.text = GetMoneyString(value, true)
end

function Broker:OnClick(button)
	if Scrap.Merchant:IsVisible() or button == 'RightButton' then
		Scrap.Merchant.OnClick(self, button)
	else
		Scrap:DestroyCheapest()
	end
end

function Broker:OnTooltipShow()
	Scrap.Merchant:UpdateTip(self)
end
