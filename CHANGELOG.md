# alternatives CHANGELOG

This file is used to list changes made in each version of the alternatives cookbook.

0.3.0
-----

- Tim Smith - Switch to why-run capable assertions

- Tim Smith - Remove unused method and convert path_priority to a regex

- Tim Smith - Use ruby instead of grep/sed and set a lazy default value

- Tim Smith - Remove the helpers and move logic directly into the action

- Tim Smith - Remove usage of new_resource.updated_by_last_action

- Tim Smith - Test on all current versions of Chef Infra Client

- Tim Smith - Make sure it all passes

- Tim Smith - Update the readme

- Tim Smith - Remove the Rakefile

- Tim Smith - Fix the platform family logic

- Tim Smith - Test in Travis with Workstation and Delivery local mode

- Tim Smith - Remove the default recipe from the dokken config

- Tim Smith - Warn that the recipe doesn't do anything

- Tim Smith - Convert the libraries to the a custom resource

- Tim Smith - Remove the .foodcritic file and .rubocop.yml

- Tim Smith - Add real suites to the kitchen.yml

- Tim Smith - Make the test cookbook dep on the alternatives cookbook

- Tim Smith - Remove extra parts of the test cookbook

- Tim Smith - Add all the modern platforms to the kitchen.yml

- Tim Smith - Remove the Vagrantfile since there's a Kitchen config

- Tim Smith - Add a delivery local mode config

- Tim Smith - Require Chef 12.11 and update the kitchen config

- Tim Smith - Cookstyle fixes from 6.0 master

- Virender Khatri - Removed Gemfile

0.2.0
-----

- Virender Khatri - fixed README for #1 [ci skip]

- Virender Khatri - added inspec, travis, kitchen dokken, test cookbook

- Virender Khatri - attribute link is not required

- Virender Khatri - lint fix

0.1.1
-----

- Virender Khatri - updated README for correct cookbook version

0.1.0
-----

- Virender Khatri - initial release of alternatives

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.
