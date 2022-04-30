
module("luci.controller.backup", package.seeall)

function index()
	entry({"admin", "system", "backup"}, cbi("backup"), _("在线升级"), 88).dependent=true
	
end


