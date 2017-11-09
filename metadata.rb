name 'alternatives'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache-2.0'
description 'Provides Chef LWRP alternatives'
long_description 'Provides CHEF LWRP alternatives'
version '0.2.0'
source_url 'https://github.com/vkhatri/chef-alternatives' if respond_to?(:source_url)
issues_url 'https://github.com/vkhatri/chef-alternatives/issues' if respond_to?(:issues_url)
chef_version '>= 12.1' if respond_to?(:chef_version)

%w[debian ubuntu centos amazon redhat fedora].each do |os|
  supports os
end
