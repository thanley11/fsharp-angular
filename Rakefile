require 'bundler/setup'

require 'albacore'
require 'albacore/tasks/versionizer'
require 'albacore/ext/teamcity'

Albacore::Tasks::Versionizer.new :versioning

desc 'Perform fast build (warn: doesn\'t d/l deps)'
build :build do |b|
      b.logging = 'detailed'
      b.file     = Paths.join 'AngularSuave', 'AngularSuave.fsproj'
      b.target = ['Clean', 'Rebuild']
      b.nologo
      b.properties = {
        :deployonbuild => true
      }
end

desc 'restore all nugets as per the packages.config files'
nugets_restore :restore do |p|
      p.out = 'packages'
        p.exe = 'tools/nuget.exe'
end

#desc 'Perform full build'
#build :build => [:versioning, :restore] do |b|
#    b.sln = 'AngularSuave.sln'
    # alt: b.file = 'src/MyProj.sln'
#end
      
directory 'build/pkg'

task :default => :build

