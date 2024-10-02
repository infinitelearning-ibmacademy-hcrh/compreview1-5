#!/bin/bash
student_data(){
    # Fill Student Data
    read -p "Enter Your Full Name: " name
    echo "$name" > /tmp/.name
    read -p "Enter Your IL Email (example@infinitelearningstudent.id): " email 
    echo "$email" > /tmp/.email
    read -p "Enter Your Mentor Name: " mentor
    echo "$mentor" > /tmp/.mentor
    echo ""
}

send_data(){
    exercise="COMPREVIEW1-5"
    mentor=$(cat /tmp/.mentor)
    name=$(cat /tmp/.name)
    email=$(cat /tmp/.email)  
    score=$(cat /tmp/.score)
    status=$(cat /tmp/.status)
    id="https://script.google.com/macros/s/AKfycbwzGvljewSH8mO7W-HB_LouH66esTunokhe8unYvVrG6k5ykf2SFmHLQ9KoKmmYqlrDFQ/exec"
    curl -X POST \
    "$id" \
    -d "exercise=$exercise" \
    -d "mentor=$mentor" \
    -d "name=$name" \
    -d "email=$email" \
    -d "total=$score" \
    -d "status=$status" &>/dev/null
}


lab_status(){
    echo -ne "\033[1mLAB Status: \033[0m"
    score=$(cat /tmp/.score)
    if [ "$score" == "12" ];then
        pass
        echo "PASS" > /tmp/.status
        send_data
    else
        fail
        echo "FAIL" > /tmp/.status
    fi
}
pass(){
    printf "\033[0;32m PASS \033[0m\n" 
}

fail(){
    printf "\033[0;31m FAIL \033[0m\n"
}
print_border() {
    local term_width
    term_width=$(tput cols)
    local border=$(printf "%0.s#" $(seq 1 $term_width))
    echo "$border"
}
print_header() {
        clear
        echo ""
        print_border
        echo ""
        echo ""
        echo "██╗███╗   ██╗███████╗██╗███╗   ██╗██╗████████╗███████╗          "
        echo "██║████╗  ██║██╔════╝██║████╗  ██║██║╚══██╔══╝██╔════╝          "
        echo "██║██╔██╗ ██║█████╗  ██║██╔██╗ ██║██║   ██║   █████╗            "
        echo "██║██║╚██╗██║██╔══╝  ██║██║╚██╗██║██║   ██║   ██╔══╝            "
        echo "██║██║ ╚████║██║     ██║██║ ╚████║██║   ██║   ███████╗          "
        echo "╚═╝╚═╝  ╚═══╝╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   ╚══════╝          "
        echo "                                                                "
        echo "██╗     ███████╗ █████╗ ██████╗ ███╗   ██╗██╗███╗   ██╗ ██████╗ "
        echo "██║     ██╔════╝██╔══██╗██╔══██╗████╗  ██║██║████╗  ██║██╔════╝ "
        echo "██║     █████╗  ███████║██████╔╝██╔██╗ ██║██║██╔██╗ ██║██║  ███╗"
        echo "██║     ██╔══╝  ██╔══██║██╔══██╗██║╚██╗██║██║██║╚██╗██║██║   ██║"
        echo "███████╗███████╗██║  ██║██║  ██║██║ ╚████║██║██║ ╚████║╚██████╔╝"
        echo "╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝ "
        echo "                                                                "
        echo ""
        echo -e "\033[1mCopyright Notice:\033[0m"
        echo "The lab material provided here is owned by Infinite Learning Indonesia and is protected by copyright law. Copying, distributing, or reusing this lab material without permission from the copyright owner may violate the law and subject you to applicable legal action. Please be aware that copying and distributing copyrighted works without permission can have serious legal consequences."
        echo ""
        print_border
        echo ""
}
print_header
if [ "$1" == "start" ]; then
        student_data
        if [ "$2" == "compreview1-5" ]; then
            useradd student &>/dev/null
            echo "student" | passwd --stdin student &>/dev/null
            su - student &>/dev/null
            echo "REMOVE_THIS_LINE" > /home/student/task4.txt
            echo "email=example@infinitelearningstudent.id" >> /home/student/task4.txt
            echo "#infinitelearning" >> /home/student/task4.txt
            echo -e "\e[1;42;97mLAB STARTED, Good Luck !!\e[0m"
            echo ""
        else
            echo "Exercise Content Not Found !!"
        fi
elif [ "$1" == "grade" ]; then
        if [ "$2" == "compreview1-5" ]; then
            echo -ne "task1.txt first line is current year ...."
            cat  /home/student/task1.txt | sed -n '1p' | grep "2024" &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi
            echo -ne "task1.txt second line is current user ...."
            cat  /home/student/task1.txt | sed -n '1p' | grep "student" &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi
            echo -ne "task1.txt third line is current working directory ...."
            cat  /home/student/task1.txt | sed -n '1p' | grep "/home/student" &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi
            echo -ne "Check task2.txt content ...."
            cat  /home/student/task2.txt | wc -l | grep "5" &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi
            echo -ne "Check task3.txt content ...."
            cat  /home/student/task3.txt | wc -l | grep "5" &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi
            echo -ne "Check project_plans directory and subdirectory content ...."
            ls project_plans/ | grep -e folder1 -e folder2 | wc -l | grep "2" &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi
            echo -ne "Check folder1 directory content ...."
            ls /home/student/project_plans/folder1 | wc -l | grep "12" &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi
            echo -ne "Check folder2/season1 directory content ...."
            ls /home/student/project_plans/folder2/season1 | wc -l | grep "6" &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi
            echo -ne "Check folder2/season2 directory content ...."
            ls /home/student/project_plans/folder2/season2 | wc -l | grep "6" &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi
            echo -ne "Check value of ENV_VARIABLE of student_homedir ...."
            echo ${student_homedir} | grep "/home/student" &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi

            email=$(cat /tmp/.email)
            echo -ne "Check task4.txt content ...."
            cat  /home/student/task4.txt | grep ${email} &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi
            echo -ne "Check removed line in task4.txt ...."
            cat  /home/student/task4.txt | wc -l | grep "2" &>/dev/null
            if [ $? -eq 0 ];then
                pass
                score=$(( score + 1 ))
            else
                fail
            fi
            echo ${score} > /tmp/.score
            lab_status
        else
            echo "Exercise Content Not Found !!"
        fi


        
elif [ "$1" == "finish" ]; then
        if [ "$2" == "compreview1-5" ]; then
           echo -ne "Finishning LAB....."
           pass
        else
            echo "Exercise Content Not Found !!"
        fi


else
        echo 'Usage:  lab [ACTION] [EXERCISE]'
        echo ''
        echo 'A lab script for "Infinite Learning x IBM Academy: Hybrid Cloud and Red Hat Student'
        echo ''
        echo 'Action:'
        echo '  start            Prepare your lab environment and all required resources'
        echo '  grade            Asses your work, and shows a list of grading criteria'
        echo '  finish           Finish your work and restore VM state'
        echo '  validate         Validate your lab state'
        echo ''
        echo 'Run 'lab --help' or 'lab --usage' for more information on a command.'
        echo ''
        echo 'For more help on how to use this lab, contact the owner'
        echo ''
        echo ''
fi
