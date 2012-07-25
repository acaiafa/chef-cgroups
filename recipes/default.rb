
# Cookbook Name:: cgroups
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#



unless node[:platform] == "redhat" and  node[:platform_version].to_i  != 6

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

if ::File.exists? "/etc/init.d/#{node[:cgroups][:service]}"
notifies :restart, "service[#{node[:cgroups][:service]}]"
end
end



template "/etc/cgrules.conf" do
  source "cgrules.conf.erb"
  variables(
    :users => node[:cgroups][:users]
)
notifies :restart, "service[cgred]"
notifies :restart, "service[cgconfig]"

if ::File.exists? "/etc/init.d/#{node[:cgroups][:service]}"
notifies :restart, "service[#{node[:cgroups][:service]}]"
end
end



service "#{node[:cgroups][:service]}"  do
only_if {::File.exists? "/etc/init.d/#{node[:cgroups][:service]}"}
end


service "cgconfig" do
  action [:enable]
end

service "cgred" do
  action [:enable]
end

end
