#!/bin/bash
Install_step7()
{
yum install https://cloud.mongodb.com/download/agent/automation/mongodb-mms-automation-agent-manager-3.1.0.1831-1.x86_64.rhel7.rpm
#sed -i:bak '$ a\mmsGroupId= 513d91fd7fe227e9f1855cdb' /etc/mongodb-mms/automation-agent.config
#sed -i:bak '$ a\mmsGroupId= 88ca1ad3c453cb5bb8dff79ab9aecaeb' /etc/mongodb-mms/automation-agent.config
systemctl start mongodb-mms-automation-agent.service
}

Install_step7

exit
