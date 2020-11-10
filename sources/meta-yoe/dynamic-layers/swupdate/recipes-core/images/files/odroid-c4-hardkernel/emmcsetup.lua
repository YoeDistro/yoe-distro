function os.capture(cmd)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	return s
end

function file_exists(name)
	local f=io.open(name,"r")
	if f~=nil then io.close(f) return true else return false end
end

function cmdexec(cmd)
	local ret, s, status = os.execute(cmd)
	if (status ~= 0) then
		return false, cmd .. " return with error"
	end

	return true,""
end

function preinst()
	local out = "Pre insaller script called"
	local s1
	local ret

	local log = os.tmpname()

	local eMMC = "/dev/mmcblk1"
	ret = file_exists("/dev/mmcblk1")

	if (ret == false) then
		return false, "Cannot fine eMMC"
	end


	return true, out
end

function postinst()
	local out = "Post installer script called"

	return true, out
end
