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
	local out
	local s1
	local ret

	local log = os.tmpname()

	local eMMC = "/dev/mmcblk0"
	ret = file_exists("/dev/mmcblk0")

	if (ret == false) then
		return false, "Cannot fine eMMC"
	end

	cmdexec("/usr/sbin/sfdisk -d " .. eMMC .. "> /tmp/dumppartitions")

	-- check if there are two identical partitions
	-- and create the second one if no available
	f = io.input("/tmp/dumppartitions")
	fo = io.output("/tmp/partitions")
	t = f:read()
	found = false
	while (t ~= nil) do
		j=0
		j=string.find(t, "/dev/mmcblk0p3")
		fo:write(t .. "\n")
		if (j == 1) then
			found=true
			break
		end
		j=string.find(t, "/dev/mmcblk0p2")
		if (j == 1) then
			start, size = string.match(t, "%a+%s*=%s*(%d+), size=%s*(%d+)")
		end
		t = f:read()
	end

	if (found) then
		f:close()
		fo:close()
		return true, out
	end

	start=start+size
	partitions = eMMC .. "p3 : start=    " .. string.format("%d", start) .. ", size=  " .. size .. ", type=83\n"

	fo:write(partitions)
	fo:close()
	f:close()

	out = os.capture("/usr/sbin/sfdisk --force " .. eMMC .. " < /tmp/partitions")

	-- use partprobe to inform the kernel of the new partitions
	
	cmdexec("/usr/sbin/partprobe " .. eMMC)

	return true, out
end

function postinst()
	local out = "Post installed script called"

	return true, out
end
