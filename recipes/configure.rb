#
# Cookbook Name:: delayed_job
# Recipe:: configure
#

# This recipe will setup `delayed_job` on a Solo instance environment or on named Utility instances in a cluster environment. 
# Name your Utility instances with prefixes: `dj`, `delayed_job`, `delayedjob`. For example, `dj1`, `delayedjob4`.
if node[:instance_role] == "solo" || (node[:instance_role] == "util" && node[:name] !~ /^(dj|delayed_job|delayedjob)/)
  node[:applications].each do |app_name,data|
  
    # determine the number of workers to run based on instance size
    if node[:instance_role] == 'solo' || node[:instance_role] == 'eylocal'
      worker_count = 1
    else
      worker_count = get_delayed_job_worker_count
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