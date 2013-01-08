#
# Cookbook Name:: delayed_job
# Recipe:: install
#

# This recipe will setup `delayed_job` on the app_master instance
if node[:instance_role] == "app_master"
  delayed_job_applications().each do |app_name,data|
  
    directory "/engineyard/bin" do
      owner "root"
      group "root"
      mode 0755
    end

    template "/engineyard/bin/dj" do
      source "dj.erb"
      owner "root"
      group "root"
      mode 0755
    end
    
  end
end