## VIRTUAL KEYBOARD
this is the tool to using keyboard event via terminal

copy virtual_keyboard, virtyal_keyboard.o to "Usb root"

in terminal 
/ # cd /tmp/usb/sda/sda1/ 
/tmp/usb/sda/sda1 # ./virtual_keyboard.sh 
Please select the input event (/dev/input/event%d) : 1

#or if internet is connected, "9"

Please select the input event (/dev/input/event%d) : 9


#
# you can see the input list using command as below.
# cat /proc/bus/input/devices
# normal input is "1". but it can't enter "!@#$%^&*()" characters. 
# if your target device connect Ethernet. 
# recommand "9" input devices ( IoT KeyPad). It can enter "!@#$%^&*()"
#
# ESC       - EXIT
# HOME      - XSTUDIO
# INSERT    - IN START
# ENTER     - OK
# DELETE    - IN STOP
# PAGE_UP   - CH UP
# PAGE_DN   - CH DN
# F1        - VOL UP
# F2        - VOL DN
# 
# Other Key - same as keyboard event 


## VIRTUAL MOUSE
this is the tool to using virtual mouse event via terminal (using Keyboard)

copy mouse.sh to "Usb root"
/ # cd /tmp/usb/sda/sda1/ 
/tmp/usb/sda/sda1 # ./mouse.sh

# press the direction keys in keyboard. the cursor in TV will move. 
# ENTER     - CLICK

