property :link_name, String, name_property: true
property :link, String
property :path, String
property :priority, [String, Integer]

action :install do
  alternatives_install
end

action :set do
  alternatives_set
end

action :remove do
  alternatives_remove
end

action :auto do
  alternatives_auto
end

action :refresh do
  alternatives_refresh
end

action_class do
  def alternatives_cmd
    if platform_family?('rhel') || platform_family?('centos')
      'alternatives'
    else
      'update-alternatives'
    end
  end

  def link_path
    new_resource.link ? new_resource.link : "/usr/bin/#{new_resource.link_name}"
  end

  def validate_path
    unless new_resource.path
      raise "could not set alternatives for #{new_resource.link_name}, must provide :path"
    end
    unless ::File.exist?(new_resource.path)
      raise "could not set alternatives for #{new_resource.link_name}, missing #{new_resource.path}"
    end
  end

  def path_priority
    output = shell_out("#{alternatives_cmd} --display #{new_resource.link_name} | grep #{new_resource.path} | sed -n -e 's/^.*priority //p'")
    if output.exitstatus == 0
      output = output.stdout.strip
      if output.empty?
        nil
      else
        output.to_i
      end
    end
  end

  def current_path
    output = shell_out("#{alternatives_cmd} --display #{new_resource.link_name} | sed -n -e 's/^.*link currently points to //p'")
    if output.exitstatus == 0
      output = output.stdout.strip
      if output.empty?
        nil
      else
        output
      end
    end
  end

  def path_exists
    shell_out("#{alternatives_cmd} --display #{new_resource.link_name} | grep priority | grep #{new_resource.path}").exitstatus == 0
  end

  def link_name
    new_resource.link || "/usr/bin/#{new_resource.link_name}"
  end

  def alternatives_install
    raise 'missing :priority' unless new_resource.priority
    validate_path
    priority = path_priority
    link = link_name
    if priority != new_resource.priority
      converge_by("adding alternative #{link} #{new_resource.link_name} #{new_resource.path} #{new_resource.priority}") do
        output = shell_out("#{alternatives_cmd} --install #{link} #{new_resource.link_name} #{new_resource.path} #{new_resource.priority}")
        unless output.exitstatus == 0
          raise "failed to add alternative #{link} #{new_resource.link_name} #{new_resource.path} #{new_resource.priority}"
        end
      end
      new_resource.updated_by_last_action(true)
    end
  end

  def alternatives_set
    validate_path
    path = current_path
    if path != new_resource.path
      converge_by("setting alternative #{new_resource.link_name} #{new_resource.path}") do
        output = shell_out("#{alternatives_cmd} --set #{new_resource.link_name} #{new_resource.path}")
        unless output.exitstatus == 0
          raise "failed to set alternative #{new_resource.link_name} #{new_resource.path} \n #{output.stdout.strip}"
        end
      end
      new_resource.updated_by_last_action(true)
    end
  end

  def alternatives_remove
    validate_path
    if path_exists
      converge_by("removing alternative #{new_resource.link_name} #{new_resource.path}") do
        output = shell_out("#{alternatives_cmd} --remove #{new_resource.link_name} #{new_resource.path}")
        new_resource.updated_by_last_action(true) if output.exitstatus == 0
      end
    end
  end

  def alternatives_refresh
    converge_by("refreshing alternative #{new_resource.link_name}") do
      output = shell_out("#{alternatives_cmd} --refresh #{new_resource.link_name}")
      new_resource.updated_by_last_action(true) if output.exitstatus == 0
    end
  end

  def alternatives_auto
    converge_by("setting auto alternative #{new_resource.link_name}") do
      output = shell_out("#{alternatives_cmd} --auto #{new_resource.link_name}")
      new_resource.updated_by_last_action(true) if output.exitstatus == 0
    end
  end
end