local m, s, o
local NXFS = require "nixio.fs"
local SYS  = require "luci.sys"
local HTTP = require "luci.http"
local DISP = require "luci.dispatcher"
status = translate("<font color=\"green\">在线升级</font>")
m = Map("backup")
m.title	= translate("在线升级V1.0")
m.description = translate("本人菜鸟水平凑合着用吧<br /><font color=\"red\">可在日志查看进度</font>")
s = m:section(TypedSection, "backup")
s.anonymous = true
s:tab("backup",  translate("基本操作"))
o = s:taboption("backup", Button, "ck")
o.title = translate("------")
o.inputtitle = translate("点击下载固件")
o.description = translate("当/mnt/mmcblk0p3目录存在时检测更准，否则只有内核版本更新时才能检测到,可在日志查看进度")
o.inputstyle = "reload"
o.write = function()
        SYS.call("/usr/bin/ck > /tmp/up.log 2>&1 &")
        HTTP.redirect(DISP.build_url("admin", "system", "backup"))
end 
o = s:taboption("backup", Button, "up")
o.title = translate("------")
o.inputtitle = translate("点击在线升级")
o.description = translate("固件从github下载，速度慢的话需要开科学")
o.inputstyle = "reload"
o.write = function()
        SYS.call("/usr/bin/up > /tmp/up.log 2>&1 &")
        HTTP.redirect(DISP.build_url("admin", "system", "backup"))
end 
s:tab("log", translate("日志"))
local file = "/tmp/up.log"
o = s:taboption("log", TextValue, "log")
o.description = translate("日志")
o.rows = 13
o.wrap = "off"
o.cfgvalue = function(self, section)
	return NXFS.readfile(file) or ""
end
o.write = function(self, section, value)
	NXFS.writefile(file, value:gsub("\r\n", "\n"))
end  
return m
