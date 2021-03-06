#!/bin/sh
# -----------------
# Setup Variables #
# -----------------

# Your System name
SYSTEM_NAME="Yoyodyne Propulsion Systems"
SYSTEM_NAME_DOUBLE_SPACED=`echo ${SYSTEM_NAME} | sed "s/\(.\)/\1 /g" | sed "s/ $//"`

# Project Administrator name
PROJECT_ADMINISTRATOR="Chiclitz, Clayton"

# Project Administratot Organization
ORGANIZATION_ADMINISTRATOR="Yoyodyne"

# Your Account name
### TODO : has to start with an upper case letter 
ACCOUNT_NAME="Clayton"

# Your Account password
### TODO: Check length and valid characters (8, [a-zA-Z0-9] ? )
ACCOUNT_PASSWORD="password"

# Your name and organization
NAME="Chiclitz, Clayton"
# N.B.: This must be a string of exactly the form <lastname>, <firstname>. The script
# fails if you have more than one token for <lastname> or <firstname>. For example,
# Von Schraeber, Johan will not work. 
ORGANIZATION="Yoyodyne"

TIME_ZONE=`date | cut -f 5 -d " " | tr A-Z a-z`

cat <<EOF
attach -r tape0 12.6fMULTICS.tap
attach disk0 root.dsk

set debug stdout

autoinput rpv a11 ipc 3381 0a\n

; bce (early) 0000.0: M->
autoinput bce\n
;Current system time is: Friday, July 22, 1994 20:01:28 pdt.
;Is this correct? M-> 
autoinput y\n
; boot_delta ok?
autoinput y\n

; bce (boot)
autoinput y\n

; bce (early)
autoinput boot star\n

; set time zone
autoinput stz ${TIME_ZONE}\n

autoinput admin\n

autoinput pause 30\n

autoinput cwd >sc1\n

;;;
;;; System name
;;;

autoinput ed_installation_parms\n
autoinput change installation_id\n
autoinput ${SYSTEM_NAME}\n
autoinput change titles\n
autoinput ${SYSTEM_NAME}\n
autoinput Multics\n
autoinput ${SYSTEM_NAME_DOUBLE_SPACED}\n
autoinput M u l t i c s\n
autoinput w\n
autoinput q\n

;;;
;;; Create User, SysEng and Guest load control groups
;;;

autoinput cwd >user_dir_dir>SysAdmin>a\n

autoinput ed_mgt\n
autoinput a SysEng 4.0\n
autoinput a User 4.0\n
autoinput a Guest 4.0\n
autoinput w\n
autoinput q\n
autoinput install MGT.mgt\n

autoinput pause 20\n

;;;
;;; Create SysEng project
;;;

autoinput ec master new_proj SysEng\n
; Title
autoinput System Engineering\n
; Investigator
autoinput ${PROJECT_ADMINISTRATOR}\n
; Inv. Address
autoinput ${ORGANIZATION_ADMINISTRATOR}\n
; Supervisor
autoinput \n
; Sup. Address
autoinput \n
; Phone
autoinput \n
; Account
autoinput \n
; Requisition
autoinput \n
; Amount
autoinput \n
; Cutoff date
autoinput \n
; Billing name
autoinput \n
; Billing address
autoinput \n
; Alias
autoinput se\n
; Project administrator
autoinput \n
; Absentee foreground cpu limit: 0
autoinput \n
; Authorization
autoinput \n
; Audit flags
autoinput \n
; Segment quota
autoinput 1000\n
; Directory quota
autoinput 100\n
; Rate structure
autoinput \n
; Default group
autoinput SysEng\n
; Authorized groups
autoinput SysEng\n
autoinput \n
; Attributes
;autoinput guaranteed_login,guar,dial,vinitproc,vhomedir,nostartup,preempting,save,multip,igroup,save_pdir,disconnect_ok\n
autoinput \n
; Grace
autoinput \n
; Minimum login ring
autoinput 1\n
; Maximum login ring
autoinput \n
; Maximum pdir quota
autoinput \n
; Maximum foreground processes
autoinput 10\n
; Maximum background processes
autoinput 10\n
; Review
autoinput n\n
; Project directory logical volume
autoinput \n
; Enter initial list of users. Type "." to exit
autoinput ${ACCOUNT_NAME}\n
autoinput .\n

autoinput pause 20\n

;;;
;;; Create User project
;;;

autoinput ec master new_proj User\n
; Title
autoinput User\n
; Investigator
autoinput ${PROJECT_ADMINISTRATOR}\n
; Inv. Address
autoinput ${ORGANIZATION_ADMINISTRATOR}\n
; Supervisor
autoinput \n
; Sup. Address
autoinput \n
; Phone
autoinput \n
; Account
autoinput \n
; Requisition
autoinput \n
; Amount
autoinput \n
; Cutoff date
autoinput \n
; Billing name
autoinput \n
; Billing address
autoinput \n
; Alias
autoinput u\n
; Project administrator
autoinput \n
; Absentee foreground cpu limit: 0
autoinput \n
; Authorization
autoinput \n
; Audit flags
autoinput \n
; Segment quota
autoinput 1000\n
; Directory quota
autoinput 100\n
; Rate structure
autoinput \n
; Default group
autoinput User\n
; Authorized groups
autoinput User\n
autoinput \n
; Attributes
;autoinput guaranteed_login,guar,dial,vinitproc,vhomedir,nostartup,preempting,save,multip,igroup,save_pdir,disconnect_ok\n
autoinput \n
; Grace
autoinput \n
; Minimum login ring
autoinput \n
; Maximum login ring
autoinput \n
; Maximum pdir quota
autoinput \n
; Maximum foreground processes
autoinput 10\n
; Maximum background processes
autoinput 10\n
; Review
autoinput n\n
; Project directory logical volume
autoinput \n
; Enter initial list of users. Type "." to exit
autoinput ${ACCOUNT_NAME}\n
autoinput .\n

autoinput pause 20\n

;;;
;;; Add Guest project
;;;

autoinput ec master new_proj Guest\n
; Title
autoinput Guest\n
; Investigator
autoinput ${PROJECT_ADMINISTRATOR}\n
; Inv. Address
autoinput ${ORGANIZATION_ADMINISTRATOR}\n
; Supervisor
autoinput \n
; Sup. Address
autoinput \n
; Phone
autoinput \n
; Account
autoinput \n
; Requisition
autoinput \n
; Amount
autoinput \n
; Cutoff date
autoinput \n
; Billing name
autoinput \n
; Billing address
autoinput \n
; Alias
autoinput \n
; Project administrator
autoinput \n
; Absentee foreground cpu limit: 0
autoinput \n
; Authorization
autoinput \n
; Audit flags
autoinput \n
; Segment quota
autoinput 1000\n
; Directory quota
autoinput 100\n
; Rate structure
autoinput \n
; Default group
autoinput Guest\n
; Authorized groups
autoinput Guest\n
autoinput \n
; Attributes
;autoinput guaranteed_login,preempting,save,multip,igroup,save_pdir,disconnect_ok\n
autoinput \n
; Grace
autoinput \n
; Minimum login ring
autoinput \n
; Maximum login ring
autoinput \n
; Maximum pdir quota
autoinput \n
; Maximum foreground processes
autoinput 10\n
; Maximum background processes
autoinput 10\n
; Review
autoinput n\n
; Project directory logical volume
autoinput \n
; Enter initial list of users. Type "." to exit
autoinput *\n
autoinput .\n

autoinput pause 20\n

autoinput ec master pmf SysEng\n
; Do you want to delete?
autoinput n\n
autoinput /Attr/\n
autoinput s/;/, guaranteed_login,guar,dial,preempting,save,multip;/\n
autoinput s/;/,save_pdir,disconnect_ok;/\n
autoinput w\n
autoinput q\n

autoinput pause 20\n

;;;
;;; Add user Myaccount
;;;

autoinput ec master register\n
autoinput ${NAME}\n
autoinput ${ORGANIZATION}\n
autoinput 1\n
autoinput \n
autoinput SysEng\n
autoinput ${ACCOUNT_PASSWORD}\n
autoinput ${ACCOUNT_PASSWORD}\n
autoinput ${ACCOUNT_PASSWORD}\n
autoinput ${ACCOUNT_PASSWORD}\n
autoinput n\n
autoinput ${ACCOUNT_NAME}\n
autoinput y\n
autoinput n\n

autoinput pause 30\n

autoinput y\n

; Setup HFED project

autoinput ec master pmf HFED\n
autoinput /Initproc/\n
autoinput s/process_overseer_/tolts_overseer_/\n
autoinput w\n
autoinput q\n

autoinput ec master upmf SysAdmin ${ACCOUNT_NAME}\n
autoinput ec master upmf HFED ${ACCOUNT_NAME}\n

autoinput pause 20\n
autoinput ame\n

;;;
;;; Set the MOTD
;;;

;autoinput motd\n
;autoinput a\n
;autoinput \n
;autoinput Welcome to the '${SYSTEM_NAME}' System.\n
;autoinput This system is for historical and academic research only.\n
;autoinput This system is a testing system. In order to improve the\n
;autoinput system\c your data and usage may be examined. Please do not\n
;autoinput assume confidentialty\c data preservation or accessibility.\n
;autoinput \n
;autoinput Historical Background\n
;autoinput \n
;autoinput This edition of the Multics software materials and documentation is provided\n
;autoinput and donated to Massachusetts Institute of Technology by Group BULL including\n
;autoinput BULL HN Information Systems Inc. as a contribution to computer science\n
;autoinput knowledge. This donation is made also to give evidence of the common\n
;autoinput contributions of Massachusetts Institute of Technology, Bell Laboratories,\n
;autoinput General Electric, Honeywell Information Systems Inc., Honeywell BULL Inc.,\n
;autoinput Groupe BULL and BULL HN Information Systems Inc. to the development of this\n
;autoinput operating system.\n
;autoinput \n
;autoinput Multics development was initiated by Massachusetts Institute of Technology\n
;autoinput Project MAC (1963-1970), renamed the MIT Laboratory for Computer Science and\n
;autoinput Artificial Intelligence in the mid 1970s, under the leadership of Professor\n
;autoinput Fernando Jose Corbato. Users consider that Multics provided the best software\n
;autoinput architecture for managing computer hardware properly and for executing\n
;autoinput programs. Many subsequent operating systems incorporated Multics principles.\n
;autoinput \n
;autoinput Multics was distributed in 1975 to 2000 by Group Bull in Europe, and in the\n
;autoinput U.S. by Bull HN Information Systems Inc., as successor in interest by change\n
;autoinput in name only to Honeywell Bull Inc. and Honeywell Information Systems Inc.\n
;autoinput \n
;autoinput -----------------------------------------------------------\n
;autoinput \n
;autoinput Permission to use, copy, modify, and distribute these programs and their\n
;autoinput documentation for any purpose and without fee is hereby granted, provided that\n
;autoinput the below copyright notice and historical background appear in all copies\n
;autoinput and that both the copyright notice and historical background and this\n
;autoinput permission notice appear in supporting documentation, and that the names of\n
;autoinput MIT, HIS, BULL or BULL HN not be used in advertising or publicity pertaining\n
;autoinput to distribution of the programs without specific prior written permission.\n   
;autoinput Copyright 1972 by Massachusetts Institute of Technology\n       
;autoinput and Honeywell Information Systems Inc.\n   
;autoinput Copyright 2006 by BULL HN Information Systems Inc.\n   
;autoinput Copyright 2006 by Bull SAS\n   
;autoinput All Rights Reserved\n
;autoinput \wf\n
;autoinput w\n
;autoinput q\n

;;;
;;; Quotas
;;;

autoinput admin\n
autoinput mq >udd 100000\n
autoinput mq >udd>SysEng 80000\n
autoinput ame\n

;;;
;;; Pause to let background tasks to come up to speed.
;;;

autoinput admin\n
autoinput pause 60\n
autoinput ame\n

;;;
;;; Patch login ring limits
;;;

autoinput admin\n
autoinput cwd >udd>sa>a\n
autoinput ac xf pmf SysEng.pmf\n
autoinput qedx\n
autoinput r SysEng.pmf\n
autoinput /Attr/\n
autoinput a\n
autoinput Ring:  1,5,4;\n
autoinput \wf\n
autoinput /${ACCOUNT_NAME}/\n
autoinput a\n
autoinput ring: 1,5,4;\n
autoinput \wf\n
autoinput w\n
autoinput q\n
autoinput ac u pmf SysEng.pmf\n
autoinput cv_pmf SysEng.pmf\n
autoinput install SysEng.pdt\n
autoinput pause 20\n
autoinput ame\n

;;;
;;; Moved over from start_sve.ini
;;;

autoinput admin\n
autoinput sa >sc1>rcp>tapa**.acs rw *.*.*\n
autoinput sa >sc1>rcp>prta.acs rw *.*.*\n
autoinput sa >sc1>rcp>puna.acs rw *.*.*\n
autoinput sa >sc1>rcp>rdra.acs rw *.*.*\n
autoinput create >sc1>rcp>card_input_password.acs\n
autoinput sa >sc1>rcp>card_input_password.acs rw *.*.*\n
autoinput ame\n

;;;
;;; Setup some card reader stuff (AK50, chap 21)
;;;

autoinput admin\n
autoinput create >udd>SysEng>${ACCOUNT_NAME}>card_input.acs\n
autoinput sa >udd>SysEng>${ACCOUNT_NAME}>card_input.acs re reader.*.*\n
autoinput sa >udd>SysEng>${ACCOUNT_NAME}>card_input.acs rw ${ACCOUNT_NAME}.SysEng.*\n

autoinput create >sc1>rcp>reader.acs\n
autoinput sa >sc1>rcp>reader.acs re *.*.*\n
autoinput sa >sc1>rcp>reader.acs rew *.SysAdmin.*\n
autoinput ame\n

;;;
;;; logout everbody
;;;

autoinput logout * *\n

;;;
;;; Pause to let tasks logout
;;;

autoinput admin\n
autoinput pause 20\n
autoinput ame\n

;;;
;;; Shut it down
;;;

autoinput shut\n
autoinput y\n

autoinput \z

set opcon config=attn_hack=1

; sys_trouble start 34:3470 offset 12, 34:3502
sbr 34:3502; echo BCE_TRAP

boot iom0
quit
EOF
