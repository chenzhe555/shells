#/bin/bash
# Author: 376811578@qq.com
# Function:
#   管理并登录服务器

#服务器地址，账号，密码，端口，描述
Server_Host=(
    [0]='192.168.253.100'
)

Server_User=(
    [0]='chenzhe'
)

Server_Password=(
    [0]='haohaizi'
)

Server_Port=(
    [0]='22'
)

Server_Description=(
    [0]='这里是描述'
)

#服务器数量
Server_Count=${#Server_User[@]}

#输出服务器选项
screen_echo() {
    printf "%-7s |" '序号'
    printf "%-18s |" '主机地址'
    printf "%-12s |" '端口'　
    printf "%-30s\n" '说明'

    for((i=0; i<$Server_Count; ++i))
    do
     printf "\e[31m %-5s\e[0m" "$i"
     printf "%-15s " "${Server_Host[$i]}"
     printf "%-7s " "${Server_Port[$i]}"
     printf "\033[36m %-30s \033[0m\n" "${Server_Description[$i]}"  
    done
}

screen_echo

#输入服务器连接
while true
do
    read -p '请输入要登陆的服务器序号: ' Server_Number

    # 输入是否为空格或者回车。
    if [ ! ${Server_Number} ]
    then
        echo '请输入序号'
        continue
    fi

    # 输入是不是数字。
    if [[ "${Server_Number}" =~ [^0-9]+ ]]
    then
        echo '序号必须是数字'
        continue
    fi

    # 输入是否为0-Server_Number的数字。
    if [[ "${SERVER_NUM}" =~ ^0[0-9]+ ]] || [ ${Server_Number} -ge ${Server_Count} ] || [ ${Server_Number} -lt 0 ]
    then
        echo '请输入存在的序号'
        continue
    fi

    break

done

# 登陆
auto_login_ssh () {
    # spawn : -noecho 意思为终端中不显示 spawn .. ssh ... 等信息，不加此参数会有输出； -o StrictHostKeyChecking=no 不提示认证
    # *yes/no*  意思为 ssh 后如果返回的信息当中包含 yes/no，而 *password* 就是代表 ssh 后如果返回的信息当中包含 password
    # send 意思为发送信息
    # exp_continue 意思为继续执行下面的匹配
    # interact 意思为留在远程终端上面。如果不写此语句，自动退出服务器
    expect -c "
        spawn -noecho ssh -o StrictHostKeyChecking=no $1@$2 -p $3;
        expect { 
            *yes/no* {
                send yes\r
                exp_continue
            }
            *password* {
                send $4\r
            } 
        }
        interact;
    "; 
} 

auto_login_ssh ${Server_User[$Server_Number]} ${Server_Host[$Server_Number]} ${Server_Port[$Server_Number]} ${Server_Password[$Server_Number]}
