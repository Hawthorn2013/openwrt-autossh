local DISP = require "luci.dispatcher"
local HTTP = require "luci.http"

m = Map("autossh")
m.title = translate("AutoSSH")
m.description = translate("Monitor and restart ssh sessions.")

ts = m:section( TypedSection, "service", translate("Overview"),
	translate("Below is a list of configured AutoSSH configuration."))
ts.sectionhead = translate("Configuration")
ts.template = "cbi/tblsection"
ts.addremove = true
ts.extedit = DISP.build_url("admin", "services", "autossh", "detail", "%s")
function ts.create(self, name)
	AbstractSection.create(self, name)
	HTTP.redirect( self.extedit:format(name) )
end

ena = ts:option( Flag, "enabled", translate("Enabled"))
ena.rmempty = false

return m