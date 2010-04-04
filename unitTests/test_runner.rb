require 'rubygems'
require 'rake'
require 'spec/rake/spectask'

Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['**/*_spec.rb']
  t.spec_files.each do |f|
    puts f.to_s
  end
  t.verbose = true
end
                        
task :default => :spec