$: << File.dirname(__FILE__) + "/lib"

require "mfi"

task :default => :sample

task :env do
  @mpower = MFi::MPower.new(
    :host => ENV["HOST"],
    :user => ENV["USER"],
    :pass => ENV["PASS"]
  )
end

task :sample => :env do
  @mpower.connect!
  @mpower.sample.each { |reading|
    puts reading
  }
end

task :switch_off => :env do
  @mpower.connect!
  @mpower.switch_off
end

task :switch_on => :env do
  @mpower.connect!
  @mpower.switch_on
end