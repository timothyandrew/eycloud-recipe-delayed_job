class Chef
  class Recipe
    def delayed_job_applications
      node[:applications]
    end
  end
end
