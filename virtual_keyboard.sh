#!/bin/bash

read -p "Please select the input event (/dev/input/event%d) : " inputEvent

while IFS= read -rsn1 k # Read one key (first byte in key press)
do
    case "$k" in
    [[:graph:]])
        # Normal input handling
        k=$(printf '%d' "'$k")
        echo KeyCode : $k
        ;;
    "") # Enter
        echo Enter pressed!
        k=10
        ;;
    $'\x20') # space
        echo Space pressed!
        k=32
        ;;  
    $'\b') # Back-Space
        # Routine for back-space
        echo BackSpace pressed!
        k=127
        ;;
    $'\x7f') # Back-Space
        # Routine for back-space
        echo BackSpace pressed!
        k=127
        ;; 
    $'\t') # tab
        k=10001
	    echo Tab pressed!
	    ;;
    $'\x1b') # ESC
        read -rsn1 k
        [ "$k" == $'\x1b' ] && echo "esc!!" && k=27     # Esc-Key
        [ "$k" == "[" ] && read -rsn1 k
        [ "$k" == "O" ] && read -rsn1 k
        echo "$k"
        case "$k" in
        A) # Up
            k=27917965
            ;;
        B) # Down
            k=27917966
            ;;
        C) # Right
            k=27917967
            ;;
        D) #Left
            k=27917968
            ;;
        H) #Home
            k=27917969
            ;;
        2) #Insert
            read -rsn1 k
            k=27917970
            ;;
        3) #Delete
            read -rsn1 k
            k=27917971
            ;;
        5) #Page-Up
            read -rsn1 k
            k=27917973
            ;;
        6) #Page-Down
            read -rsn1 k
            k=27917974
            ;;
        #F) #End
        #    k=27917975
        #    ;;
        P) #F1
            k=27917976
            ;;
        Q) #F2
            k=27917977
            ;;
        esac
        #read -rsn4 -t .1 # Try to flush out other sequences ...
    
    esac
    ./virtual_keyboard $inputEvent $k
done