#!/bin/bash

SCRIPT_VERSION="2.1.7"
DIR_REMNAWAVE="/usr/local/remnawave_reverse/"

COLOR_RESET="\033[0m"
COLOR_GREEN="\033[1;32m"
COLOR_YELLOW="\033[1;33m"
COLOR_WHITE="\033[1;37m"
COLOR_RED="\033[1;31m"
COLOR_GRAY='\033[0;90m'

# Language variables
declare -A LANG=(
    #Alias
    [ALIAS_ADDED]="Alias 'rr' for 'remnawave_reverse' added to %s"
    [ALIAS_ACTIVATE_GLOBAL]="Alias 'rr' is now available for all users. Run 'source %s' or open a new terminal to apply."
    #Lang
    [CHOOSE_LANG]="Select language:"
    [LANG_EN]="English"
    [LANG_RU]="Русский"
    #check
    [ERROR_ROOT]="Script must be run as root"
    [ERROR_OS]="Supported only Debian 11/12 and Ubuntu 22.04/24.04"
    #Install Packages
    [ERROR_UPDATE_LIST]="Failed to update package list"
    [ERROR_INSTALL_PACKAGES]="Failed to install required packages"
    [ERROR_INSTALL_CRON]="Failed to install cron"
    [ERROR_START_CRON]="Failed to start cron"
    [ERROR_CONFIGURE_LOCALES]="Error: Failed to configure locales"
    [ERROR_DOWNLOAD_DOCKER_KEY]="Failed to download Docker GPG key"
    [ERROR_UPDATE_DOCKER_LIST]="Failed to update package list after adding Docker repository"
    [ERROR_INSTALL_DOCKER]="Failed to install Docker"
    [ERROR_DOCKER_NOT_INSTALLED]="Docker is not installed"
    [ERROR_START_DOCKER]="Failed to start Docker"
    [ERROR_ENABLE_DOCKER]="Failed to enable Docker auto-start"
    [ERROR_DOCKER_NOT_WORKING]="Docker is not working properly"
    [ERROR_CONFIGURE_UFW]="Failed to configure UFW"
    [ERROR_CONFIGURE_UPGRADES]="Failed to configure unattended-upgrades"
    [ERROR_DOCKER_DNS]="Error: Unable to resolve download.docker.com. Check your DNS settings."
    [ERROR_INSTALL_CERTBOT]="Error: Failed to install certbot"
    [SUCCESS_INSTALL]="All packages installed successfully"
    #Menu
    [MENU_TITLE]="REMNAWAVE REVERSE-PROXY by eGames"
    [AVAILABLE_UPDATE]="update available"
    [VERSION_LABEL]="Version: %s"
    [EXIT]="Exit"
    [MENU_1]="Install Remnawave Components"
    [MENU_2]="Reinstall panel/node"
    [MENU_3]="Manage Panel/Node"
    [MENU_4]="Install random template for selfsteal node"
    [MENU_5]="Custom Templates by legiz"
    [MENU_6]="Extensions by distillium"
    [MENU_7]="Manage IPv6"
    [MENU_8]="Manage certificates domain"
    [MENU_9]="Check for updates script"
    [MENU_10]="Remove script"
    [PROMPT_ACTION]="Select action (0-10):"
    [INVALID_CHOICE]="Invalid choice. Please select 0-10"
    [WARNING_LABEL]="WARNING:"
    [CONFIRM_PROMPT]="Enter 'y' to continue or 'n' to exit (y/n):"
    [WARNING_NODE_PANEL]="Adding a node should only be done on the server where the panel is installed, not on the node server."
    [CONFIRM_SERVER_PANEL]="Are you sure you are on the server with the installed panel?"
    #Remove Script
    [REMOVE_SCRIPT_ONLY]="Remove script and its local files"
    [REMOVE_SCRIPT_AND_PANEL]="Remove script and remnawave panel/node data"
    [CONFIRM_REMOVE_SCRIPT]="All script data will be removed from the server. Are you sure? (y/n): "
    [CONFIRM_REMOVE_ALL]="All script and panel/node data will be removed from the server. Are you sure? (y/n): "
    [SCRIPT_REMOVED]="Script and its local files successfully removed!"
    [ALL_REMOVED]="Script and panel/node data successfully removed!"
    #Extensions by distillium
    [EXTENSIONS_MENU]="Extensions by distillium"
    [EXTENSIONS_MENU_TITLE]="Manage Extensions by distillium"
    [EXTENSIONS_PROMPT]="Select action (0-2):"
    [EXTENSIONS_INVALID_CHOICE]="Invalid choice. Please select 0-2."
    [BACKUP_RESTORE]="Backup and Restore"
    #Warp by distillium
    [WARP_MENU]="WARP Native"
    [WARP_MENU_TITLE]="Manage WARP Native"
    [WARP_INSTALL]="Install WARP Native"
    [WARP_ADD_CONFIG]="Add WARP-configuration to node configuration"
    [WARP_DELETE_WARP_SETTINGS]="Remove WARP-configuration from node configuration"
    [WARP_CONFIRM_SERVER_PANEL]="Are you sure you are on the server with the installed panel?\nAdding WARP-configuration should only be done on the server where the panel is installed, not on the node server"
    [WARP_UNINSTALL]="Uninstall WARP Native"
    [WARP_PROMPT]="Select action (0-4):"
    [WARP_PROMPT1]="Select action:"
    [WARP_INVALID_CHOICE]="Invalid choice. Please select 0-4."
    [WARP_INVALID_CHOICE2]="Invalid choice."
    [WARP_NO_NODE]="Node Remnawave not found. First install the node."
    [WARP_SELECT_CONFIG]="Select node to add WARP-configuration?"
    [WARP_SELECT_CONFIG_DELETE]="Select node to remove WARP-configuration?"
    [WARP_NO_CONFIGS]="No configurations found."
    [WARP_UPDATE_SUCCESS]="Configuration successfully updated!"
    [WARP_UPDATE_FAIL]="Failed to update configuration."
    [WARP_WARNING]="warp-out already exists in outbounds."
    [WARP_WARNING2]="warp rule already exists in routing rules."
    [WARP_REMOVED_WARP_SETTINGS1]="Removed warp-out from outbounds"
    [WARP_NO_WARP_SETTINGS1]="warp-out not found in outbounds"
    [WARP_REMOVED_WARP_SETTINGS2]="Removed warp rule from routing rules"
    [WARP_NO_WARP_SETTINGS2]="warp rule not found in routing rules"
    #Manage Panel/Node
    [START_PANEL_NODE]="Start panel/node"
    [STOP_PANEL_NODE]="Stop panel/node"
    [UPDATE_PANEL_NODE]="Update panel/node"
    [VIEW_LOGS]="View logs"
    [PRESS_ENTER_RETURN_MENU]="Press Enter to return to the menu..."
    [REMNAWAVE_CLI]="Remnawave CLI"
    [ACCESS_PANEL]="Access panel via port 8443 (Only for panel + node)"
    [MANAGE_PANEL_NODE_PROMPT]="Select action (0-6):"
    [MANAGE_PANEL_NODE_INVALID_CHOICE]="Invalid choice. Please select 0-6."
    #Manage Certificates
    [CERT_UPDATE]="Update current certificates"
    [CERT_GENERATE]="Generate new certificates for another domain"
    [CERT_PROMPT1]="Select action (0-2):"
    [CERT_INVALID_CHOICE]="Invalid choice. Please select 0-2."
    [CERT_UPDATE_CHECK]="Checking certificate generation method..."
    [CERT_UPDATE_SUCCESS]="Certificates successfully updated."
    [CERT_UPDATE_FAIL]="Failed to update certificates."
    [CERT_GENERATE_PROMPT]="Enter the domain for new certificates (e.g., example.com):"
    [CERT_METHOD_UNKNOWN]="Unknown certificate generation method."
    [CERT_NOT_DUE]="Certificate for %s is not yet due for renewal."
    #Install Remnawave Components
    [INSTALL_MENU_TITLE]="Install Remnawave Components"
    [INSTALL_PANEL_NODE]="Install panel and node on one server"
    [INSTALL_PANEL]="Install only the panel"
    [INSTALL_ADD_NODE]="Add node to panel"
    [INSTALL_NODE]="Install only the node"
    [INSTALL_PROMPT]="Select action (0-3):"
    [INSTALL_INVALID_CHOICE]="Invalid choice. Please select 0-3."
    #Manage IPv6
    [IPV6_MENU_TITLE]="Manage IPv6"
    [IPV6_ENABLE]="Enable IPv6"
    [IPV6_DISABLE]="Disable IPv6"
    [IPV6_PROMPT]="Select action (0-2):"
    [IPV6_INVALID_CHOICE]="Invalid choice. Please select 0-2."
    [IPV6_ALREADY_ENABLED]="IPv6 already enabled"
    [IPV6_ALREADY_DISABLED]="IPv6 already disabled"
    [ENABLE_IPV6]="Enabling IPv6..."
    [IPV6_ENABLED]="IPv6 has been enabled."
    [DISABLING_IPV6]="Disabling IPv6..."
    [IPV6_DISABLED]="IPv6 has been disabled."
    #Remna
    [INSTALL_PACKAGES]="Installing required packages..."
    [INSTALLING]="Installing panel and node"
    [INSTALLING_PANEL]="Installing panel"
    [INSTALLING_NODE]="Installing node"
    [ENTER_PANEL_DOMAIN]="Enter panel domain (e.g. panel.example.com):"
    [ENTER_SUB_DOMAIN]="Enter subscription domain (e.g. sub.example.com):"
    [ENTER_NODE_DOMAIN]="Enter selfsteal domain for node (e.g. node.example.com):"
    [ENTER_CF_TOKEN]="Enter your Cloudflare API token or global API key:"
    [ENTER_CF_EMAIL]="Enter your Cloudflare registered email:"
    [CHECK_CERTS]="Checking certificates..."
    [CERT_FOUND]="Certificates found in /etc/letsencrypt/live/"
    [CF_VALIDATING]="Cloudflare API key and email are valid"
    [CF_INVALID]="Invalid Cloudflare API token or email after %d attempts."
    [CF_INVALID_ATTEMPT]="Invalid Cloudflare API key or email. Attempt %d of %d."
    [WAITING]="Please wait..."
    #API
    [REGISTERING_REMNAWAVE]="Registration in Remnawave"
    [CHECK_CONTAINERS]="Checking containers availability..."
    [CONTAINERS_NOT_READY]="Containers are not ready, waiting..."
    [REGISTRATION_SUCCESS]="Registration completed successfully!"
    [GET_PUBLIC_KEY]="Getting public key..."
    [PUBLIC_KEY_SUCCESS]="Public key successfully obtained"
    [GENERATE_KEYS]="Generating x25519 keys..."
    [GENERATE_KEYS_SUCCESS]="Keys successfully generated"
    [ERROR_NO_CONFIGS]="No config profiles found"
    [NO_DEFAULT_PROFILE]="Default-Profile not found"
    [ERROR_DELETE_PROFILE]="Failed to delete profile"
    [CREATING_CONFIG_PROFILE]="Creating config profile..."
    [CONFIG_PROFILE_CREATED]="Config profile successfully created"
    [CREATING_NODE]="Creating node"
    [NODE_CREATED]="Node successfully created"
    [CREATE_HOST]="Creating host"
    [HOST_CREATED]="Host successfully created"
    [GET_DEFAULT_SQUAD]="Getting default squad"
    [UPDATE_SQUAD]="Squad successfully updated"
    [NO_SQUADS_FOUND]="No squads found"
    [INVALID_UUID_FORMAT]="Invalid UUID format"
    [NO_VALID_SQUADS_FOUND]="No valid squads found"
    [ERROR_GET_SQUAD]="Failed to get squad"
    [INVALID_SQUAD_UUID]="Invalid squad UUID"
    [INVALID_INBOUND_UUID]="Invalid inbound UUID"
    #Stop/Start/Update
    [CHANGE_DIR_FAILED]="Failed to change to directory %s"
    [DIR_NOT_FOUND]="Directory /opt/remnawave not found"
    [PANEL_RUNNING]="Panel/node already running"
    [PANEL_RUN]="Panel/node running"
    [PANEL_STOP]="Panel/node stopped"
    [PANEL_STOPPED]="Panel/node already stopped"
    [NO_UPDATE]="No updates available for panel/node"
    [UPDATING]="Updating panel/node..."
    [UPDATE_SUCCESS1]="Panel/node successfully updated"
    [STARTING_PANEL_NODE]="Starting panel and node"
    [STARTING_PANEL]="Starting panel"
    [STARTING_NODE]="Starting node"
    [STOPPING_REMNAWAVE]="Stopping panel and node"
    [IMAGES_DETECTED]="Images detected, restarting containers..."
    #Menu End
    [INSTALL_COMPLETE]="               INSTALLATION COMPLETE!"
    [PANEL_ACCESS]="Panel URL:"
    [ADMIN_CREDS]="To log into the panel, use the following data:"
    [USERNAME]="Username:"
    [PASSWORD]="Password:"
    [RELAUNCH_CMD]="To relaunch the manager, use the following command:"
    #RandomHTML
    [RANDOM_TEMPLATE]="Installing random template for camouflage site"
    [DOWNLOAD_FAIL]="Download failed, retrying..."
    [UNPACK_ERROR]="Error unpacking archive"
    [TEMPLATE_COPY]="Template copied to /var/www/html/"
    [SELECT_TEMPLATE]="Selected template:"
    #Error
    [ERROR_TOKEN]="Failed to get token."
    [ERROR_PUBLIC_KEY]="Failed to get public key."
    [ERROR_EXTRACT_PUBLIC_KEY]="Failed to extract public key from response."
    [ERROR_GENERATE_KEYS]="Failed to generate keys."
    [ERROR_EMPTY_RESPONSE_NODE]="Empty response from server when creating node."
    [ERROR_CREATE_NODE]="Failed to create node."
    [ERROR_EMPTY_RESPONSE_HOST]="Empty response from server when creating host."
    [ERROR_CREATE_HOST]="Failed to create host."
    [ERROR_EMPTY_RESPONSE_REGISTER]="Registration error - empty server response"
    [ERROR_REGISTER]="Registration error"
    [ERROR_UPDATE_SQUAD]="Failed to update squad"
    [ERROR_GET_SQUAD_LIST]="Failed to get squad list"
    [NO_SQUADS_TO_UPDATE]="No squads to update"
    #Reinstall Panel/Node
    [REINSTALL_WARNING]="All data panel/node will be deleted from the server. Are you sure? (y/n):"
    [REINSTALL_TYPE_TITLE]="Select reinstallation method:"
    [REINSTALL_PROMPT]="Select action (0-3):"
    [INVALID_REINSTALL_CHOICE]="Invalid choice. Please select 0-3."
    [POST_PANEL_MESSAGE]="Panel successfully installed!"
    [POST_PANEL_INSTRUCTION]="To install the node, follow these steps:\n1. Run this script on the server where the node will be installed.\n2. Select 'Install Remnawave Components', then 'Install only the node'."
    [SELFSTEAL_PROMPT]="Enter the selfsteal domain for the node (e.g. node.example.com):"
    [SELFSTEAL]="Enter the selfsteal domain for the node specified during panel installation:"
    [PANEL_IP_PROMPT]="Enter the IP address of the panel to establish a connection between the panel and the node:"
    [IP_ERROR]="Enter a valid IP address in the format X.X.X.X (e.g., 192.168.1.1)"
    [CERT_PROMPT]="Enter the certificate obtained from the panel, keeping the SSL_CERT= line (paste the content and press Enter twice):"
    [CERT_CONFIRM]="Are you sure the certificate is correct? (y/n):"
    [ABORT_MESSAGE]="Installation aborted by user"
    [SUCCESS_MESSAGE]="Node successfully connected"
    #Node Check
    [NODE_CHECK]="Checking node connection for %s..."
    [NODE_ATTEMPT]="Attempt %d of %d..."
    [NODE_UNAVAILABLE]="Node is unavailable on attempt %d."
    [NODE_LAUNCHED]="Node successfully launched!"
    [NODE_NOT_CONNECTED]="Node not connected after %d attempts!"
    [CHECK_CONFIG]="Check the configuration or restart the panel."
    #Add node to panel
    [ADD_NODE_TO_PANEL]="Adding node to panel"
    [ENTER_NODE_NAME]="Enter node name (e.g., Germany):"
    [USING_SAVED_TOKEN]="Using saved token..."
    [INVALID_SAVED_TOKEN]="Saved token is invalid. Requesting a new one..."
    [ENTER_PANEL_USERNAME]="Enter panel username: "
    [ENTER_PANEL_PASSWORD]="Enter panel password: "
    [TOKEN_RECEIVED_AND_SAVED]="Token successfully received and saved"
    [TOKEN_USED_SUCCESSFULLY]="Token successfully used"
    [NODE_ADDED_SUCCESS]="Node successfully added!"
    [CREATE_NEW_NODE]="Creating new node for %s..."
    [CF_INVALID_NAME]="Error: The name of the configuration profile %s is already in use.\nPlease choose another name."
    [CF_INVALID_LENGTH]="Error: The name of the configuration profile should contain from 3 to 20 characters."
    [CF_INVALID_CHARS]="Error: The name of the configuration profile should contain only English letters, numbers, and hyphens."
    #check
    [CHECK_UPDATE]="Check for updates"
    [GENERATING_CERTS]="Generating certificates for %s"
    [REQUIRED_DOMAINS]="Required domains for certificates:"
    [CHECK_DOMAIN_IP_FAIL]="Failed to determine the domain or server IP address."
    [CHECK_DOMAIN_IP_FAIL_INSTRUCTION]="Ensure that the domain %s is correctly configured and points to this server (%s)."
    [CHECK_DOMAIN_CLOUDFLARE]="The domain %s points to a Cloudflare IP (%s)."
    [CHECK_DOMAIN_CLOUDFLARE_INSTRUCTION]="Cloudflare proxying is not allowed for the selfsteal domain. Disable proxying (switch to 'DNS Only')."
    [CHECK_DOMAIN_MISMATCH]="The domain %s points to IP address %s, which differs from this server's IP (%s)."
    [CHECK_DOMAIN_MISMATCH_INSTRUCTION]="For proper operation, the domain must point to the current server."
    [NO_PANEL_NODE_INSTALLED]="Panel or node is not installed. Please install panel or node first."
    #update
    [UPDATE_AVAILABLE]="A new version of the script is available: %s (current version: %s)."
    [UPDATE_CONFIRM]="Update the script? (y/n):"
    [UPDATE_CANCELLED]="Update cancelled by user."
    [UPDATE_SUCCESS]="Script successfully updated to version %s!"
    [UPDATE_FAILED]="Error downloading the new version of the script."
    [VERSION_CHECK_FAILED]="Could not determine the version of the remote script. Skipping update."
    [LATEST_VERSION]="You already have the latest version of the script (%s)."
    [RESTART_REQUIRED]="Please restart the script to apply changes."
    [LOCAL_FILE_NOT_FOUND]="Local script file not found, downloading new version..."
    #CLI
    [RUNNING_CLI]="Running Remnawave CLI..."
    [CLI_SUCCESS]="Remnawave CLI executed successfully!"
    [CLI_FAILED]="Failed to execute Remnawave CLI. Ensure the 'remnawave' container is running."
    [CONTAINER_NOT_RUNNING]="Container 'remnawave' is not running. Please start it first."
    #Cert_choise
    [CERT_METHOD_PROMPT]="Select certificate generation method for all domains:"
    [CERT_METHOD_CF]="Cloudflare API (supports wildcard)"
    [CERT_METHOD_ACME]="ACME HTTP-01 (single domain, no wildcard)"
    [CERT_METHOD_CHOOSE]="Select option (0-2):"
    [EMAIL_PROMPT]="Enter your email for Let's Encrypt registration:"
    [CERTS_SKIPPED]="All certificates already exist. Skipping generation."
    [ACME_METHOD]="Using ACME (Let's Encrypt) with HTTP-01 challenge (no wildcard support)..."
    [CERT_GENERATION_FAILED]="Certificate generation failed. Please check your input and DNS settings."
    [ADDING_CRON_FOR_EXISTING_CERTS]="Adding cron job for certificate renewal..."
    [CRON_ALREADY_EXISTS]="Cron job for certificate renewal already exists."
    [CERT_NOT_FOUND]="Certificate not found for domain."
    [ERROR_PARSING_CERT]="Error parsing certificate expiry date."
    [CERT_EXPIRY_SOON]="Certificates will expire soon in"
    [DAYS]="days"
    [UPDATING_CRON]="Updating cron job to match certificate expiry."
    [GENERATING_WILDCARD_CERT]="Generating wildcard certificate for"
    [WILDCARD_CERT_FOUND]="Wildcard certificate found in /etc/letsencrypt/live/"
    [FOR_DOMAIN]="for"
    [START_CRON_ERROR]="Not able to start cron. Please start it manually."
    [DOMAINS_MUST_BE_UNIQUE]="Error: All domains (panel, subscription, and node) must be unique."
    [CHOOSE_TEMPLATE_SOURCE]="Select template source:"
    [SIMPLE_WEB_TEMPLATES]="Simple web templates"
    [SNI_TEMPLATES]="Sni templates"
    [CHOOSE_TEMPLATE_OPTION]="Select option (0-2):"
    [INVALID_TEMPLATE_CHOICE]="Invalid choice. Please select 0-2."
    # Manage Panel Access
    [PORT_8443_OPEN]="Open port 8443 for panel access"
    [PORT_8443_CLOSE]="Close port 8443 for panel access"
    [PORT_8443_IN_USE]="Port 8443 already in use by another process. Check which services are using the port and free it."
    [NO_PORT_CHECK_TOOLS]="Port checking tools (ss or netstat) not found. Install one of them."
    [OPEN_PANEL_LINK]="Your panel access link:"
    [PORT_8443_WARNING]="Don't forget, port 8443 is now open to the world. After fixing the panel, select the option to close port 8443."
    [PORT_8443_CLOSED]="Port 8443 has been closed."
    [NGINX_CONF_NOT_FOUND]="File nginx.conf not found in $dir"
    [NGINX_CONF_ERROR]="Failed to extract necessary parameters from nginx.conf"
    [NGINX_CONF_MODIFY_FAILED]="Failed to modify nginx.conf"
    [PORT_8443_ALREADY_CONFIGURED]="Port 8443 already configured in nginx.conf"
    [UFW_RELOAD_FAILED]="Failed to reload UFW."
    [PORT_8443_ALREADY_CLOSED]="Port 8443 already closed in UFW."
    #Legiz Extensions
    [LEGIZ_EXTENSIONS_PROMPT]="Select action (0-3):"
    # Sub Page Upload
    [UPLOADING_SUB_PAGE]="Uploading custom sub page template..."
    [ERROR_FETCH_SUB_PAGE]="Failed to fetch custom sub page template."
    [SUB_PAGE_UPDATED_SUCCESS]="Custom sub page template successfully updated."
    [SELECT_SUB_PAGE_CUSTOM]="Select action (0-7):"
    [SELECT_SUB_PAGE_CUSTOM1]="Custom Sub Page Templates"
    [SELECT_SUB_PAGE_CUSTOM2]="Custom Sub Page Templates\nOnly run on panel server"
    [SELECT_SUB_PAGE_CUSTOM3]="Custom App Lists for original sub page:"
    [SELECT_SUB_PAGE_CUSTOM4]="Custom Sub Page:"
    [SUB_PAGE_SELECT_CHOICE]="Invalid choice. Please select 0-7."
    [RESTORE_SUB_PAGE]="Restore default sub page"
    [CONTAINER_NOT_FOUND]="Container %s not found"
    [SUB_WITH_APPCONFIG_ASK]="Do you want to include app-config.json?"
    [SUB_WITH_APPCONFIG_OPTION1]="Yes, use config from option 1 (Simple custom app list)"
    [SUB_WITH_APPCONFIG_OPTION2]="Yes, use config from option 2 (Multiapp custom app list)"
    [SUB_WITH_APPCONFIG_OPTION3]="Yes, use config from option 3 (HWID only app list)"
    [SUB_WITH_APPCONFIG_SKIP]="No, skip app-config.json"
    [SUB_WITH_APPCONFIG_INVALID]="Invalid option, skipping app-config.json"
    [SUB_WITH_APPCONFIG_INPUT]="Select action (0-3):"
    # Custom Branding
    [BRANDING_SUPPORT_ASK]="Add branding support to subscription page?"
    [BRANDING_SUPPORT_YES]="Yes, add branding support"
    [BRANDING_SUPPORT_NO]="No, skip branding"
    [BRANDING_NAME_PROMPT]="Enter your brand name:"
    [BRANDING_SUPPORT_URL_PROMPT]="Enter your support page URL:"
    [BRANDING_LOGO_URL_PROMPT]="Enter your brand logo URL:"
    [BRANDING_ADDED_SUCCESS]="Branding configuration successfully added"
    [CUSTOM_APP_LIST_MENU]="Edit custom application list and branding"
    [CUSTOM_APP_LIST_NOT_FOUND]="Custom application list not found"
    [EDIT_BRANDING]="Edit branding"
    [EDIT_LOGO]="Change logo"
    [EDIT_NAME]="Change name in branding"
    [EDIT_SUPPORT_URL]="Change support link"
    [DELETE_APPS]="Delete specific applications"
    [BRANDING_CURRENT_VALUES]="Current branding values:"
    [BRANDING_LOGO_URL]="Logo URL:"
    [BRANDING_NAME]="Name:"
    [BRANDING_SUPPORT_URL]="Support URL:"
    [ENTER_NEW_LOGO]="Enter new logo URL:"
    [ENTER_NEW_NAME]="Enter new brand name:"
    [ENTER_NEW_SUPPORT]="Enter new support URL:"
    [CONFIRM_CHANGE]="Confirm change? (y/n):"
    [PLATFORM_SELECT]="Select platform:"
    [APP_SELECT]="Which application do you want to delete?"
    [CONFIRM_DELETE_APP]="Are you sure you want to delete application %s from platform %s? (y/n):"
    [APP_DELETED_SUCCESS]="Application successfully deleted"
    [NO_APPS_FOUND]="No applications found in this platform"
    # Template Upload
    [TEMPLATE_NOT_APPLIED]="Custom rules template not applied"
    [UPLOADING_TEMPLATE]="Uploading custom rules template..."
    [ERROR_FETCH_TEMPLATE]="Failed to fetch custom rules template."
    [ERROR_EMPTY_RESPONSE_TEMPLATE]="Empty response from API when updating template."
    [ERROR_UPDATE_TEMPLATE]="Failed to update custom rules template"
    [TEMPLATE_UPDATED_SUCCESS]="Custom rules template successfully updated."
    [SELECT_TEMPLATE_CUSTOM]="Select action (0-8):"
    [SELECT_TEMPLATE_CUSTOM1]="Custom Rules Templates"
    [SELECT_TEMPLATE_CUSTOM2]="Custom Rules Templates\nOnly run on panel server"
    [TEMPLATE_SELECT_CHOICE]="Invalid choice. Please select 0-8."
    [DOWNLOADING_CONFIG_SEED]="Downloading config.seed.ts from GitHub..."
    [EXTRACT_FAILED]="Failed to extract configuration for %s"
    [RESTORING_DEFAULT_TEMPLATES]="Restoring default custom rules templates from GitHub..."
    [DEFAULT_TEMPLATES_COMPLETED]="Default custom rules templates restoration completed"
    [RESTORING_TEMPLATE]="Restoring default custom rules template for %s..."
    [TEMPLATE_RESTORED_SUCCESS]="Default custom rules template for %s restored successfully"
    [URL_NOT_ACCESSIBLE]="URL %s is not accessible (HTTP status: %s)"
    [FAILED_TO_DOWNLOAD_TEMPLATE]="Failed to download custom rules template %s"
    [TEMPLATE_EMPTY]="Downloaded custom rules template %s is empty"
    [INVALID_YAML_TEMPLATE]="Invalid YAML custom rules template for %s"
    [INVALID_JSON_TEMPLATE]="Invalid JSON custom rules template for %s"
    [EMPTY_TEMPLATE_VALUE]="Empty custom rules template value for %s"
    [RESTORE_TEMPLATES]="Restore default custom rules templates"
    [FAILED_TO_EXTRACT_UUID]="Failed to extract UUID from subscription template"
    [RENEWAL_CONF_NOT_FOUND]="Renewal configuration file not found."
    [ARCHIVE_DIR_MISMATCH]="Archive directory mismatch in configuration."
    [CERT_VERSION_NOT_FOUND]="Failed to determine certificate version."
    [RESULTS_CERTIFICATE_UPDATES]="Results of certificate updates:"
    [CERTIFICATE_FOR]="Certificate for "
    [SUCCESSFULLY_UPDATED]="successfully updated"
    [FAILED_TO_UPDATE_CERTIFICATE_FOR]="Failed to update certificate for "
    [ERROR_CHECKING_EXPIRY_FOR]="Error checking expiry date for "
    [DOES_NOT_REQUIRE_UPDATE]="does not require updating ("
    [UPDATED]="Updated"
    [REMAINING]="Remaining"
    [ERROR_UPDATE]="Error updating"
    [ALREADY_EXPIRED]="already expired"
    [CERT_CLOUDFLARE_FILE_NOT_FOUND]="Cloudflare credentials file not found."
    [TELEGRAM_OAUTH_WARNING]="Telegram OAuth is enabled (TELEGRAM_OAUTH_ENABLED=true)."
    [CREATE_API_TOKEN_INSTRUCTION]="Go to the panel at: https://%s\nNavigate to 'API Tokens' -> 'Create New Token' and create a token.\nCopy the created token and enter it below."
    [ENTER_API_TOKEN]="Enter the API token: "
    [EMPTY_TOKEN_ERROR]="No token provided. Exiting."
    [RATE_LIMIT_EXCEEDED]="Rate limit exceeded for Let's Encrypt"
    [FAILED_TO_MODIFY_HTML_FILES]="Failed to modify HTML files"
    [INSTALLING_YQ]="Installing yq..."
    [ERROR_SETTING_YQ_PERMISSIONS]="Error setting yq permissions!"
    [YQ_SUCCESSFULLY_INSTALLED]="yq successfully installed!"
    [YQ_DOESNT_WORK_AFTER_INSTALLATION]="Error: yq doesn't work after installation!"
    [ERROR_DOWNLOADING_YQ]="Error downloading yq!"
    [FAST_START]="Quick start: remnawave_reverse"
)

question() {
    echo -e "${COLOR_GREEN}[?]${COLOR_RESET} ${COLOR_YELLOW}$*${COLOR_RESET}"
}

reading() {
    read -rp " $(question "$1")" "$2"
}

error() {
    echo -e "${COLOR_RED}$*${COLOR_RESET}"
    exit 1
}

check_os() {
    if ! grep -q "bullseye" /etc/os-release && ! grep -q "bookworm" /etc/os-release && ! grep -q "jammy" /etc/os-release && ! grep -q "noble" /etc/os-release && ! grep -q "trixie" /etc/os-release; then
        error "${LANG[ERROR_OS]}"
    fi
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        error "${LANG[ERROR_ROOT]}"
    fi
}

log_clear() {
  sed -i -e 's/\x1b\[[0-9;]*[a-zA-Z]//g' "$LOGFILE"
}

log_entry() {
  mkdir -p ${DIR_REMNAWAVE}
  LOGFILE="${DIR_REMNAWAVE}remnawave_reverse.log"
  exec > >(tee -a "$LOGFILE") 2>&1
}

generate_user() {
    local length=8
    tr -dc 'a-zA-Z' < /dev/urandom | fold -w $length | head -n 1
}

generate_password() {
    local length=24
    local password=""
    local upper_chars='A-Z'
    local lower_chars='a-z'
    local digit_chars='0-9'
    local special_chars='!@#%^&*()_+'
    local all_chars='A-Za-z0-9!@#%^&*()_+'

    password+=$(head /dev/urandom | tr -dc "$upper_chars" | head -c 1)
    password+=$(head /dev/urandom | tr -dc "$lower_chars" | head -c 1)
    password+=$(head /dev/urandom | tr -dc "$digit_chars" | head -c 1)
    password+=$(head /dev/urandom | tr -dc "$special_chars" | head -c 3)
    password+=$(head /dev/urandom | tr -dc "$all_chars" | head -c $(($length - 6)))

    password=$(echo "$password" | fold -w1 | shuf | tr -d '\n')

    echo "$password"
}

#Manage Install Remnawave Components
show_install_menu() {
    echo -e ""
    echo -e "${COLOR_GREEN}Select installation option:${COLOR_RESET}"
    echo -e ""
    echo -e "${COLOR_YELLOW}1. ${LANG[INSTALL_PANEL]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}2. ${LANG[INSTALL_NODE]}${COLOR_RESET}"
    echo -e ""
    echo -e "${COLOR_YELLOW}0. ${LANG[EXIT]}${COLOR_RESET}"
    echo -e ""
}

manage_install() {
    show_install_menu
    reading "${LANG[INSTALL_PROMPT]}" INSTALL_OPTION
    case $INSTALL_OPTION in
        1)
            if [ ! -f "${DIR_REMNAWAVE}install_packages" ] || ! command -v docker >/dev/null 2>&1 || ! docker info >/dev/null 2>&1 || ! command -v certbot >/dev/null 2>&1; then
                install_packages || {
                    echo -e "${COLOR_RED}${LANG[ERROR_INSTALL_DOCKER]}${COLOR_RESET}"
                    log_clear
                    exit 1
                }
            fi
            installation_panel
            sleep 2
            log_clear
            ;;
        2)
            if [ ! -f "${DIR_REMNAWAVE}install_packages" ] || ! command -v docker >/dev/null 2>&1 || ! docker info >/dev/null 2>&1 || ! command -v certbot >/dev/null 2>&1; then
                install_packages || {
                    echo -e "${COLOR_RED}${LANG[ERROR_INSTALL_DOCKER]}${COLOR_RESET}"
                    log_clear
                    exit 1
                }
            fi
            installation_node
            sleep 2
            log_clear
            ;;
        0)
            echo -e "${COLOR_YELLOW}${LANG[EXIT]}${COLOR_RESET}"
            exit 0
            ;;
        *)
            echo -e "${COLOR_YELLOW}${LANG[INSTALL_INVALID_CHOICE]}${COLOR_RESET}"
            sleep 2
            log_clear
            manage_install
            ;;
    esac
}
#Manage Install Remnawave Components

add_cron_rule() {
    local rule="$1"
    local logged_rule="${rule} >> ${DIR_REMNAWAVE}cron_jobs.log 2>&1"

    if ! crontab -u root -l > /dev/null 2>&1; then
        crontab -u root -l 2>/dev/null | crontab -u root -
    fi

    if ! crontab -u root -l | grep -Fxq "$logged_rule"; then
        (crontab -u root -l 2>/dev/null; echo "$logged_rule") | crontab -u root -
    fi
}

spinner() {
  local pid=$1
  local text=$2

  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8

  local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
  local text_code="$COLOR_GREEN"
  local bg_code=""
  local effect_code="\033[1m"
  local delay=0.1
  local reset_code="$COLOR_RESET"

  printf "${effect_code}${text_code}${bg_code}%s${reset_code}" "$text" > /dev/tty

  while kill -0 "$pid" 2>/dev/null; do
    for (( i=0; i<${#spinstr}; i++ )); do
      printf "\r${effect_code}${text_code}${bg_code}[%s] %s${reset_code}" "$(echo -n "${spinstr:$i:1}")" "$text" > /dev/tty
      sleep $delay
    done
  done

  printf "\r\033[K" > /dev/tty
}

install_packages() {
    echo -e "${COLOR_YELLOW}${LANG[INSTALL_PACKAGES]}${COLOR_RESET}"
    
    if ! apt-get update -y; then
        echo -e "${COLOR_RED}${LANG[ERROR_UPDATE_LIST]}${COLOR_RESET}" >&2
        return 1
    fi

    if ! apt-get install -y ca-certificates curl jq ufw wget gnupg unzip nano dialog git certbot python3-certbot-dns-cloudflare unattended-upgrades locales dnsutils coreutils grep gawk; then
        echo -e "${COLOR_RED}${LANG[ERROR_INSTALL_PACKAGES]}${COLOR_RESET}" >&2
        return 1
    fi

    if ! dpkg -l | grep -q '^ii.*cron '; then
        if ! apt-get install -y cron; then
            echo -e "${COLOR_RED}${LANG[ERROR_INSTALL_CRON]}" "${COLOR_RESET}" >&2
            return 1
        fi
    fi

    if ! systemctl is-active --quiet cron; then
        if ! systemctl start cron; then
            echo -e "${COLOR_RED}${LANG[START_CRON_ERROR]}${COLOR_RESET}" >&2
            return 1
        fi
    fi
    if ! systemctl is-enabled --quiet cron; then
        if ! systemctl enable cron; then
            echo -e "${COLOR_RED}${LANG[START_CRON_ERROR]}${COLOR_RESET}" >&2
            return 1
        fi
    fi

    if [ ! -f /etc/locale.gen ]; then
        echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
    fi
    if ! grep -q "^en_US.UTF-8 UTF-8" /etc/locale.gen; then
        if grep -q "^# en_US.UTF-8 UTF-8" /etc/locale.gen; then
            sed -i 's/^# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
        else
            echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
        fi
    fi
    if ! locale-gen || ! update-locale LANG=en_US.UTF-8; then
        echo -e "${COLOR_RED}${LANG[ERROR_CONFIGURE_LOCALES]}${COLOR_RESET}" >&2
        return 1
    fi

    if ! ping -c 1 download.docker.com >/dev/null 2>&1; then
        echo -e "${COLOR_RED}${LANG[ERROR_DOCKER_DNS]}${COLOR_RESET}" >&2
        return 1
    fi

    if grep -q "Ubuntu" /etc/os-release; then
        install -m 0755 -d /etc/apt/keyrings
        if ! curl -fsSL https://download.docker.com/linux/ubuntu/gpg | tee /etc/apt/keyrings/docker.asc > /dev/null; then
            echo -e "${COLOR_RED}${LANG[ERROR_DOWNLOAD_DOCKER_KEY]}${COLOR_RESET}" >&2
            return 1
        fi
        chmod a+r /etc/apt/keyrings/docker.asc
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    elif grep -q "Debian" /etc/os-release; then
        install -m 0755 -d /etc/apt/keyrings
        if ! curl -fsSL https://download.docker.com/linux/debian/gpg | tee /etc/apt/keyrings/docker.asc > /dev/null; then
            echo -e "${COLOR_RED}${LANG[ERROR_DOWNLOAD_DOCKER_KEY]}${COLOR_RESET}" >&2
            return 1
        fi
        chmod a+r /etc/apt/keyrings/docker.asc
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    fi

    if ! apt-get update; then
        echo -e "${COLOR_RED}${LANG[ERROR_UPDATE_DOCKER_LIST]}${COLOR_RESET}" >&2
        return 1
    fi

    if ! apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin; then
        echo -e "${COLOR_RED}${LANG[ERROR_INSTALL_DOCKER]}${COLOR_RESET}" >&2
        return 1
    fi

    if ! command -v docker >/dev/null 2>&1; then
        echo -e "${COLOR_RED}${LANG[ERROR_DOCKER_NOT_INSTALLED]}${COLOR_RESET}" >&2
        return 1
    fi

    if ! systemctl is-active --quiet docker; then
        if ! systemctl start docker; then
            echo -e "${COLOR_RED}${LANG[ERROR_START_DOCKER]}${COLOR_RESET}" >&2
            return 1
        fi
    fi

    if ! systemctl is-enabled --quiet docker; then
        if ! systemctl enable docker; then
            echo -e "${COLOR_RED}${LANG[ERROR_ENABLE_DOCKER]}${COLOR_RESET}" >&2
            return 1
        fi
    fi

    if ! docker info >/dev/null 2>&1; then
        echo -e "${COLOR_RED}${LANG[ERROR_DOCKER_NOT_WORKING]}${COLOR_RESET}" >&2
        return 1
    fi

    # BBR
    if ! grep -q "net.core.default_qdisc = fq" /etc/sysctl.conf; then
        echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf
    fi
    if ! grep -q "net.ipv4.tcp_congestion_control = bbr" /etc/sysctl.conf; then
        echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf
    fi
    sysctl -p >/dev/null

    # UFW
    if ! ufw allow 22/tcp comment 'SSH' || ! ufw allow 443/tcp comment 'HTTPS' || ! ufw --force enable; then
        echo -e "${COLOR_RED}${LANG[ERROR_CONFIGURE_UFW]}${COLOR_RESET}" >&2
        return 1
    fi

    # Unattended-upgrades
    echo 'Unattended-Upgrade::Mail "root";' >> /etc/apt/apt.conf.d/50unattended-upgrades
    echo unattended-upgrades unattended-upgrades/enable_auto_updates boolean true | debconf-set-selections
    if ! dpkg-reconfigure -f noninteractive unattended-upgrades || ! systemctl restart unattended-upgrades; then
        echo -e "${COLOR_RED}${LANG[ERROR_CONFIGURE_UPGRADES]}" "${COLOR_RESET}" >&2
        return 1
    fi

    touch ${DIR_REMNAWAVE}install_packages
    echo -e "${COLOR_GREEN}${LANG[SUCCESS_INSTALL]}${COLOR_RESET}"
    clear
}

extract_domain() {
    local SUBDOMAIN=$1
    echo "$SUBDOMAIN" | awk -F'.' '{if (NF > 2) {print $(NF-1)"."$NF} else {print $0}}'
}

check_domain() {
    local domain="$1"
    local show_warning="${2:-true}"
    local allow_cf_proxy="${3:-true}"

    local domain_ip=$(dig +short A "$domain" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' | head -n 1)
    local server_ip=$(curl -s -4 ifconfig.me || curl -s -4 api.ipify.org || curl -s -4 ipinfo.io/ip)

    if [ -z "$domain_ip" ] || [ -z "$server_ip" ]; then
        if [ "$show_warning" = true ]; then
            echo -e "${COLOR_YELLOW}${LANG[WARNING_LABEL]}${COLOR_RESET}"
            echo -e "${COLOR_RED}${LANG[CHECK_DOMAIN_IP_FAIL]}${COLOR_RESET}"
            printf "${COLOR_YELLOW}${LANG[CHECK_DOMAIN_IP_FAIL_INSTRUCTION]}${COLOR_RESET}\n" "$domain" "$server_ip"
            reading "${LANG[CONFIRM_PROMPT]}" confirm
            if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
                return 2
            fi
        fi
        return 1
    fi

    local cf_ranges=$(curl -s https://www.cloudflare.com/ips-v4)
    local cf_array=()
    if [ -n "$cf_ranges" ]; then
        IFS=$'\n' read -r -d '' -a cf_array <<<"$cf_ranges"
    fi

    local ip_in_cloudflare=false
    local IFS='.'
    read -r a b c d <<<"$domain_ip"
    local domain_ip_int=$(( (a << 24) + (b << 16) + (c << 8) + d ))

    if [ ${#cf_array[@]} -gt 0 ]; then
        for cidr in "${cf_array[@]}"; do
            if [[ -z "$cidr" ]]; then
                continue
            fi
            local network=$(echo "$cidr" | cut -d'/' -f1)
            local mask=$(echo "$cidr" | cut -d'/' -f2)
            read -r a b c d <<<"$network"
            local network_int=$(( (a << 24) + (b << 16) + (c << 8) + d ))
            local mask_bits=$(( 32 - mask ))
            local range_size=$(( 1 << mask_bits ))
            local min_ip_int=$network_int
            local max_ip_int=$(( network_int + range_size - 1 ))

            if [ "$domain_ip_int" -ge "$min_ip_int" ] && [ "$domain_ip_int" -le "$max_ip_int" ]; then
                ip_in_cloudflare=true
                break
            fi
        done
    fi

    if [ "$domain_ip" = "$server_ip" ]; then
        return 0
    elif [ "$ip_in_cloudflare" = true ]; then
        if [ "$allow_cf_proxy" = true ]; then
            return 0
        else
            if [ "$show_warning" = true ]; then
                echo -e "${COLOR_YELLOW}${LANG[WARNING_LABEL]}${COLOR_RESET}"
                printf "${COLOR_RED}${LANG[CHECK_DOMAIN_CLOUDFLARE]}${COLOR_RESET}\n" "$domain" "$domain_ip"
                echo -e "${COLOR_YELLOW}${LANG[CHECK_DOMAIN_CLOUDFLARE_INSTRUCTION]}${COLOR_RESET}"
                reading "${LANG[CONFIRM_PROMPT]}" confirm
                if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                    return 1
                else
                    return 2
                fi
            fi
            return 1
        fi
    else
        if [ "$show_warning" = true ]; then
            echo -e "${COLOR_YELLOW}${LANG[WARNING_LABEL]}${COLOR_RESET}"
            printf "${COLOR_RED}${LANG[CHECK_DOMAIN_MISMATCH]}${COLOR_RESET}\n" "$domain" "$domain_ip" "$server_ip"
            echo -e "${COLOR_YELLOW}${LANG[CHECK_DOMAIN_MISMATCH_INSTRUCTION]}${COLOR_RESET}"
            reading "${LANG[CONFIRM_PROMPT]}" confirm
            if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
                return 1
            else
                return 2
            fi
        fi
        return 1
    fi

    return 0
}

is_wildcard_cert() {
    local domain=$1
    local cert_path="/etc/letsencrypt/live/$domain/fullchain.pem"

    if [ ! -f "$cert_path" ]; then
        return 1
    fi

    if openssl x509 -noout -text -in "$cert_path" | grep -q "\*\.$domain"; then
        return 0
    else
        return 1
    fi
}

check_certificates() {
    local DOMAIN=$1
    local cert_dir="/etc/letsencrypt/live"

    if [ ! -d "$cert_dir" ]; then
        echo -e "${COLOR_RED}${LANG[CERT_NOT_FOUND]} $DOMAIN${COLOR_RESET}"
        return 1
    fi

    local live_dir=$(find "$cert_dir" -maxdepth 1 -type d -name "${DOMAIN}*" 2>/dev/null | sort -V | tail -n 1)
    if [ -n "$live_dir" ] && [ -d "$live_dir" ]; then
        local files=("cert.pem" "chain.pem" "fullchain.pem" "privkey.pem")
        for file in "${files[@]}"; do
            local file_path="$live_dir/$file"
            if [ ! -f "$file_path" ]; then
                echo -e "${COLOR_RED}${LANG[CERT_NOT_FOUND]} $DOMAIN (missing $file)${COLOR_RESET}"
                return 1
            fi
            if [ ! -L "$file_path" ]; then
                fix_letsencrypt_structure "$(basename "$live_dir")"
                if [ $? -ne 0 ]; then
                    echo -e "${COLOR_RED}${LANG[CERT_NOT_FOUND]} $DOMAIN (failed to fix structure)${COLOR_RESET}"
                    return 1
                fi
            fi
        done
        echo -e "${COLOR_GREEN}${LANG[CERT_FOUND]}$(basename "$live_dir")${COLOR_RESET}"
        return 0
    fi

    local base_domain=$(extract_domain "$DOMAIN")
    if [ "$base_domain" != "$DOMAIN" ]; then
        live_dir=$(find "$cert_dir" -maxdepth 1 -type d -name "${base_domain}*" 2>/dev/null | sort -V | tail -n 1)
        if [ -n "$live_dir" ] && [ -d "$live_dir" ] && is_wildcard_cert "$base_domain"; then
            echo -e "${COLOR_GREEN}${LANG[WILDCARD_CERT_FOUND]}$base_domain ${LANG[FOR_DOMAIN]} $DOMAIN${COLOR_RESET}"
            return 0
        fi
    fi

    echo -e "${COLOR_RED}${LANG[CERT_NOT_FOUND]} $DOMAIN${COLOR_RESET}"
    return 1
}

check_api() {
    local attempts=3
    local attempt=1

    while [ $attempt -le $attempts ]; do
        if [[ $CLOUDFLARE_API_KEY =~ [A-Z] ]]; then
            api_response=$(curl --silent --request GET --url https://api.cloudflare.com/client/v4/zones --header "Authorization: Bearer ${CLOUDFLARE_API_KEY}" --header "Content-Type: application/json")
        else
            api_response=$(curl --silent --request GET --url https://api.cloudflare.com/client/v4/zones --header "X-Auth-Key: ${CLOUDFLARE_API_KEY}" --header "X-Auth-Email: ${CLOUDFLARE_EMAIL}" --header "Content-Type: application/json")
        fi

        if echo "$api_response" | grep -q '"success":true'; then
            echo -e "${COLOR_GREEN}${LANG[CF_VALIDATING]}${COLOR_RESET}"
            return 0
        else
            echo -e "${COLOR_RED}$(printf "${LANG[CF_INVALID_ATTEMPT]}" "$attempt" "$attempts")${COLOR_RESET}"
            if [ $attempt -lt $attempts ]; then
                reading "${LANG[ENTER_CF_TOKEN]}" CLOUDFLARE_API_KEY
                reading "${LANG[ENTER_CF_EMAIL]}" CLOUDFLARE_EMAIL
            fi
            attempt=$((attempt + 1))
        fi
    done
    error "$(printf "${LANG[CF_INVALID]}" "$attempts")"
}

get_certificates() {
    local DOMAIN=$1
    local CERT_METHOD=$2
    local LETSENCRYPT_EMAIL=$3
    local BASE_DOMAIN=$(extract_domain "$DOMAIN")
    local WILDCARD_DOMAIN="*.$BASE_DOMAIN"

    printf "${COLOR_YELLOW}${LANG[GENERATING_CERTS]}${COLOR_RESET}\n" "$DOMAIN"

    case $CERT_METHOD in
        1)
            # Cloudflare API (DNS-01 support wildcard)
            reading "${LANG[ENTER_CF_TOKEN]}" CLOUDFLARE_API_KEY
            reading "${LANG[ENTER_CF_EMAIL]}" CLOUDFLARE_EMAIL

            check_api

            mkdir -p ~/.secrets/certbot
            if [[ $CLOUDFLARE_API_KEY =~ [A-Z] ]]; then
                cat > ~/.secrets/certbot/cloudflare.ini <<EOL
dns_cloudflare_api_token = $CLOUDFLARE_API_KEY
EOL
            else
                cat > ~/.secrets/certbot/cloudflare.ini <<EOL
dns_cloudflare_email = $CLOUDFLARE_EMAIL
dns_cloudflare_api_key = $CLOUDFLARE_API_KEY
EOL
            fi
            chmod 600 ~/.secrets/certbot/cloudflare.ini

            certbot certonly \
                --dns-cloudflare \
                --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini \
                --dns-cloudflare-propagation-seconds 60 \
                -d "$BASE_DOMAIN" \
                -d "$WILDCARD_DOMAIN" \
                --email "$CLOUDFLARE_EMAIL" \
                --agree-tos \
                --non-interactive \
                --key-type ecdsa \
                --elliptic-curve secp384r1
            ;;
        2)
            # ACME HTTP-01 (without wildcard)
            ufw allow 80/tcp comment 'HTTP for ACME challenge' > /dev/null 2>&1

            certbot certonly \
                --standalone \
                -d "$DOMAIN" \
                --email "$LETSENCRYPT_EMAIL" \
                --agree-tos \
                --non-interactive \
                --http-01-port 80 \
                --key-type ecdsa \
                --elliptic-curve secp384r1

            ufw delete allow 80/tcp > /dev/null 2>&1
            ufw reload > /dev/null 2>&1
            ;;
        *)
            echo -e "${COLOR_RED}${LANG[INVALID_CERT_METHOD]}${COLOR_RESET}"
            exit 1
            ;;
    esac

    if [ ! -d "/etc/letsencrypt/live/$DOMAIN" ]; then
        echo -e "${COLOR_RED}${LANG[CERT_GENERATION_FAILED]} $DOMAIN${COLOR_RESET}"
        exit 1
    fi
}

check_cert_expiry() {
    local domain="$1"
    local cert_dir="/etc/letsencrypt/live"
    local live_dir=$(find "$cert_dir" -maxdepth 1 -type d -name "${domain}*" | sort -V | tail -n 1)
    if [ -z "$live_dir" ] || [ ! -d "$live_dir" ]; then
        return 1
    fi
    local cert_file="$live_dir/fullchain.pem"
    if [ ! -f "$cert_file" ]; then
        return 1
    fi
    local expiry_date=$(openssl x509 -in "$cert_file" -noout -enddate | sed 's/notAfter=//')
    if [ -z "$expiry_date" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_PARSING_CERT]}${COLOR_RESET}"
        return 1
    fi
    local expiry_epoch=$(TZ=UTC date -d "$expiry_date" +%s 2>/dev/null)
    if [ $? -ne 0 ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_PARSING_CERT]}${COLOR_RESET}"
        return 1
    fi
    local current_epoch=$(date +%s)
    local days_left=$(( (expiry_epoch - current_epoch) / 86400 ))
    echo "$days_left"
    return 0
}

fix_letsencrypt_structure() {
    local domain=$1
    local live_dir="/etc/letsencrypt/live/$domain"
    local archive_dir="/etc/letsencrypt/archive/$domain"
    local renewal_conf="/etc/letsencrypt/renewal/$domain.conf"

    if [ ! -d "$live_dir" ]; then
        echo -e "${COLOR_RED}${LANG[CERT_NOT_FOUND]}${COLOR_RESET}"
        return 1
    fi
    if [ ! -d "$archive_dir" ]; then
        echo -e "${COLOR_RED}${LANG[ARCHIVE_NOT_FOUND]}${COLOR_RESET}"
        return 1
    fi
    if [ ! -f "$renewal_conf" ]; then
        echo -e "${COLOR_RED}${LANG[RENEWAL_CONF_NOT_FOUND]}${COLOR_RESET}"
        return 1
    fi

    local conf_archive_dir=$(grep "^archive_dir" "$renewal_conf" | cut -d'=' -f2 | tr -d ' ')
    if [ "$conf_archive_dir" != "$archive_dir" ]; then
        echo -e "${COLOR_RED}${LANG[ARCHIVE_DIR_MISMATCH]}${COLOR_RESET}"
        return 1
    fi

    local latest_version=$(ls -1 "$archive_dir" | grep -E 'cert[0-9]+.pem' | sort -V | tail -n 1 | sed -E 's/.*cert([0-9]+)\.pem/\1/')
    if [ -z "$latest_version" ]; then
        echo -e "${COLOR_RED}${LANG[CERT_VERSION_NOT_FOUND]}${COLOR_RESET}"
        return 1
    fi

    local files=("cert" "chain" "fullchain" "privkey")
    for file in "${files[@]}"; do
        local archive_file="$archive_dir/$file$latest_version.pem"
        local live_file="$live_dir/$file.pem"
        if [ ! -f "$archive_file" ]; then
            echo -e "${COLOR_RED}${LANG[FILE_NOT_FOUND]} $archive_file${COLOR_RESET}"
            return 1
        fi
        if [ -f "$live_file" ] && [ ! -L "$live_file" ]; then
            rm "$live_file"
        fi
        ln -sf "$archive_file" "$live_file"
    done

    local cert_path="$live_dir/cert.pem"
    local chain_path="$live_dir/chain.pem"
    local fullchain_path="$live_dir/fullchain.pem"
    local privkey_path="$live_dir/privkey.pem"
    if ! grep -q "^cert = $cert_path" "$renewal_conf"; then
        sed -i "s|^cert =.*|cert = $cert_path|" "$renewal_conf"
    fi
    if ! grep -q "^chain = $chain_path" "$renewal_conf"; then
        sed -i "s|^chain =.*|chain = $chain_path|" "$renewal_conf"
    fi
    if ! grep -q "^fullchain = $fullchain_path" "$renewal_conf"; then
        sed -i "s|^fullchain =.*|fullchain = $fullchain_path|" "$renewal_conf"
    fi
    if ! grep -q "^privkey = $privkey_path" "$renewal_conf"; then
        sed -i "s|^privkey =.*|privkey = $privkey_path|" "$renewal_conf"
    fi

    local expected_hook="renew_hook = sh -c 'cd /opt/remnawave && docker compose down remnawave-nginx && docker compose up -d remnawave-nginx && docker compose exec remnawave-nginx nginx -s reload'"
    sed -i '/^renew_hook/d' "$renewal_conf"
    echo "$expected_hook" >> "$renewal_conf"

    chmod 644 "$live_dir/cert.pem" "$live_dir/chain.pem" "$live_dir/fullchain.pem"
    chmod 600 "$live_dir/privkey.pem"
    return 0
}
#Manage Certificates

### API Functions ###
make_api_request() {
    local method=$1
    local url=$2
    local token=$3
    local data=$4

    local headers=(
        -H "Authorization: Bearer $token"
        -H "Content-Type: application/json"
        -H "X-Forwarded-For: ${url#http://}"
        -H "X-Forwarded-Proto: https"
        -H "X-Remnawave-Client-Type: browser"
    )

    if [ -n "$data" ]; then
        curl -s -X "$method" "$url" "${headers[@]}" -d "$data"
    else
        curl -s -X "$method" "$url" "${headers[@]}"
    fi
}


register_remnawave() {
    local domain_url=$1
    local username=$2
    local password=$3
    local token=$4

    local register_data='{"username":"'"$username"'","password":"'"$password"'"}'
    local register_response=$(make_api_request "POST" "http://$domain_url/api/auth/register" "$token" "$register_data")

    if [ -z "$register_response" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EMPTY_RESPONSE_REGISTER]}${COLOR_RESET}"
    elif [[ "$register_response" == *"accessToken"* ]]; then
        echo "$register_response" | jq -r '.response.accessToken'
    else
        echo -e "${COLOR_RED}${LANG[ERROR_REGISTER]}: $register_response${COLOR_RESET}"
    fi
}

get_panel_token() {
    TOKEN_FILE="${DIR_REMNAWAVE}/token"
    ENV_FILE="/opt/remnawave/.env"
    local domain_url="127.0.0.1:3000"
    
    local oauth_enabled=false
    if [ -f "$ENV_FILE" ]; then
        if grep -q "^TELEGRAM_OAUTH_ENABLED=true" "$ENV_FILE" || \
           grep -q "^OAUTH2_GITHUB_ENABLED=true" "$ENV_FILE" || \
           grep -q "^OAUTH2_POCKETID_ENABLED=true" "$ENV_FILE" || \
           grep -q "^OAUTH2_YANDEX_ENABLED=true" "$ENV_FILE"; then
            oauth_enabled=true
        fi
    fi
    
    if [ -f "$TOKEN_FILE" ]; then
        token=$(cat "$TOKEN_FILE")
        echo -e "${COLOR_YELLOW}${LANG[USING_SAVED_TOKEN]}${COLOR_RESET}"
        local test_response=$(make_api_request "GET" "${domain_url}/api/config-profiles" "$token")
        
        if [ -z "$test_response" ] || ! echo "$test_response" | jq -e '.response.configProfiles' > /dev/null 2>&1; then
            if echo "$test_response" | grep -q '"statusCode":401' || \
               echo "$test_response" | jq -e '.message | test("Unauthorized")' > /dev/null 2>&1; then
                echo -e "${COLOR_RED}${LANG[INVALID_SAVED_TOKEN]}${COLOR_RESET}"
            else
                echo -e "${COLOR_RED}${LANG[INVALID_SAVED_TOKEN]}: $test_response${COLOR_RESET}"
            fi
            token=""
        fi
    fi
    
    if [ -z "$token" ]; then
        if [ "$oauth_enabled" = true ]; then
            echo -e "${COLOR_YELLOW}=================================================${COLOR_RESET}"
            echo -e "${COLOR_RED}${LANG[WARNING_LABEL]}${COLOR_RESET}"
            echo -e "${COLOR_YELLOW}${LANG[TELEGRAM_OAUTH_WARNING]}${COLOR_RESET}"
            printf "${COLOR_YELLOW}${LANG[CREATE_API_TOKEN_INSTRUCTION]}${COLOR_RESET}\n" "$PANEL_DOMAIN"
            reading "${LANG[ENTER_API_TOKEN]}" token
            if [ -z "$token" ]; then
                echo -e "${COLOR_RED}${LANG[EMPTY_TOKEN_ERROR]}${COLOR_RESET}"
                return 1
            fi
            
            local test_response=$(make_api_request "GET" "${domain_url}/api/config-profiles" "$token")
            if [ -z "$test_response" ] || ! echo "$test_response" | jq -e '.response.configProfiles' > /dev/null 2>&1; then
                echo -e "${COLOR_RED}${LANG[INVALID_SAVED_TOKEN]}: $test_response${COLOR_RESET}"
                return 1
            fi
        else
            reading "${LANG[ENTER_PANEL_USERNAME]}" username
            reading "${LANG[ENTER_PANEL_PASSWORD]}" password
            
            local login_response=$(make_api_request "POST" "${domain_url}/api/auth/login" "" "{\"username\":\"$username\",\"password\":\"$password\"}")
            token=$(echo "$login_response" | jq -r '.response.accessToken // .accessToken // ""')
            if [ -z "$token" ] || [ "$token" == "null" ]; then
                echo -e "${COLOR_RED}${LANG[ERROR_TOKEN]}: $login_response${COLOR_RESET}"
                return 1
            fi
        fi
        
        echo "$token" > "$TOKEN_FILE"
        echo -e "${COLOR_GREEN}${LANG[TOKEN_RECEIVED_AND_SAVED]}${COLOR_RESET}"
    else
        echo -e "${COLOR_GREEN}${LANG[TOKEN_USED_SUCCESSFULLY]}${COLOR_RESET}"
    fi
    
    local final_test_response=$(make_api_request "GET" "${domain_url}/api/config-profiles" "$token")
    if [ -z "$final_test_response" ] || ! echo "$final_test_response" | jq -e '.response.configProfiles' > /dev/null 2>&1; then
        echo -e "${COLOR_RED}${LANG[INVALID_SAVED_TOKEN]}: $final_test_response${COLOR_RESET}"
        return 1
    fi
}

get_public_key() {
    local domain_url=$1
    local token=$2
    local target_dir=$3

    local api_response=$(make_api_request "GET" "http://$domain_url/api/keygen" "$token")

    if [ -z "$api_response" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_PUBLIC_KEY]}${COLOR_RESET}"
    fi

    local pubkey=$(echo "$api_response" | jq -r '.response.pubKey')
    if [ -z "$pubkey" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EXTRACT_PUBLIC_KEY]}${COLOR_RESET}"
    fi

    local env_node_file="$target_dir/.env-node"
    cat > "$env_node_file" <<EOL
### APP ###
APP_PORT=2222

### XRAY ###
SSL_CERT="$pubkey"
EOL
    echo -e "${COLOR_YELLOW}${LANG[PUBLIC_KEY_SUCCESS]}${COLOR_RESET}"
    echo "$pubkey"
}

generate_xray_keys() {
    local domain_url=$1
    local token=$2

    local api_response=$(make_api_request "GET" "http://$domain_url/api/system/tools/x25519/generate" "$token")

    if [ -z "$api_response" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_GENERATE_KEYS]}${COLOR_RESET}"
        return 1
    fi

    if echo "$api_response" | jq -e '.errorCode' > /dev/null 2>&1; then
        local error_message=$(echo "$api_response" | jq -r '.message')
        echo -e "${COLOR_RED}${LANG[ERROR_GENERATE_KEYS]}: $error_message${COLOR_RESET}"
    fi

    local private_key=$(echo "$api_response" | jq -r '.response.keypairs[0].privateKey')

    if [ -z "$private_key" ] || [ "$private_key" = "null" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EXTRACT_PRIVATE_KEY]}${COLOR_RESET}"
    fi

    echo "$private_key"
}

create_node() {
    local domain_url=$1
    local token=$2
    local config_profile_uuid=$3
    local inbound_uuid=$4
    local node_address="${5:-172.30.0.1}"
    local node_name="${6:-Steal}"

    local node_data=$(cat <<EOF
{
    "name": "$node_name",
    "address": "$node_address",
    "port": 2222,
    "configProfile": {
        "activeConfigProfileUuid": "$config_profile_uuid",
        "activeInbounds": ["$inbound_uuid"]
    },
    "isTrafficTrackingActive": false,
    "trafficLimitBytes": 0,
    "notifyPercent": 0,
    "trafficResetDay": 31,
    "excludedInbounds": [],
    "countryCode": "XX",
    "consumptionMultiplier": 1.0
}
EOF
)

    local node_response=$(make_api_request "POST" "http://$domain_url/api/nodes" "$token" "$node_data")

    if [ -z "$node_response" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EMPTY_RESPONSE_NODE]}${COLOR_RESET}"
    fi

    if echo "$node_response" | jq -e '.response.uuid' > /dev/null; then
        printf "${COLOR_GREEN}${LANG[NODE_CREATED]}${COLOR_RESET}\n"
    else
        echo -e "${COLOR_RED}${LANG[ERROR_CREATE_NODE]}${COLOR_RESET}"
    fi
}

get_config_profiles() {
    local domain_url="$1"
    local token="$2"

    local config_response=$(make_api_request "GET" "http://$domain_url/api/config-profiles" "$token")
    if [ -z "$config_response" ] || ! echo "$config_response" | jq -e '.' > /dev/null 2>&1; then
        echo -e "${COLOR_RED}${LANG[ERROR_NO_CONFIGS]}${COLOR_RESET}"
        return 1
    fi

    local profile_uuid=$(echo "$config_response" | jq -r '.response.configProfiles[] | select(.name == "Default-Profile") | .uuid' 2>/dev/null)
    if [ -z "$profile_uuid" ]; then
        echo -e "${COLOR_YELLOW}${LANG[NO_DEFAULT_PROFILE]}${COLOR_RESET}"
        return 0
    fi

    echo "$profile_uuid"
    return 0
}

delete_config_profile() {
    local domain_url="$1"
    local token="$2"
    local profile_uuid="$3"

    if [ -z "$profile_uuid" ]; then
        profile_uuid=$(get_config_profiles "$domain_url" "$token")
        if [ $? -ne 0 ] || [ -z "$profile_uuid" ]; then
            return 0
        fi
    fi

    local delete_response=$(make_api_request "DELETE" "http://$domain_url/api/config-profiles/$profile_uuid" "$token")
    if [ -z "$delete_response" ] || ! echo "$delete_response" | jq -e '.' > /dev/null 2>&1; then
        echo -e "${COLOR_RED}${LANG[ERROR_DELETE_PROFILE]}${COLOR_RESET}"
        return 1
    fi

    return 0
}

create_config_profile() {
    local domain_url=$1
    local token=$2
    local name=$3
    local domain=$4
    local private_key=$5
    local inbound_tag="${6:-Steal}"

    local short_id=$(openssl rand -hex 8)

    local request_body=$(jq -n --arg name "$name" --arg domain "$domain" --arg private_key "$private_key" --arg short_id "$short_id" --arg inbound_tag "$inbound_tag" '{
        name: $name,
        config: {
            log: { loglevel: "warning" },
            dns: {
                queryStrategy: "ForceIPv4",
                servers: [{ address: "https://dns.google/dns-query", skipFallback: false }]
            },
            inbounds: [{
                tag: $inbound_tag,
                port: 443,
                protocol: "vless",
                settings: { clients: [], decryption: "none" },
                sniffing: { enabled: true, destOverride: ["http", "tls"] },
                streamSettings: {
                    network: "tcp",
                    security: "reality",
                    realitySettings: {
                        show: false,
                        xver: 1,
                        dest: "/dev/shm/nginx.sock",
                        spiderX: "",
                        shortIds: [$short_id],
                        privateKey: $private_key,
                        serverNames: [$domain]
                    }
                }
            }],
            outbounds: [
                { tag: "DIRECT", protocol: "freedom" },
                { tag: "BLOCK", protocol: "blackhole" }
            ],
            routing: {
                rules: [
                    { ip: ["geoip:private"], type: "field", outboundTag: "BLOCK" },
                    { type: "field", protocol: ["bittorrent"], outboundTag: "BLOCK" }
                ]
            }
        }
    }')

    local response=$(make_api_request "POST" "http://$domain_url/api/config-profiles" "$token" "$request_body")
    if [ -z "$response" ] || ! echo "$response" | jq -e '.response.uuid' > /dev/null; then
        echo -e "${COLOR_RED}${LANG[ERROR_CREATE_CONFIG_PROFILE]}: $response${COLOR_RESET}"
    fi

    local config_uuid=$(echo "$response" | jq -r '.response.uuid')
    local inbound_uuid=$(echo "$response" | jq -r '.response.inbounds[0].uuid')
    if [ -z "$config_uuid" ] || [ "$config_uuid" = "null" ] || [ -z "$inbound_uuid" ] || [ "$inbound_uuid" = "null" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_CREATE_CONFIG_PROFILE]}: Invalid UUIDs in response: $response${COLOR_RESET}"
    fi

    echo "$config_uuid $inbound_uuid"
}

create_host() {
    local domain_url=$1
    local token=$2
    local inbound_uuid=$3
    local address=$4
    local config_uuid=$5
    local host_remark="${6:-Steal}"

    local request_body=$(jq -n --arg config_uuid "$config_uuid" --arg inbound_uuid "$inbound_uuid" --arg remark "$host_remark" --arg address "$address" '{
        inbound: {
            configProfileUuid: $config_uuid,
            configProfileInboundUuid: $inbound_uuid
        },
        remark: $remark,
        address: $address,
        port: 443,
        path: "",
        sni: $address,
        host: "",
        alpn: null,
        fingerprint: "chrome",
        allowInsecure: false,
        isDisabled: false,
        securityLayer: "DEFAULT"
    }')

    local response=$(make_api_request "POST" "http://$domain_url/api/hosts" "$token" "$request_body")

    if [ -z "$response" ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_EMPTY_RESPONSE_HOST]}${COLOR_RESET}"
    fi

    if echo "$response" | jq -e '.response.uuid' > /dev/null; then
        echo -e "${COLOR_GREEN}${LANG[HOST_CREATED]}${COLOR_RESET}"
    else
        echo -e "${COLOR_RED}${LANG[ERROR_CREATE_HOST]}${COLOR_RESET}"
    fi
}

get_default_squad() {
    local domain_url=$1
    local token=$2

    local response=$(make_api_request "GET" "http://$domain_url/api/internal-squads" "$token")
    if [ -z "$response" ] || ! echo "$response" | jq -e '.response.internalSquads' > /dev/null 2>&1; then
        echo -e "${COLOR_RED}${LANG[ERROR_GET_SQUAD]}: $response${COLOR_RESET}"
        return 1
    fi

    local squad_uuids=$(echo "$response" | jq -r '.response.internalSquads[].uuid' 2>/dev/null)
    if [ -z "$squad_uuids" ]; then
        echo -e "${COLOR_YELLOW}${LANG[NO_SQUADS_FOUND]}${COLOR_RESET}"
        return 0
    fi

    local valid_uuids=""
    while IFS= read -r uuid; do
        if [ -z "$uuid" ]; then
            continue
        fi
        if [[ $uuid =~ ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$ ]]; then
            valid_uuids+="$uuid\n"
        else
            echo -e "${COLOR_RED}${LANG[INVALID_UUID_FORMAT]}: $uuid${COLOR_RESET}"
        fi
    done <<< "$squad_uuids"

    if [ -z "$valid_uuids" ]; then
        echo -e "${COLOR_YELLOW}${LANG[NO_VALID_SQUADS_FOUND]}${COLOR_RESET}"
        return 0
    fi

    echo -e "$valid_uuids" | sed '/^$/d'
    return 0
}

update_squad() {
    local domain_url=$1
    local token=$2
    local squad_uuid=$3
    local inbound_uuid=$4

    if [[ ! $squad_uuid =~ ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$ ]]; then
        echo -e "${COLOR_RED}${LANG[INVALID_SQUAD_UUID]}: $squad_uuid${COLOR_RESET}"
        return 1
    fi

    if [[ ! $inbound_uuid =~ ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$ ]]; then
        echo -e "${COLOR_RED}${LANG[INVALID_INBOUND_UUID]}: $inbound_uuid${COLOR_RESET}"
        return 1
    fi

    local squad_response=$(make_api_request "GET" "http://$domain_url/api/internal-squads" "$token")
    if [ -z "$squad_response" ] || ! echo "$squad_response" | jq -e '.response.internalSquads' > /dev/null 2>&1; then
        echo -e "${COLOR_RED}${LANG[ERROR_GET_SQUAD]}: $squad_response${COLOR_RESET}"
        return 1
    fi

    local existing_inbounds=$(echo "$squad_response" | jq -r --arg uuid "$squad_uuid" '.response.internalSquads[] | select(.uuid == $uuid) | .inbounds[].uuid' 2>/dev/null)
    if [ -z "$existing_inbounds" ]; then
        existing_inbounds="[]"
    else
        existing_inbounds=$(echo "$existing_inbounds" | jq -R . | jq -s .)
    fi

    local inbounds_array=$(jq -n --argjson existing "$existing_inbounds" --arg new "$inbound_uuid" '$existing + [$new] | unique')

    local request_body=$(jq -n --arg uuid "$squad_uuid" --argjson inbounds "$inbounds_array" '{
        uuid: $uuid,
        inbounds: $inbounds
    }')

    local response=$(make_api_request "PATCH" "http://$domain_url/api/internal-squads" "$token" "$request_body")
    if [ -z "$response" ] || ! echo "$response" | jq -e '.response.uuid' > /dev/null 2>&1; then
        echo -e "${COLOR_RED}${LANG[ERROR_UPDATE_SQUAD]}: $response${COLOR_RESET}"
        return 1
    fi

    return 0
}

### API Functions ###

handle_certificates() {
    local -n domains_to_check_ref=$1
    local cert_method="$2"
    local letsencrypt_email="$3"
    local target_dir="/opt/remnawave"

    declare -A unique_domains
    local need_certificates=false
    local min_days_left=9999

    echo -e "${COLOR_YELLOW}${LANG[CHECK_CERTS]}${COLOR_RESET}"
    sleep 1

    echo -e "${COLOR_YELLOW}${LANG[REQUIRED_DOMAINS]}${COLOR_RESET}"
    for domain in "${!domains_to_check_ref[@]}"; do
        echo -e "${COLOR_WHITE}- $domain${COLOR_RESET}"
    done

    for domain in "${!domains_to_check_ref[@]}"; do
        if ! check_certificates "$domain"; then
            need_certificates=true
        else
            days_left=$(check_cert_expiry "$domain")
            if [ $? -eq 0 ] && [ "$days_left" -lt "$min_days_left" ]; then
                min_days_left=$days_left
            fi
        fi
    done

    if [ "$need_certificates" = true ]; then
        echo -e ""
        echo -e "${COLOR_YELLOW}${LANG[CERT_METHOD_PROMPT]}${COLOR_RESET}"
        echo -e ""
        echo -e "${COLOR_YELLOW}1. ${LANG[CERT_METHOD_CF]}${COLOR_RESET}"
        echo -e "${COLOR_YELLOW}2. ${LANG[CERT_METHOD_ACME]}${COLOR_RESET}"
        echo -e ""
        echo -e "${COLOR_YELLOW}0. ${LANG[EXIT]}${COLOR_RESET}"
        echo -e ""
        reading "${LANG[CERT_METHOD_CHOOSE]}" cert_method

        if [ "$cert_method" == "0" ]; then
            echo -e "${COLOR_YELLOW}${LANG[EXIT]}${COLOR_RESET}"
            exit 1
        elif [ "$cert_method" == "2" ]; then
            reading "${LANG[EMAIL_PROMPT]}" letsencrypt_email
        elif [ "$cert_method" != "1" ]; then
            echo -e "${COLOR_RED}${LANG[CERT_INVALID_CHOICE]}${COLOR_RESET}"
            exit 1
        fi
    else
        echo -e "${COLOR_GREEN}${LANG[CERTS_SKIPPED]}${COLOR_RESET}"
        cert_method="1"
    fi

    declare -A cert_domains_added
    if [ "$need_certificates" = true ] && [ "$cert_method" == "1" ]; then
        for domain in "${!domains_to_check_ref[@]}"; do
            local base_domain=$(extract_domain "$domain")
            unique_domains["$base_domain"]="1"
        done

        for domain in "${!unique_domains[@]}"; do
            get_certificates "$domain" "$cert_method" ""
            if [ $? -ne 0 ]; then
                echo -e "${COLOR_RED}${LANG[CERT_GENERATION_FAILED]} $domain${COLOR_RESET}"
                return 1
            fi
            min_days_left=90
            if [ -z "${cert_domains_added[$domain]}" ]; then
                echo "      - /etc/letsencrypt/live/$domain/fullchain.pem:/etc/nginx/ssl/$domain/fullchain.pem:ro" >> "$target_dir/docker-compose.yml"
                echo "      - /etc/letsencrypt/live/$domain/privkey.pem:/etc/nginx/ssl/$domain/privkey.pem:ro" >> "$target_dir/docker-compose.yml"
                cert_domains_added["$domain"]="1"
            fi
        done
    elif [ "$need_certificates" = true ] && [ "$cert_method" == "2" ]; then
        for domain in "${!domains_to_check_ref[@]}"; do
            get_certificates "$domain" "$cert_method" "$letsencrypt_email"
            if [ $? -ne 0 ]; then
                echo -e "${COLOR_RED}${LANG[CERT_GENERATION_FAILED]} $domain${COLOR_RESET}"
                continue
            fi
            if [ -z "${cert_domains_added[$domain]}" ]; then
                echo "      - /etc/letsencrypt/live/$domain/fullchain.pem:/etc/nginx/ssl/$domain/fullchain.pem:ro" >> "$target_dir/docker-compose.yml"
                echo "      - /etc/letsencrypt/live/$domain/privkey.pem:/etc/nginx/ssl/$domain/privkey.pem:ro" >> "$target_dir/docker-compose.yml"
                cert_domains_added["$domain"]="1"
            fi
        done
    else
        for domain in "${!domains_to_check_ref[@]}"; do
            local base_domain=$(extract_domain "$domain")
            local cert_domain="$domain"
            if [ -d "/etc/letsencrypt/live/$base_domain" ] && is_wildcard_cert "$base_domain"; then
                cert_domain="$base_domain"
            fi
            if [ -z "${cert_domains_added[$cert_domain]}" ]; then
                echo "      - /etc/letsencrypt/live/$cert_domain/fullchain.pem:/etc/nginx/ssl/$cert_domain/fullchain.pem:ro" >> "$target_dir/docker-compose.yml"
                echo "      - /etc/letsencrypt/live/$cert_domain/privkey.pem:/etc/nginx/ssl/$cert_domain/privkey.pem:ro" >> "$target_dir/docker-compose.yml"
                cert_domains_added["$cert_domain"]="1"
            fi
        done
    fi

    local cron_command
    if [ "$cert_method" == "2" ]; then
        cron_command="ufw allow 80 && /usr/bin/certbot renew --quiet && ufw delete allow 80 && ufw reload"
    else
        cron_command="/usr/bin/certbot renew --quiet"
    fi

    if ! crontab -u root -l 2>/dev/null | grep -q "/usr/bin/certbot renew"; then
        echo -e "${COLOR_YELLOW}${LANG[ADDING_CRON_FOR_EXISTING_CERTS]}${COLOR_RESET}"
        if [ "$min_days_left" -le 30 ]; then
            echo -e "${COLOR_YELLOW}${LANG[CERT_EXPIRY_SOON]} $min_days_left ${LANG[DAYS]}${COLOR_RESET}"
            add_cron_rule "0 5 * * * $cron_command"
        else
            add_cron_rule "0 5 1 */2 * $cron_command"
        fi
    elif [ "$min_days_left" -le 30 ] && ! crontab -u root -l 2>/dev/null | grep -q "0 5 * * *.*$cron_command"; then
        echo -e "${COLOR_YELLOW}${LANG[CERT_EXPIRY_SOON]} $min_days_left ${LANG[DAYS]}${COLOR_RESET}"
        echo -e "${COLOR_YELLOW}${LANG[UPDATING_CRON]}${COLOR_RESET}"
        crontab -u root -l 2>/dev/null | grep -v "/usr/bin/certbot renew" | crontab -u root -
        add_cron_rule "0 5 * * * $cron_command"
    else
        echo -e "${COLOR_YELLOW}${LANG[CRON_ALREADY_EXISTS]}${COLOR_RESET}"
    fi

    for domain in "${!unique_domains[@]}"; do
        if [ -f "/etc/letsencrypt/renewal/$domain.conf" ]; then
            desired_hook="renew_hook = sh -c 'cd /opt/remnawave && docker compose down remnawave-nginx && docker compose up -d remnawave-nginx'"
            if ! grep -q "renew_hook" "/etc/letsencrypt/renewal/$domain.conf"; then
                echo "$desired_hook" >> "/etc/letsencrypt/renewal/$domain.conf"
            elif ! grep -Fx "$desired_hook" "/etc/letsencrypt/renewal/$domain.conf"; then
                sed -i "/renew_hook/c\\$desired_hook" "/etc/letsencrypt/renewal/$domain.conf"
                echo -e "${COLOR_YELLOW}${LANG[UPDATED_RENEW_AUTH]}${COLOR_RESET}"
            fi
        fi
    done
}

#Install Panel
install_remnawave_panel() {
    mkdir -p /opt/remnawave && cd /opt/remnawave

    reading "${LANG[ENTER_PANEL_DOMAIN]}" PANEL_DOMAIN
    check_domain "$PANEL_DOMAIN" true true
    local panel_check_result=$?
    if [ $panel_check_result -eq 2 ]; then
        echo -e "${COLOR_RED}${LANG[ABORT_MESSAGE]}${COLOR_RESET}"
        exit 1
    fi

    reading "${LANG[ENTER_SUB_DOMAIN]}" SUB_DOMAIN
    check_domain "$SUB_DOMAIN" true true
    local sub_check_result=$?
    if [ $sub_check_result -eq 2 ]; then
        echo -e "${COLOR_RED}${LANG[ABORT_MESSAGE]}${COLOR_RESET}"
        exit 1
    fi

    reading "${LANG[ENTER_NODE_DOMAIN]}" SELFSTEAL_DOMAIN

    if [ "$PANEL_DOMAIN" = "$SUB_DOMAIN" ] || [ "$PANEL_DOMAIN" = "$SELFSTEAL_DOMAIN" ] || [ "$SUB_DOMAIN" = "$SELFSTEAL_DOMAIN" ]; then
        echo -e "${COLOR_RED}${LANG[DOMAINS_MUST_BE_UNIQUE]}${COLOR_RESET}"
        exit 1
    fi

    PANEL_BASE_DOMAIN=$(extract_domain "$PANEL_DOMAIN")
    SUB_BASE_DOMAIN=$(extract_domain "$SUB_DOMAIN")

    unique_domains["$PANEL_BASE_DOMAIN"]=1
    unique_domains["$SUB_BASE_DOMAIN"]=1

    SUPERADMIN_USERNAME=$(generate_user)
    SUPERADMIN_PASSWORD=$(generate_password)

    cookies_random1=$(generate_user)
    cookies_random2=$(generate_user)

    METRICS_USER=$(generate_user)
    METRICS_PASS=$(generate_user)

    JWT_AUTH_SECRET=$(openssl rand -base64 48 | tr -dc 'a-zA-Z0-9' | head -c 64)
    JWT_API_TOKENS_SECRET=$(openssl rand -base64 48 | tr -dc 'a-zA-Z0-9' | head -c 64)

    cat > .env <<EOL
### APP ###
APP_PORT=3000
METRICS_PORT=3001

### API ###
# Possible values: max (start instances on all cores), number (start instances on number of cores), -1 (start instances on all cores - 1)
# !!! Do not set this value more than physical cores count in your machine !!!
# Review documentation: https://remna.st/docs/install/environment-variables#scaling-api
API_INSTANCES=1

### DATABASE ###
# FORMAT: postgresql://{user}:{password}@{host}:{port}/{database}
DATABASE_URL="postgresql://postgres:postgres@remnawave-db:5432/postgres"

### REDIS ###
REDIS_HOST=remnawave-redis
REDIS_PORT=6379

### JWT ###
JWT_AUTH_SECRET=$JWT_AUTH_SECRET
JWT_API_TOKENS_SECRET=$JWT_API_TOKENS_SECRET

# Set the session idle timeout in the panel to avoid daily logins.
# Value in hours: 12–168
JWT_AUTH_LIFETIME=168

### TELEGRAM NOTIFICATIONS ###
IS_TELEGRAM_NOTIFICATIONS_ENABLED=false
TELEGRAM_BOT_TOKEN=change_me
TELEGRAM_NOTIFY_USERS_CHAT_ID=change_me
TELEGRAM_NOTIFY_NODES_CHAT_ID=change_me

### Telegram Oauth (Login with Telegram)
### Docs https://remna.st/docs/features/telegram-oauth
### true/false
TELEGRAM_OAUTH_ENABLED=false
### Array of Admin Chat Ids. These ids will be allowed to login.
TELEGRAM_OAUTH_ADMIN_IDS=[123, 321]

# Optional
# Only set if you want to use topics
TELEGRAM_NOTIFY_USERS_THREAD_ID=
TELEGRAM_NOTIFY_NODES_THREAD_ID=
TELEGRAM_NOTIFY_CRM_THREAD_ID=

# Enable Github OAuth2, possible values: true, false
OAUTH2_GITHUB_ENABLED=false
# Github client ID, you can get it from Github application settings
OAUTH2_GITHUB_CLIENT_ID="REPLACE_WITH_YOUR_CLIENT_ID"
# Github client secret, you can get it from Github application settings
OAUTH2_GITHUB_CLIENT_SECRET="REPLACE_WITH_YOUR_CLIENT_SECRET"
# List of allowed emails, separated by commas
OAUTH2_GITHUB_ALLOWED_EMAILS=["admin@example.com", "user@example.com"]

# Enable PocketID OAuth2, possible values: true, false
OAUTH2_POCKETID_ENABLED=false
# PocketID Client ID, you can get it from OIDC Client settings
OAUTH2_POCKETID_CLIENT_ID="REPLACE_WITH_YOUR_CLIENT_ID"
# PocketID Client Secret, you can get it from OIDC Client settings
OAUTH2_POCKETID_CLIENT_SECRET="REPLACE_WITH_YOUR_CLIENT_SECRET"
# Plain domain where PocketID is hosted, do not place any paths here. Just plain domain.
OAUTH2_POCKETID_PLAIN_DOMAIN="pocketid.domain.com"
# List of allowed emails, separated by commas
OAUTH2_POCKETID_ALLOWED_EMAILS=["admin@example.com", "user@example.com"]

# Enable Yandex OAuth2, possible values: true, false
OAUTH2_YANDEX_ENABLED=false
# Yandex Client ID, you can get it from OIDC Client settings
OAUTH2_YANDEX_CLIENT_ID="REPLACE_WITH_YOUR_CLIENT_ID"
# Yandex Client Secret, you can get it from OIDC Client settings
OAUTH2_YANDEX_CLIENT_SECRET="REPLACE_WITH_YOUR_CLIENT_SECRET"
# List of allowed emails, separated by commas
OAUTH2_YANDEX_ALLOWED_EMAILS=["admin@example.com", "user@example.com"]

### FRONT_END ###
# Used by CORS, you can leave it as * or place your domain there
FRONT_END_DOMAIN=$PANEL_DOMAIN

### SUBSCRIPTION PUBLIC DOMAIN ###
### DOMAIN, WITHOUT HTTP/HTTPS, DO NOT ADD / AT THE END ###
### Used in "profile-web-page-url" response header and in UI/API ###
### Review documentation: https://remna.st/docs/install/environment-variables#domains
SUB_PUBLIC_DOMAIN=$SUB_DOMAIN

### If CUSTOM_SUB_PREFIX is set in @remnawave/subscription-page, append the same path to SUB_PUBLIC_DOMAIN. Example: SUB_PUBLIC_DOMAIN=sub-page.example.com/sub ###

### SWAGGER ###
SWAGGER_PATH=/docs
SCALAR_PATH=/scalar
IS_DOCS_ENABLED=true

### PROMETHEUS ###
### Metrics are available at /api/metrics
METRICS_USER=$METRICS_USER
METRICS_PASS=$METRICS_PASS

### WEBHOOK ###
WEBHOOK_ENABLED=false
### Only https:// is allowed
WEBHOOK_URL=https://webhook.site/1234567890
### This secret is used to sign the webhook payload, must be exact 64 characters. Only a-z, 0-9, A-Z are allowed.
WEBHOOK_SECRET_HEADER=vsmu67Kmg6R8FjIOF1WUY8LWBHie4scdEqrfsKmyf4IAf8dY3nFS0wwYHkhh6ZvQ

### HWID DEVICE DETECTION AND LIMITATION ###
# Don't enable this if you don't know what you are doing.
# Review documentation before enabling this feature.
# https://remna.st/docs/features/hwid-device-limit/
HWID_DEVICE_LIMIT_ENABLED=false
HWID_FALLBACK_DEVICE_LIMIT=5
HWID_MAX_DEVICES_ANNOUNCE="You have reached the maximum number of devices for your subscription."

### Bandwidth usage reached notifications
BANDWIDTH_USAGE_NOTIFICATIONS_ENABLED=false
# Only in ASC order (example: [60, 80]), must be valid array of integer(min: 25, max: 95) numbers. No more than 5 values.
BANDWIDTH_USAGE_NOTIFICATIONS_THRESHOLD=[60, 80]

### CLOUDFLARE ###
# USED ONLY FOR docker-compose-prod-with-cf.yml
# NOT USED BY THE APP ITSELF
CLOUDFLARE_TOKEN=ey...

### Database ###
### For Postgres Docker container ###
# NOT USED BY THE APP ITSELF
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=postgres
EOL

    cat > docker-compose.yml <<EOL
services:
  remnawave-db:
    image: postgres:17.6
    container_name: 'remnawave-db'
    hostname: remnawave-db
    restart: always
    env_file:
      - .env
    environment:
      - POSTGRES_USER=\${POSTGRES_USER}
      - POSTGRES_PASSWORD=\${POSTGRES_PASSWORD}
      - POSTGRES_DB=\${POSTGRES_DB}
      - TZ=UTC
    ports:
      - '127.0.0.1:6767:5432'
    volumes:
      - remnawave-db-data:/var/lib/postgresql/data
    networks:
      - remnawave-network
    healthcheck:
      test: ['CMD-SHELL', 'pg_isready -U \$\${POSTGRES_USER} -d \$\${POSTGRES_DB}']
      interval: 3s
      timeout: 10s
      retries: 3
    logging:
      driver: 'json-file'
      options:
        max-size: '30m'
        max-file: '5'

  remnawave:
    image: remnawave/backend:latest
    container_name: remnawave
    hostname: remnawave
    restart: always
    env_file:
      - .env
    ports:
      - '127.0.0.1:3000:3000'
    networks:
      - remnawave-network
    healthcheck:
      test: ['CMD-SHELL', 'curl -f http://localhost:\${METRICS_PORT:-3001}/health']
      interval: 30s
      timeout: 5s
      retries: 3
      start_period: 30s
    depends_on:
      remnawave-db:
        condition: service_healthy
      remnawave-redis:
        condition: service_healthy
    logging:
      driver: 'json-file'
      options:
        max-size: '30m'
        max-file: '5'

  remnawave-redis:
    image: valkey/valkey:8.1.3-alpine
    container_name: remnawave-redis
    hostname: remnawave-redis
    restart: always
    networks:
      - remnawave-network
    volumes:
      - remnawave-redis-data:/data
    healthcheck:
      test: ['CMD', 'valkey-cli', 'ping']
      interval: 3s
      timeout: 10s
      retries: 3
    logging:
      driver: 'json-file'
      options:
        max-size: '30m'
        max-file: '5'

  remnawave-nginx:
    image: nginx:1.28
    container_name: remnawave-nginx
    hostname: remnawave-nginx
    restart: always
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
EOL
}

installation_panel() {
    echo -e "${COLOR_YELLOW}${LANG[INSTALLING_PANEL]}${COLOR_RESET}"
    sleep 1

    declare -A unique_domains
    install_remnawave_panel

    declare -A domains_to_check
    domains_to_check["$PANEL_DOMAIN"]=1
    domains_to_check["$SUB_DOMAIN"]=1

    handle_certificates domains_to_check "$CERT_METHOD" "$LETSENCRYPT_EMAIL"
    
    if [ -z "$CERT_METHOD" ]; then
        local base_domain=$(extract_domain "$PANEL_DOMAIN")
        if [ -d "/etc/letsencrypt/live/$base_domain" ] && is_wildcard_cert "$base_domain"; then
            CERT_METHOD="1"
        else
            CERT_METHOD="2"
        fi
    fi

    if [ "$CERT_METHOD" == "1" ]; then
        local base_domain=$(extract_domain "$PANEL_DOMAIN")
        local sub_base_domain=$(extract_domain "$SUB_DOMAIN")
        PANEL_CERT_DOMAIN="$base_domain"
        SUB_CERT_DOMAIN="$sub_base_domain"
    else
        PANEL_CERT_DOMAIN="$PANEL_DOMAIN"
        SUB_CERT_DOMAIN="$SUB_DOMAIN"
    fi

    cat >> /opt/remnawave/docker-compose.yml <<EOL
    network_mode: host
    depends_on:
      - remnawave
      - remnawave-subscription-page
    logging:
      driver: 'json-file'
      options:
        max-size: '30m'
        max-file: '5'

  remnawave-subscription-page:
    image: remnawave/subscription-page:latest
    container_name: remnawave-subscription-page
    hostname: remnawave-subscription-page
    restart: always
    environment:
      - REMNAWAVE_PANEL_URL=http://remnawave:3000
      - APP_PORT=3010
      - META_TITLE=Remnawave Subscription
      - META_DESCRIPTION=page
    ports:
      - '127.0.0.1:3010:3010'
    networks:
      - remnawave-network
    logging:
      driver: 'json-file'
      options:
        max-size: '30m'
        max-file: '5'

networks:
  remnawave-network:
    name: remnawave-network
    driver: bridge
    external: false

volumes:
  remnawave-db-data:
    driver: local
    external: false
    name: remnawave-db-data
  remnawave-redis-data:
    driver: local
    external: false
    name: remnawave-redis-data
EOL

    cat > /opt/remnawave/nginx.conf <<EOL
upstream remnawave {
    server 127.0.0.1:3000;
}

upstream json {
    server 127.0.0.1:3010;
}

map \$http_upgrade \$connection_upgrade {
    default upgrade;
    ""      close;
}

map \$http_cookie \$auth_cookie {
    default 0;
    "~*${cookies_random1}=${cookies_random2}" 1;
}

map \$arg_${cookies_random1} \$auth_query {
    default 0;
    "${cookies_random2}" 1;
}

map "\$auth_cookie\$auth_query" \$authorized {
    "~1" 1;
    default 0;
}

map \$arg_${cookies_random1} \$set_cookie_header {
    "${cookies_random2}" "${cookies_random1}=${cookies_random2}; Path=/; HttpOnly; Secure; SameSite=Strict; Max-Age=31536000";
    default "";
}

ssl_protocols TLSv1.2 TLSv1.3;
ssl_ecdh_curve X25519:prime256v1:secp384r1;
ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305;
ssl_prefer_server_ciphers on;
ssl_session_timeout 1d;
ssl_session_cache shared:MozSSL:10m;

server {
    server_name $PANEL_DOMAIN;
    listen 443 ssl;
    http2 on;

    ssl_certificate "/etc/nginx/ssl/$PANEL_CERT_DOMAIN/fullchain.pem";
    ssl_certificate_key "/etc/nginx/ssl/$PANEL_CERT_DOMAIN/privkey.pem";
    ssl_trusted_certificate "/etc/nginx/ssl/$PANEL_CERT_DOMAIN/fullchain.pem";

    add_header Set-Cookie \$set_cookie_header;

    location / {
        if (\$authorized = 0) {
            return 444;
        }
        proxy_http_version 1.1;
        proxy_pass http://remnawave;
        proxy_set_header Host \$host;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }
}

server {
    server_name $SUB_DOMAIN;
    listen 443 ssl;
    http2 on;

    ssl_certificate "/etc/nginx/ssl/$SUB_CERT_DOMAIN/fullchain.pem";
    ssl_certificate_key "/etc/nginx/ssl/$SUB_CERT_DOMAIN/privkey.pem";
    ssl_trusted_certificate "/etc/nginx/ssl/$SUB_CERT_DOMAIN/fullchain.pem";

    location / {
        proxy_http_version 1.1;
        proxy_pass http://json;
        proxy_set_header Host \$host;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \$connection_upgrade;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_set_header X-Forwarded-Host \$host;
        proxy_set_header X-Forwarded-Port \$server_port;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
        proxy_intercept_errors on;
        error_page 400 404 500 502 @redirect;
    }

    location @redirect {
        return 404;
    }
}

server {
    listen 443 ssl default_server;
    server_name _;
    ssl_reject_handshake on;
}
EOL

    echo -e "${COLOR_YELLOW}${LANG[STARTING_PANEL]}${COLOR_RESET}"
    sleep 1
    cd /opt/remnawave
    docker compose up -d > /dev/null 2>&1 &

    spinner $! "${LANG[WAITING]}"

    echo -e "${COLOR_YELLOW}${LANG[REGISTERING_REMNAWAVE]}${COLOR_RESET}"
    sleep 20

    local domain_url="127.0.0.1:3000"
    echo -e "${COLOR_YELLOW}${LANG[CHECK_CONTAINERS]}${COLOR_RESET}"
    until curl -s "http://$domain_url/api/auth/register" \
        --header 'X-Forwarded-For: 127.0.0.1' \
        --header 'X-Forwarded-Proto: https' \
        > /dev/null; do
        echo -e "${COLOR_RED}${LANG[CONTAINERS_NOT_READY]}${COLOR_RESET}"
        sleep 5
    done

    # Register Remnawave
    local token=$(register_remnawave "$domain_url" "$SUPERADMIN_USERNAME" "$SUPERADMIN_PASSWORD")
    echo -e "${COLOR_GREEN}${LANG[REGISTRATION_SUCCESS]}${COLOR_RESET}"

    # Generate Xray keys
    echo -e "${COLOR_YELLOW}${LANG[GENERATE_KEYS]}${COLOR_RESET}"
    sleep 1
    local private_key=$(generate_xray_keys "$domain_url" "$token")
    printf "${COLOR_GREEN}${LANG[GENERATE_KEYS_SUCCESS]}${COLOR_RESET}\n"

    # Delete default config profile
    delete_config_profile "$domain_url" "$token"

    # Create config profile
    echo -e "${COLOR_YELLOW}${LANG[CREATING_CONFIG_PROFILE]}${COLOR_RESET}"
    read config_profile_uuid inbound_uuid <<< $(create_config_profile "$domain_url" "$token" "StealConfig" "$SELFSTEAL_DOMAIN" "$private_key")
    echo -e "${COLOR_GREEN}${LANG[CONFIG_PROFILE_CREATED]}${COLOR_RESET}"

    # Create node with config profile binding
    echo -e "${COLOR_YELLOW}${LANG[CREATING_NODE]}${COLOR_RESET}"
    create_node "$domain_url" "$token" "$config_profile_uuid" "$inbound_uuid" "$SELFSTEAL_DOMAIN"

    # Create host
    echo -e "${COLOR_YELLOW}${LANG[CREATE_HOST]}${COLOR_RESET}"
    create_host "$domain_url" "$token" "$inbound_uuid" "$SELFSTEAL_DOMAIN" "$config_profile_uuid"

    # Get UUID default squad
    echo -e "${COLOR_YELLOW}${LANG[GET_DEFAULT_SQUAD]}${COLOR_RESET}"
    local squad_uuid=$(get_default_squad "$domain_url" "$token")

    # Update squad
    update_squad "$domain_url" "$token" "$squad_uuid" "$inbound_uuid"
    echo -e "${COLOR_GREEN}${LANG[UPDATE_SQUAD]}${COLOR_RESET}"

    clear

    echo -e "${COLOR_YELLOW}=================================================${COLOR_RESET}"
    echo -e "${COLOR_GREEN}${LANG[INSTALL_COMPLETE]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}=================================================${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[PANEL_ACCESS]}${COLOR_RESET}"
    echo -e "${COLOR_WHITE}https://${PANEL_DOMAIN}/auth/login?${cookies_random1}=${cookies_random2}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}-------------------------------------------------${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[ADMIN_CREDS]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[USERNAME]} ${COLOR_WHITE}$SUPERADMIN_USERNAME${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[PASSWORD]} ${COLOR_WHITE}$SUPERADMIN_PASSWORD${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}-------------------------------------------------${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[RELAUNCH_CMD]}${COLOR_RESET}"
    echo -e "${COLOR_GREEN}remnawave_reverse${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}=================================================${COLOR_RESET}"
    echo -e "${COLOR_RED}${LANG[POST_PANEL_INSTRUCTION]}${COLOR_RESET}"
}
#Install Panel

#Install Node
install_remnawave_node() {
    mkdir -p /opt/remnawave && cd /opt/remnawave

    reading "${LANG[SELFSTEAL]}" SELFSTEAL_DOMAIN

    check_domain "$SELFSTEAL_DOMAIN" true false
    local domain_check_result=$?
    if [ $domain_check_result -eq 2 ]; then
        echo -e "${COLOR_RED}${LANG[ABORT_MESSAGE]}${COLOR_RESET}"
        exit 1
    fi

    while true; do
        reading "${LANG[PANEL_IP_PROMPT]}" PANEL_IP
        if echo "$PANEL_IP" | grep -E '^([0-9]{1,3}\.){3}[0-9]{1,3}$' >/dev/null && \
           [[ $(echo "$PANEL_IP" | tr '.' '\n' | wc -l) -eq 4 ]] && \
           [[ ! $(echo "$PANEL_IP" | tr '.' '\n' | grep -vE '^[0-9]{1,3}$') ]] && \
           [[ ! $(echo "$PANEL_IP" | tr '.' '\n' | grep -E '^(25[6-9]|2[6-9][0-9]|[3-9][0-9]{2})$') ]]; then
            break
        else
            echo -e "${COLOR_RED}${LANG[IP_ERROR]}${COLOR_RESET}"
        fi
    done

    echo -n "$(question "${LANG[CERT_PROMPT]}")"
    CERTIFICATE=""
    while IFS= read -r line; do
        if [ -z "$line" ]; then
            if [ -n "$CERTIFICATE" ]; then
                break
            fi
        else
            CERTIFICATE="$CERTIFICATE$line\n"
        fi
    done

    echo -e "${COLOR_YELLOW}${LANG[CERT_CONFIRM]}${COLOR_RESET}"
    read confirm
    echo

    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo -e "${COLOR_RED}${LANG[ABORT_MESSAGE]}${COLOR_RESET}"
        exit 1
    fi

cat > .env-node <<EOL
### APP ###
APP_PORT=2222

### XRAY ###
$(echo -e "$CERTIFICATE" | sed 's/\\n$//')
EOL

SELFSTEAL_BASE_DOMAIN=$(extract_domain "$SELFSTEAL_DOMAIN")

unique_domains["$SELFSTEAL_BASE_DOMAIN"]=1

cat > docker-compose.yml <<EOL
services:
  remnawave-nginx:
    image: nginx:1.28
    container_name: remnawave-nginx
    hostname: remnawave-nginx
    restart: always
    volumes:
      - ./nginx.conf:/etc/nginx/conf.d/default.conf:ro
EOL
}

installation_node() {
    echo -e "${COLOR_YELLOW}${LANG[INSTALLING_NODE]}${COLOR_RESET}"
    sleep 1

    declare -A unique_domains
    install_remnawave_node

    declare -A domains_to_check
    domains_to_check["$SELFSTEAL_DOMAIN"]=1

    handle_certificates domains_to_check "$CERT_METHOD" "$LETSENCRYPT_EMAIL"

    if [ -z "$CERT_METHOD" ]; then
        local base_domain=$(extract_domain "$SELFSTEAL_DOMAIN")
        if [ -d "/etc/letsencrypt/live/$base_domain" ] && is_wildcard_cert "$base_domain"; then
            CERT_METHOD="1"
        else
            CERT_METHOD="2"
        fi
    fi

    if [ "$CERT_METHOD" == "1" ]; then
        local base_domain=$(extract_domain "$SELFSTEAL_DOMAIN")
        NODE_CERT_DOMAIN="$base_domain"
    else
        NODE_CERT_DOMAIN="$SELFSTEAL_DOMAIN"
    fi

    cat >> /opt/remnawave/docker-compose.yml <<EOL
      - /dev/shm:/dev/shm:rw
      - /var/www/html:/var/www/html:ro
    command: sh -c 'rm -f /dev/shm/nginx.sock && nginx -g "daemon off;"'
    network_mode: host
    depends_on:
      - remnanode
    logging:
      driver: 'json-file'
      options:
        max-size: '30m'
        max-file: '5'

  remnanode:
    image: remnawave/node:latest
    container_name: remnanode
    hostname: remnanode
    restart: always
    network_mode: host
    env_file:
      - path: /opt/remnawave/.env-node
        required: false
    volumes:
      - /dev/shm:/dev/shm:rw
    logging:
      driver: 'json-file'
      options:
        max-size: '30m'
        max-file: '5'
EOL

cat > /opt/remnawave/nginx.conf <<EOL
map \$http_upgrade \$connection_upgrade {
    default upgrade;
    ""      close;
}

ssl_protocols TLSv1.2 TLSv1.3;
ssl_ecdh_curve X25519:prime256v1:secp384r1;
ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-CHACHA20-POLY1305;
ssl_prefer_server_ciphers on;
ssl_session_timeout 1d;
ssl_session_cache shared:MozSSL:10m;
ssl_session_tickets off;

server {
    server_name $SELFSTEAL_DOMAIN;
    listen unix:/dev/shm/nginx.sock ssl proxy_protocol;
    http2 on;

    ssl_certificate "/etc/nginx/ssl/$NODE_CERT_DOMAIN/fullchain.pem";
    ssl_certificate_key "/etc/nginx/ssl/$NODE_CERT_DOMAIN/privkey.pem";
    ssl_trusted_certificate "/etc/nginx/ssl/$NODE_CERT_DOMAIN/fullchain.pem";

    root /var/www/html;
    index index.html;
}

server {
    listen unix:/dev/shm/nginx.sock ssl proxy_protocol default_server;
    server_name _;
    ssl_reject_handshake on;
    return 444;
}
EOL

    ufw allow from $PANEL_IP to any port 2222 > /dev/null 2>&1
    ufw reload > /dev/null 2>&1

    echo -e "${COLOR_YELLOW}${LANG[STARTING_NODE]}${COLOR_RESET}"
    sleep 3
    cd /opt/remnawave
    docker compose up -d > /dev/null 2>&1 &

    spinner $! "${LANG[WAITING]}"

    randomhtml

    printf "${COLOR_YELLOW}${LANG[NODE_CHECK]}${COLOR_RESET}\n" "$SELFSTEAL_DOMAIN"
    local max_attempts=5
    local attempt=1
    local delay=15

    while [ $attempt -le $max_attempts ]; do
        printf "${COLOR_YELLOW}${LANG[NODE_ATTEMPT]}${COLOR_RESET}\n" "$attempt" "$max_attempts"
        if curl -s --fail --max-time 10 "https://$SELFSTEAL_DOMAIN" | grep -q "html"; then
            echo -e "${COLOR_GREEN}${LANG[NODE_LAUNCHED]}${COLOR_RESET}"
            break
        else
            printf "${COLOR_RED}${LANG[NODE_UNAVAILABLE]}${COLOR_RESET}\n" "$attempt"
            if [ $attempt -eq $max_attempts ]; then
                printf "${COLOR_RED}${LANG[NODE_NOT_CONNECTED]}${COLOR_RESET}\n" "$max_attempts"
                echo -e "${COLOR_YELLOW}${LANG[CHECK_CONFIG]}${COLOR_RESET}"
                exit 1
            fi
            sleep $delay
        fi
        ((attempt++))
    done

}
#Install Node

#Add Node to Panel
add_node_to_panel() {
    local domain_url="127.0.0.1:3000"
    
    echo -e ""
    echo -e "${COLOR_RED}${LANG[WARNING_LABEL]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[WARNING_NODE_PANEL]}${COLOR_RESET}"
    echo -e "${COLOR_YELLOW}${LANG[CONFIRM_SERVER_PANEL]}${COLOR_RESET}"
    echo -e ""
    echo -e "${COLOR_GREEN}[?]${COLOR_RESET} ${COLOR_YELLOW}${LANG[CONFIRM_PROMPT]}${COLOR_RESET}"
    read confirm
    echo

    if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
        echo -e "${COLOR_YELLOW}${LANG[EXIT]}${COLOR_RESET}"
        exit 0
    fi

    echo -e "${COLOR_YELLOW}${LANG[ADD_NODE_TO_PANEL]}${COLOR_RESET}"
    sleep 1

    reading "${LANG[ENTER_NODE_DOMAIN]}" SELFSTEAL_DOMAIN
    
        while true; do
        reading "${LANG[ENTER_NODE_NAME]}" entity_name
        if [[ "$entity_name" =~ ^[a-zA-Z0-9-]+$ ]]; then
            if [ ${#entity_name} -ge 3 ] && [ ${#entity_name} -le 20 ]; then
                get_panel_token
                token=$(cat "$TOKEN_FILE")
                local response=$(make_api_request "GET" "http://$domain_url/api/config-profiles" "$token")
                
                if echo "$response" | jq -e ".response.configProfiles[] | select(.name == \"$entity_name\")" > /dev/null; then
                    echo -e "${COLOR_RED}$(printf "${LANG[CF_INVALID_NAME]}" "$entity_name")${COLOR_RESET}"
                else
                    break
                fi
            else
                echo -e "${COLOR_RED}${LANG[CF_INVALID_LENGTH]}${COLOR_RESET}"
            fi
        else
            echo -e "${COLOR_RED}${LANG[CF_INVALID_CHARS]}${COLOR_RESET}"
        fi
    done

    echo -e "${COLOR_YELLOW}${LANG[GENERATE_KEYS]}${COLOR_RESET}"
    local private_key=$(generate_xray_keys "$domain_url" "$token")
    printf "${COLOR_GREEN}${LANG[GENERATE_KEYS_SUCCESS]}${COLOR_RESET}\n"

    echo -e "${COLOR_YELLOW}${LANG[CREATING_CONFIG_PROFILE]}${COLOR_RESET}"
    read config_profile_uuid inbound_uuid <<< $(create_config_profile "$domain_url" "$token" "$entity_name" "$SELFSTEAL_DOMAIN" "$private_key" "$entity_name")
    echo -e "${COLOR_GREEN}${LANG[CONFIG_PROFILE_CREATED]}: $entity_name${COLOR_RESET}"

    printf "${COLOR_YELLOW}${LANG[CREATE_NEW_NODE]}$SELFSTEAL_DOMAIN${COLOR_RESET}\n"
    create_node "$domain_url" "$token" "$config_profile_uuid" "$inbound_uuid" "$SELFSTEAL_DOMAIN" "$entity_name"

    echo -e "${COLOR_YELLOW}${LANG[CREATE_HOST]}${COLOR_RESET}"
    create_host "$domain_url" "$token" "$inbound_uuid" "$SELFSTEAL_DOMAIN" "$config_profile_uuid" "$entity_name"

    echo -e "${COLOR_YELLOW}${LANG[GET_DEFAULT_SQUAD]}${COLOR_RESET}"
    local squad_uuids=$(get_default_squad "$domain_url" "$token")
    if [ $? -ne 0 ]; then
        echo -e "${COLOR_RED}${LANG[ERROR_GET_SQUAD_LIST]}${COLOR_RESET}"
    elif [ -z "$squad_uuids" ]; then
        echo -e "${COLOR_YELLOW}${LANG[NO_SQUADS_TO_UPDATE]}${COLOR_RESET}"
    else
        for squad_uuid in $squad_uuids; do
            echo -e "${COLOR_YELLOW}${LANG[UPDATING_SQUAD]} $squad_uuid${COLOR_RESET}"
            update_squad "$domain_url" "$token" "$squad_uuid" "$inbound_uuid"
            if [ $? -eq 0 ]; then
                echo -e "${COLOR_GREEN}${LANG[UPDATE_SQUAD]} $squad_uuid${COLOR_RESET}"
            else
                echo -e "${COLOR_RED}${LANG[ERROR_UPDATE_SQUAD]} $squad_uuid${COLOR_RESET}"
            fi
        done
    fi

    echo -e "${COLOR_GREEN}${LANG[NODE_ADDED_SUCCESS]}${COLOR_RESET}"
    echo -e "${COLOR_RED}-------------------------------------------------${COLOR_RESET}"
    echo -e "${COLOR_RED}${LANG[POST_PANEL_INSTRUCTION]}${COLOR_RESET}"
    echo -e "${COLOR_RED}-------------------------------------------------${COLOR_RESET}"
}
#Add Node to Panel

log_entry
check_root
check_os

# Install packages if needed
if ! command -v docker >/dev/null 2>&1 || ! docker info >/dev/null 2>&1 || ! command -v certbot >/dev/null 2>&1; then
    install_packages || {
        echo -e "${COLOR_RED}Failed to install packages${COLOR_RESET}"
        exit 1
    }
fi

manage_install

exit 0
