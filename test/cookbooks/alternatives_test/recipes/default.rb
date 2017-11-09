#
# Cookbook:: alternatives_test
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

file '/usr/local/sample-binary-1' do
  content '#!/bin/bash
  echo sample-binary-v1
  '
  mode 0o500
end

file '/usr/local/sample-binary-2' do
  content '#!/bin/bash
  echo sample-binary-v2
  '
  mode 0o550
end

alternatives 'sample-binary v1' do
  link_name 'sample-binary'
  path '/usr/local/sample-binary-1'
  priority 100
  action :install
end

alternatives 'sample-binary v2' do
  link_name 'sample-binary'
  path '/usr/local/sample-binary-2'
  priority 101
  action :install
end

alternatives 'set sample-binary v1' do
  link_name 'sample-binary'
  path '/usr/local/sample-binary-1'
  action :set
end

alternatives 'sample-binary-test v1' do
  link_name 'sample-binary-test'
  path '/usr/local/sample-binary-1'
  priority 100
  action :install
end

alternatives 'sample-binary-test v1' do
  link_name 'sample-binary-test'
  path '/usr/local/sample-binary-1'
  action :remove
end
