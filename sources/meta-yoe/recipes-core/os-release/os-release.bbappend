OS_RELEASE_FIELDS:append = " HOME_URL SUPPORT_URL BUG_REPORT_URL"
HOME_URL = "https://github.com/YoeDistro"
SUPPORT_URL = "https://github.com/YoeDistro/yoe-distro/issues"
BUG_REPORT_URL = "https://github.com/YoeDistro/yoe-distro/issues"

# IMG_VERSION is inserted from zonit environment setup script
#
VERSION_ID = "${@'${IMG_VERSION}' if '${IMG_VERSION}' else '0.0.0'}"
