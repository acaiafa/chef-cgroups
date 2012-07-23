
# Cookbook Name:: cgroups
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


package "libcgroup" do
  action :install
end



template "/etc/cgconfig.conf" do
   source "cgconfig.conf.erb"
   variables(
    :controllers => node[:cgroups][:controllers],
    :parameters => node[:cgroups][:parameters]
      )  
notifies :restart, "service[cgconfig]"
notifies :restart, "service[cgred]"
notifies :restart, "service[#{node[:cgroups][:service]}]"
end


template "/etc/cgrules.conf" do
  source "cgrules.conf.erb"
  variables(
    :users => node[:cgroups][:users]
)
notifies :restart, "service[cgred]"
notifies :restart, "service[cgconfig]"
notifies :restart, "service[#{node[:cgroups][:service]}]"
end


service "#{node[:cgroups][:service]}"  do
end


service "cgconfig" do
  action [:enable]
end

service "cgred" do
  action [:enable]
end


