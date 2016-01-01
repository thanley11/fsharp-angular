require 'bundler/setup'

require 'albacore'
# require 'albacore/tasks/release'
require 'albacore/tasks/versionizer'
require 'albacore/ext/teamcity'

Albacore::Tasks::Versionizer.new :versioning

desc 'Perform fast build (warn: doesn\'t d/l deps)'
build :build do |b|
  b.file     = Paths.join 'AngularSuave', 'AngularSuave.fsproj'
  b.target =['Clean', 'Rebuild']
  b.logging = 'detailed'
  b.nologo
  b.properties = {
        :deployonbuild => true
      }
end

task :paket_bootstrap do
system 'tools/paket.bootstrapper.exe', clr_command: true unless   File.exists? 'tools/paket.exe'
end

desc 'restore all nugets as per the packages.config files'
task :restore => :paket_bootstrap do
  system 'tools/paket.exe', 'restore', clr_command: true
end

desc 'Perform full build'
build :compile => [:versioning, :restore] do |b|
  b.sln = 'AngularSuave.sln'
end

directory 'build/pkg'

task :default => :build
