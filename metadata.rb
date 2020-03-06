name 'alternatives'
maintainer 'Virender Khatri'
maintainer_email 'vir.khatri@gmail.com'
license 'Apache-2.0'
description 'Provides Chef LWRP alternatives'
version '0.2.0'
source_url 'https://github.com/vkhatri/chef-alternatives'
issues_url 'https://github.com/vkhatri/chef-alternatives/issues'
chef_version '>= 12.1'

%w(debian ubuntu centos amazon redhat fedora).each do |os|
  supports os
end
