property :link_name, String, name_property: true
property :link, String, default: lazy { |n| "/usr/bin/#{n.link_name}" }
property :path, String
property :priority, [String, Integer], coerce: proc { |n| n.to_i }

action :install do
  raise 'missing :priority' unless new_resource.priority
  validate_path

  if path_priority != new_resource.priority
    converge_by("adding alternative #{new_resource.link} #{new_resource.link_name} #{new_resource.path} #{new_resource.priority}") do
      output = shell_out("#{alternatives_cmd} --install #{new_resource.link} #{new_resource.link_name} #{new_resource.path} #{new_resource.priority}")
      unless output.exitstatus == 0
        raise "failed to add alternative #{new_resource.link} #{new_resource.link_name} #{new_resource.path} #{new_resource.priority}"
      end
    end
  end
end

action :set do
  validate_path

  if current_path != new_resource.path
    converge_by("setting alternative #{new_resource.link_name} #{new_resource.path}") do
      output = shell_out("#{alternatives_cmd} --set #{new_resource.link_name} #{new_resource.path}")
      unless output.exitstatus == 0
        raise "failed to set alternative #{new_resource.link_name} #{new_resource.path} \n #{output.stdout.strip}"
      end
    end
  end
end

action :remove do
  validate_path

  if path_exists?
    converge_by("removing alternative #{new_resource.link_name} #{new_resource.path}") do
      shell_out("#{alternatives_cmd} --remove #{new_resource.link_name} #{new_resource.path}")
    end
  end
end

action :auto do
  converge_by("setting auto alternative #{new_resource.link_name}") do
    shell_out("#{alternatives_cmd} --auto #{new_resource.link_name}")
  end
end

action :refresh do
  converge_by("refreshing alternative #{new_resource.link_name}") do
    shell_out("#{alternatives_cmd} --refresh #{new_resource.link_name}")
  end
end

action_class do
  def alternatives_cmd
    if platform_family?('rhel', 'amazon', 'fedora')
      'alternatives'
    else
      'update-alternatives'
    end
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
    # https://rubular.com/r/IcUlEU0mSNaMm3
    escaped_path = Regexp.new(Regexp.escape("#{new_resource.path} - priority ") + '(.*)')
    match = shell_out("#{alternatives_cmd} --display #{new_resource.link_name}").stdout.match(escaped_path)

    match.nil? ? nil : match[1].to_i
  end

  def current_path
    # https://rubular.com/r/ylsuvzUtquRPqc
    match = shell_out("#{alternatives_cmd} --display #{new_resource.link_name}").stdout.match(/link currently points to (.*)/)
    match.nil? ? nil : match[1]
  end

  def path_exists?
    # https://rubular.com/r/ogvDdq8h2IKRff
    escaped_path = Regexp.new(Regexp.escape("#{new_resource.path} - priority"))
    shell_out("#{alternatives_cmd} --display #{new_resource.link_name}").stdout.match?(escaped_path)
  end
end
