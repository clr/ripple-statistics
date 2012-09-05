#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'rake'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/test_*.rb']
  t.verbose = true
end

namespace :test do
  desc "Test everything"
  task :all => [:test]
end

task :default => :test

namespace(:test_purposes_only) do
  task :create_data_points do
    ROOT_DIR = File.dirname(__FILE__)

    require File.join(ROOT_DIR,'test','environment')

    data = File.readlines(File.join(ROOT_DIR,'test','fixtures','data'))[ENV['ROW'].to_i]
    data.split(',').each do |value|
      DataDocument.create(:value => value.to_f)
    end
  end
end
