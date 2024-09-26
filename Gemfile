# frozen_string_literal: true
source "https://rubygems.org"

gem "activesupport", "~> 7.0.8"
gem "cocoapods", "1.13.0"

gem 'fastlane'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
