class Chef
  class Recipe
    def get_delayed_job_applications
      node[:applications]
    end
  end
end
