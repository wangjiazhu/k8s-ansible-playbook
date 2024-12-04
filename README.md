# ansible-playbook部署k8s集群

* 安装ansible

    参考：https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#id12

* 添加hosts主机

    进入k8s-ansible-playbook目录，找到hosts文件，添加如下内容：
    ```yaml
    [controller]
    master-01-ipaddr
    master-02-ipaddr
    ...
    master-xx-ipaddr

    [worker]
    worker-01-ipaddr
    worker-02-ipaddr
    ...
    worker-yy-ipaddr
    ```
* 执行命令
    ```bash
    # 升级内核
    # 1.测试剧本
    ansibe-playbook -C opeartors/update_kernel.yaml -i hosts -e "target_hosts='cotroller,worker'"
    # 2.执行剧本升级内核
    ansibe-playbook opeartors/update_kernel.yaml -i hosts -e "target_hosts='cotroller,worker'"
    
    
    # 初始化k8s节点环境
    # 1.测试剧本
    ansibe-playbook -C opeartors/add_k8s_node.yaml -i hosts -e "target_hosts='cotroller,worker'"
    # 2.执行剧本初始化k8s节点
    ansibe-playbook opeartors/add_k8s_node.yaml -i hosts -e "target_hosts='cotroller,worker'"
    ```