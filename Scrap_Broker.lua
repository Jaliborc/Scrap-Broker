--[[
Copyright 2010-2023 João Cardoso
Scrap Broker is distributed under the terms of the GNU General Public License (Version 3).
As a special exception, the copyright holders of this addon do not give permission to
redistribute and/or modify it.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the addon. If not, see <http://www.gnu.org/licenses/gpl-3.0.txt>.

This file is part of Scrap Broker.
--]]

local Broker = Scrap:NewModule('Broker', LibStub('LibDataBroker-1.1'):NewDataObject('Scrap', {
	type = 'data source', tocname = ...
}))

function Broker:OnEnable()
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
	self.icon = 'interface/addons/scrap/art/scrap-' .. (value > 0 and 'enabled' or 'disabled')
	self.text = GetMoneyString(value, true)
end

function Broker:OnClick(button)
	if Scrap.Merchant:IsVisible() or button == 'RightButton' then
		Scrap.Merchant.OnClick(Broker, button)
	else
		Scrap:DestroyCheapest()
	end
end

function Broker:OnTooltipShow()
	Broker:UpdateTip(self)
end
