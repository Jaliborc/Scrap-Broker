--[[
Copyright 2010-2019 João Cardoso
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

local L = Scrap_Locals
local Broker = Scrap:NewModule('Broker', LibStub('LibDataBroker-1.1'):NewDataObject('Scrap', {
	type = 'data source',
	tocname = ...,
}))


--[[ Events ]]--

function Broker:OnEnable()
	self:RegisterEvent('BAG_UPDATE', 'OnUpdate')
	self:RegisterSignal('LIST_CHANGED', 'OnUpdate')
end

function Broker:OnUpdate()
	local value = Scrap:GetJunkValue()
	self.icon = format('Interface/Addons/Scrap/art/%s-icon', value > 0 and 'enabled' or 'disabled')
	self.text = GetMoneyString(value, true)
end

function Broker:OnClick(button)
	if MerchantFrame:IsShown() or button ~= 'RightButton' then
		--Scrap.Merchant:OnClick(button, self)
	else
		Scrap:DestroyJunk()
	end
end

function Broker:OnReceiveDrag()
	--Scrap.Merchant:OnReceiveDrag()
end

function Broker:OnTooltipShow()
	--Scrap:ShowTooltip(self, not MerchantFrame:IsShown() and L.DeleteJunk or L.SellJunk)
end
