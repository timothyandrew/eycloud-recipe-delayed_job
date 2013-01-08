#
# Cookbook Name:: delayed_job
# Recipe:: restart
#

# This recipe will setup `delayed_job` on the app_master instance
if node[:instance_role] == "app_master"
  delayed_job_applications().each do |app_name,data|
    
    execute "monit-reload-restart" do
      command "sleep 30 && monit reload && monit restart all -g dj_#{app_name}"
      action :run
    end
      
  end
end