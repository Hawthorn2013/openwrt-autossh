--[[
 Copyright (C) 2015 OpenWrt-dist
 Copyright (C) 2015 Jian Chang <aa65535@live.com>

 This is free software, licensed under the GNU General Public License v3.
 See /LICENSE for more information.
]]--

module("luci.controller.autossh", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/autossh") then
		return
	end

	entry({"admin", "services", "autossh"}, cbi("autossh/overview"), _("AutoSSH"), 60).dependent = true
	entry( {"admin", "services", "autossh", "detail"}, cbi("autossh/detail"), nil ).leaf = true
end

local function _get_status()
	local uci = UCI.cursor()
	local data = {}

	uci:foreach("autossh", "service", function (s)
		local section = s[".name"]
		local enabled = tonumber(s["enabled"]) or 0
		data[#data+1] = {
			section = section,
			enabled = enabled
		}
	end)

	uci:unload("autossh")
	return data
end

function status()
	local data = _get_status()
	HTTP.prepare_content("application/json")
	HTTP.write_json(data)
end
