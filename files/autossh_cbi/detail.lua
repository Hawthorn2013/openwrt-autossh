local DISP = require "luci.dispatcher"

local section = arg[1]

m = Map("autossh")
m.title = translate("AutoSSH")
m.description = translate("Monitor and restart ssh sessions.")

ns = m:section( NamedSection, section, "service",
	translate("Details for") .. ([[: <strong>%s</strong>]] % section))
ns.instance = section

ns:tab("basic", translate("Basic Settings"), nil )
ns:tab("advanced", translate("Advanced Settions"), nil )

en = ns:taboption("basic", Flag, "enabled",
	translate("Enabled"))

lp = ns:taboption("basic", Value, "localport",
	translate("Local Port"))
lp.datatype = "port"
lp.rmempty = false

rp = ns:taboption("basic", Value, "remoteport",
	translate("Remote Port"))
rp.datatype = "port"
rp.rmempty = false

mp = ns:taboption("basic", Value, "monitorport",
	translate("Monitoring Port"))
mp.datatype = "port"
mp.rmempty = false

ep = ns:taboption("basic", Value, "echo_port",
	translate("Echo Port"))
ep.datatype = "port"

so = ns:taboption("basic", Value, "ssh",
	translate("SSH Options"))
so.rmempty = false

afp = ns:taboption("advanced", Value, "AUTOSSH_FIRST_POLL", translate("AUTOSSH_FIRST_POLL"),
	translate("Specifies the time to wait before the first connection test. Thereafter the general poll time is used (see AUTOSSH_POLL below)."))
afp.datatype    = "uinteger"

ag = ns:taboption("advanced", Value, "AUTOSSH_GATETIME", translate("AUTOSSH_GATETIME"),
	translate("Specifies how long ssh must be up before we consider it a successful connection. The default is 30 seconds. Note that if AUTOSSH_GATETIME is set to 0, then not only is the gatetime behaviour turned off, but autossh also ignores the first run failure of ssh. This may be useful when running autossh at boot."))
ag.placeholder = 30
ag.datatype    = "uinteger"

all = ns:taboption("advanced", Value, "AUTOSSH_LOGLEVEL", translate("AUTOSSH_LOGLEVEL"),
	translate("Specifies the log level, corresponding to the levels used by syslog; so 0-7 with 7 being the chattiest."))
all.datatype    = "and(uinteger,max(7))"

alf = ns:taboption("advanced", Value, "AUTOSSH_LOGFILE", translate("AUTOSSH_LOGFILE"),
	translate("Specifies that autossh should use the named log file, rather than syslog."))

aml = ns:taboption("advanced", Value, "AUTOSSH_MAXLIFETIME", translate("AUTOSSH_MAXLIFETIME"),
	translate("Sets the maximum number of seconds that the program should run. Once the number of seconds has been passed, the ssh child will be killed and the program will exit."))

ams = ns:taboption("advanced", Value, "AUTOSSH_MAXSTART", translate("AUTOSSH_MAXSTART"),
	translate("Specifies how many times ssh should be started. A negative number means no limit on the number of times ssh is started. The default value is -1."))
ams.placeholder = -1
ams.datatype    = "integer"

ame = ns:taboption("advanced", Value, "AUTOSSH_MESSAGE", translate("AUTOSSH_MESSAGE"),
	translate("Append message to echo message sent when testing connections."))

apa = ns:taboption("advanced", Value, "AUTOSSH_PATH", translate("AUTOSSH_PATH"),
	translate("Specifies the path to the ssh executable, in case it is different than the path compiled in."))

apf = ns:taboption("advanced", Value, "AUTOSSH_PIDFILE", translate("AUTOSSH_PIDFILE"),
	translate("Write autossh pid to specified file."))

apol = ns:taboption("advanced", Value, "AUTOSSH_POLL", translate("AUTOSSH_POLL"),
	translate("Specifies the connection poll time in seconds; default is 600 seconds. If the poll time is less than twice the network timeouts (default 15 seconds) the network timeouts will be adjusted downward to 1/2 the poll time."))
apol.placeholder = 600
apol.datatype    = "uinteger"

apor = ns:taboption("advanced", Value, "AUTOSSH_PORT", translate("AUTOSSH_PORT"),
	translate("Sets the connection monitoring port. Mostly in case ssh appropriates -M at some time. But because of this possible use, AUTOSSH_PORT overrides the -M flag. A value of 0 turns the monitoring function off."))
apor.datatype    = "port"

return m