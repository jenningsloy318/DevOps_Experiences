####get the IP address

ZONE=`/usr/bin/zonename`
if [[ $ZONE = 'global' ]];then
        IFC=`dladm show-dev|awk '{if($3~/up/)print $1}'`

        IP=` for dev in $IFC ;do ifconfig $dev| awk '/inet/ {print $2} ';done`
else
        IP=`ifconfig -a | awk ' /(inet)(.*)broadcast/ {print $2}'`
fi


####send out the email
if [[ -n "${SSH_CLIENT}"  &&  ${USER} = 'root' ]];then
    TEXT="`date`: account root ssh login to `hostname`($IP)"
    TEXT="$TEXT from `echo $SSH_CLIENT|awk '{print $1}'`"
    echo $TEXT|mailx -s "Alert! New ssh login catcahed"  sa@synnex.com
fi
###set the varables to record command history
if [[  ${SHELL} = '/bin/bash' ]]; then
        export PROMPT_COMMAND='{ msg=$(history 1 | { read x y; echo $y; });logger -p local6.debug "[euid=$(/usr/ucb/whoami)]":$(who am i):[`pwd`]"$msg"; }'
fi

