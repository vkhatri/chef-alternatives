class Chef
  class Resource
    # provides alternatives
    class Alternatives < Chef::Resource
      identity_attr :name

      default_action :display
      allowed_actions %i(install remove auto set refresh nothing)

      resource_name :alternatives
      provides :alternatives

      def initialize(name, run_context = nil)
        super
        @provider = Chef::Provider::Alternatives
        @name = name
      end

      def link_name(arg = nil)
        set_or_return(
          :link_name, arg,
          kind_of: String,
          default: @name
        )
      end

      def link(arg = nil)
        set_or_return(
          :link, arg,
          kind_of: String,
          default: nil
        )
      end

      def path(arg = nil)
        set_or_return(
          :path, arg,
          kind_of: String,
          default: nil
        )
      end

      def priority(arg = nil)
        set_or_return(
          :priority, arg,
          kind_of: [String, Integer],
          default: nil
        )
      end
    end
  end
end
