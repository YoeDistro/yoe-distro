function postinst()
    local success = os.execute("/usr/bin/oe4t-set-uefi-OSIndications")
    local result = "oe4t-set-uefi-OSIndications completed with success: " .. tostring(success)
    return success, result
end
