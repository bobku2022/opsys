module("luci.controller.wol", package.seeall)

function index()
	entry({"admin", "network", "wol"}, form("wol"), _("Wake on LAN"), 31)
	entry({"mini", "network", "wol"}, form("wol"), _("Wake on LAN"), 31)
end
