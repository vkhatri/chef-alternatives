alternatives Cookbook
================

[![Cookbook](https://img.shields.io/github/tag/vkhatri/chef-alternatives.svg)](https://github.com/vkhatri/chef-alternatives) [![Build Status](https://travis-ci.org/vkhatri/chef-alternatives.svg?branch=master)](https://travis-ci.org/vkhatri/chef-alternatives)

This is a [Chef] cookbook to manage Linux cmd alternatives using alternatives/update-alternatives.

>> For Production environment, always prefer the [most recent release](https://supermarket.chef.io/cookbooks/alternatives).

## Most Recent Release

```ruby
cookbook 'alternatives', '~> 0.2.0'
```

## From Git

```ruby
cookbook 'alternatives', github: 'vkhatri/chef-alternatives',  tag: "v0.2.0"
```

## Repository

```
https://github.com/vkhatri/chef-alternatives
```

## Supported Platforms

- CentOS
- Fedora
- Amazon
- Ubuntu
- Debian


## LWRP alternatives

LWRP `alternatives` install/remove/set/refresh/auto binary alternatives.

**LWRP install alternative**

```ruby
alternatives 'python install 2' do
  link_name 'python'
  path '/usr/bin/python2.7'
  priority 100
  action :install
end
```

**LWRP set alternative**

```ruby
alternatives 'python set version 3' do
  link_name 'python'
  path '/usr/bin/python3'
  action :set
end
```

**LWRP auto alternative**

```ruby
alternatives 'python auto' do
  link_name 'python'
  action :auto
end
```

**LWRP refresh alternative**

```ruby
alternatives 'python refresh' do
  link_name 'python'
  action :refresh
end
```

**LWRP remove alternative**

```ruby
alternatives 'python remove' do
  link_name 'python'
  path '/usr/bin/python3'
  action :remove
end
```


**LWRP Options**

- *action* (optional) - default `:install`, options: :install, :remove, :set, :auto, :refresh
- *link_name* (optional, String)  - default `@name`, alternatives link name
- *link* (optional, String)  - alternatives link
- *path* (optional, String)  - alternatives link path
- *priority* (optional, String)  - alternatives link path priority


## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests (`rake & rake knife`), ensuring they all pass
6. Write new resource/attribute description to `README.md`
7. Write description about changes to PR
8. Submit a Pull Request using Github


## Copyright & License

Authors:: Virender Khatri and [Contributors]

<pre>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
</pre>


[Chef]: https://www.chef.io/
[Contributors]: https://github.com/vkhatri/chef-alternatives/graphs/contributors
