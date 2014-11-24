#
# Cookbook Name:: fsagent
# Recipe:: default
#
# Copyright 2014, LUPO.ORG
#
# All rights reserved - Do Not Redistribute
#

#remove previous version of agent if exists
bash "check_fsagent" do
   user "root"
   cwd "/opt/firescope/agent"
   command "./Firescope_Agent_Uninstall.sh"
   only_if {File.exists?('/opt/firescope/agent/Firescope_Agent_Uninstall.sh')}
end
#remove previous version of agent if exists


#acquire agent installer

remote_file "/tmp/FSAgent.tar.gz" do
   source "http://localhost/firescope/FSAgent.tar.gz"
   notifies :run, "bash[install_fsagent]"
end

#run the installer

bash "install_fsagent" do
   user "root"
   cwd  "/tmp"
   code <<-EOH
    tar -zxf FSAgent.tar.gz 
    cd *0
    ./FireScope*Installer*.sh -A 10.0.22.36 > /var/tmp/FSagentinstall.log
    cd ..
    rm -rf FSAgent*
    rm -rf FireScope*Installer*
   EOH
   action :nothing
end

