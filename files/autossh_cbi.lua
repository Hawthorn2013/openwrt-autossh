--[[
 Copyright (C) 2015 Jian Chang <aa65535@live.com>

 This is free software, licensed under the GNU General Public License v3.
 See /LICENSE for more information.
]]--

m = Map("autossh", translate("AutoSSH"),
	translate("Monitor and restart ssh sessions."))

s = m:section(TypedSection, "autossh", translate("AutoSSH Configuration"))
s.anonymous   = true
s.addremove   = true

o = s:option(Flag, "enabled", translate("Enable"))
o.default     = o.enabled
o.rmempty     = false

o = s:option(Value, "localport", translate("Local Port"))
o.placeholder = 22
o.datatype    = "port"
o.rmempty     = false

o = s:option(Value, "remoteport", translate("Remote Port"))
o.placeholder = 19999
o.datatype    = "port"
o.rmempty     = false

o = s:option(Value, "monitorport", translate("Monitoring Port"))
o.datatype    = "port"
o.rmempty     = false

o = s:option(Value, "monitorport", translate("Echo Port"))
o.datatype    = "port"

o = s:option(Value, "ssh", translate("SSH Options"))
o.rmempty     = false

o = s:option(Value, "AUTOSSH_FIRST_POLL", translate("AUTOSSH_FIRST_POLL"),
	translate("Specifies the time to wait before the first connection test. Thereafter the general poll time is used (see AUTOSSH_POLL below)."))
o.datatype    = "uinteger"

o = s:option(Value, "AUTOSSH_GATETIME", translate("AUTOSSH_GATETIME"),
	translate("Specifies how long ssh must be up before we consider it a successful connection. The default is 30 seconds. Note that if AUTOSSH_GATETIME is set to 0, then not only is the gatetime behaviour turned off, but autossh also ignores the first run failure of ssh. This may be useful when running autossh at boot."))
o.placeholder = 30
o.datatype    = "uinteger"

o = s:option(Value, "AUTOSSH_LOGLEVEL", translate("AUTOSSH_LOGLEVEL"),
	translate("Specifies the log level, corresponding to the levels used by syslog; so 0-7 with 7 being the chattiest."))
o.datatype    = "and(uinteger,max(7))"

o = s:option(Value, "AUTOSSH_LOGFILE", translate("AUTOSSH_LOGFILE"),
	translate("Specifies that autossh should use the named log file, rather than syslog."))

o = s:option(Value, "AUTOSSH_MAXLIFETIME", translate("AUTOSSH_MAXLIFETIME"),
	translate("Sets the maximum number of seconds that the program should run. Once the number of seconds has been passed, the ssh child will be killed and the program will exit."))

o = s:option(Value, "AUTOSSH_MAXSTART", translate("AUTOSSH_MAXSTART"),
	translate("Specifies how many times ssh should be started. A negative number means no limit on the number of times ssh is started. The default value is -1."))
o.placeholder = -1
o.datatype    = "integer"

o = s:option(Value, "AUTOSSH_MESSAGE", translate("AUTOSSH_MESSAGE"),
	translate("Append message to echo message sent when testing connections."))

o = s:option(Value, "AUTOSSH_PATH", translate("AUTOSSH_PATH"),
	translate("Specifies the path to the ssh executable, in case it is different than the path compiled in."))

o = s:option(Value, "AUTOSSH_PIDFILE", translate("AUTOSSH_PIDFILE"),
	translate("Write autossh pid to specified file."))

o = s:option(Value, "AUTOSSH_POLL", translate("AUTOSSH_POLL"),
	translate("Specifies the connection poll time in seconds; default is 600 seconds. If the poll time is less than twice the network timeouts (default 15 seconds) the network timeouts will be adjusted downward to 1/2 the poll time."))
o.placeholder = 600
o.datatype    = "uinteger"

o = s:option(Value, "AUTOSSH_PORT", translate("AUTOSSH_PORT"),
	translate("Sets the connection monitoring port. Mostly in case ssh appropriates -M at some time. But because of this possible use, AUTOSSH_PORT overrides the -M flag. A value of 0 turns the monitoring function off."))
o.datatype    = "port"

return m
