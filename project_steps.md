# This shows the steps it takes to automate virtual machines using vagrant and also installing LAMP stack and laravel on our machine
`1. we would automate the provisioning of our virtual machine, we would open a blank folder and run the command so we can place a vagrantfile there`
![configure your virtual machine](./cloud-second-semester-examination/vagrant%20init.PNG)

`2. after the vagrantfile has been placed in the directory, we would edit it to power up our multiple virtual machines`
![configure multiple virtual machines](./cloud-second-semester-examination/configure%20your%20vagrantfile.PNG)

`3. load the vms, using vagrant up`
![vagrant up](./cloud-second-semester-examination/run%20vagrant%20up%20to%20load%20the%20vms.PNG)

`4. Then we log into our master node using vagrant ssh masternode, this will be after we have done vagrant up to download the virtual boxes`
![vagrant ssh](./cloud-second-semester-examination/logged%20into%20master%20node%20now.PNG)

`5, we would also log in inside the slave node and go into /etc/ssh/sshd_config to do some editing so we can ssh into the slave node from the master, here we would be changing passwordAuthentication to yes and also pubkeyAuthentication to ye`
![edit sshd_config file](./cloud-second-semester-examination/turn%20on%20passwordAuthentication%20on%20slave%20mode.PNG)

`6. we would now restart the sshd so that the new configuration can take effect`
![restart sshd](./cloud-second-semester-examination/restart%20sshd%20service%20on%20slave.PNG)

`7. Go back to your master node to generate pubkey and private key on it, you will cd into .ssh directory then generate the key there`
![ssh-keygen](./cloud-second-semester-examination/key%20generated.PNG)

`8. copy the pubkey generated into the authorized_key directory of the slave node by using the ssh-copy-id command inside of your .ssh directory, you will need the user in the slave node and its ip address. Also you will be asked of fingerprint and its password`
![ssh-copy-id](./cloud-second-semester-examination/copy%20pub%20key%20to%20slave.PNG)

`9. let us now install ansible on our master node`
![sudo apt install ansible](./cloud-second-semester-examination/install%20ansible.PNG)

`10. check if ansible was installed successfully, then create an inventory file inside of the ansible directory, make sure you add the ip address of the slave node inside of the inventory file you just created`
![ansible --version](./cloud-second-semester-examination/create%20inventory%20file.PNG)

`11. try to ping the slave node from your master node to be sure your connection is working`
![ansible slave -i inventory -m ping](./cloud-second-semester-examination/ping%20the%20slave.PNG)

`12. create your playbook inside of your ansible directory`
![create your playbook](./cloud-second-semester-examination/created%20my%20playbook.PNG)

`13. create your bash script inside of your home directory`
![create your bash script](./cloud-second-semester-examination/create%20a%20LAMP%20script.PNG)

`14. give execution permission the bash script`
![](./cloud-second-semester-examination/give%20execution%20permission%20to%20the%20script.PNG)

## we now want to deploy our bash script to run on our slave node now

`1. we would now change directory in our ansible folder and run our playbook now`
![running our ansible playbook](./cloud-second-semester-examination/running%20our%20bashscript%20on%20the%20slave.PNG)

`2. waiting for our playbook to finish running on the slave node`
![script running](./cloud-second-semester-examination/script%20running%20to%20install%20on%20the%20slave.PNG)

`3. apache2 default page already rendered`
![apache2 webserver running](./cloud-second-semester-examination/script%20already%20rendering%20apache2%20default%20page.PNG)

`4. waiting for our database to fully be activated by generating the app key`
![app key](./cloud-second-semester-examination/waiting%20to%20generate%20app%20key.PNG)

`5. script was successfully ran on the slave node`
![success](./cloud-second-semester-examination/successfully%20deployed.PNG)

`6. our laravel landing page was a success`
![landing page](./cloud-second-semester-examination/final%20laravel%20landing%20page.PNG)

