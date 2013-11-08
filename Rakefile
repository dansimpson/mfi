$: << File.dirname(__FILE__) + "/lib"

require "mfi"
require "pp"

task :default => :sample

task :env do
  @mpower = MFi::MPower.new(
    :host => ENV["HOST"],
    :user => ENV["USER"],
    :pass => ENV["PASS"]
  )
end

task :enable => :env do
  @mpower.exec { |m|
    pp m.enable_read
    pp m.enable_write
  }
end

task :sample => :env do
  @mpower.exec { |m|
    m.sample.each { |reading|
      puts reading
    }
  }
end

task :switch_off => :env do
  @mpower.exec { |m|
    m.switch_off
  }
end

task :switch_on => :env do
  @mpower.exec { |m|
    m.switch_on
  }
end