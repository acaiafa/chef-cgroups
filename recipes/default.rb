#
# Cookbook Name:: Cgroups
# Recipe:: default
#
# Author:: Eugenio Marzo <eugenio.marzo@yahoo.it>
# Copyright 2012, Eugenio Marzo
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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
