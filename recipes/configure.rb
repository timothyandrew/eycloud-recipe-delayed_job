#
# Cookbook Name:: delayed_job
# Recipe:: configure
#

# This recipe will setup `delayed_job` on the app_master instance
if node[:instance_role] == "app_master"
  delayed_job_applications().each do |app_name,data|
  
    # determine the number of workers to run based on instance size
    if node[:instance_role] == 'solo' || node[:instance_role] == 'eylocal'
      worker_count = 1
    else
      worker_count = delayed_job_worker_count(node[:ec2][:instance_type])
    end
    
    worker_count.times do |count|
      template "/etc/monit.d/delayed_job#{count+1}.#{app_name}.monitrc" do
        source "dj.monitrc.erb"
        owner "root"
        group "root"
        mode 0644
        variables({
          :app_name => app_name,
          :user => node[:owner_name],
          :worker_name => "delayed_job#{count+1}",
          :framework_env => node[:environment][:framework_env]
        })
      end
    end
    
  end
end