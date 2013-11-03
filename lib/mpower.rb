module MFi

  class MPowerReading

    attr_accessor :port, :power, :relay, :enable, :energy, :current, :voltage, :powerfactor

    def initialize port, opts
      @port = port
      @enable = opts["enable"].to_i
      @relay = opts["relay"].to_i
      @power = opts["power"].to_f
      @energy = opts["energy"].to_f
      @current = opts["current"].to_f
      @voltage = opts["voltage"].to_f
      @powerfactor = opts["powerfactor"].to_f
    end

    def to_s
      "Port #{@port}: #{fmt(@power)}W (#{fmt(@powerfactor)}pf #{fmt(@current)}A #{fmt(@voltage)}V)"
    end

    def fmt v
      "%5.1f" % v
    end

  end

  class MPower

    attr_accessor :host, :user, :port

    #
    # Create MPower instance
    #
    # +opts+ connection options
    # host, pass and user are required for SSH
    #
    def initialize opts
      @host = opts[:host]
      @pass = opts[:pass]
      @user = opts[:user]
    end

    # Connect to the remote MPower device
    def connect!
      @ssh = Net::SSH.start(@host, @user, :password => @pass)
    end

    # Sample all metrics from the mPower device
    # +port+ the port option, default is all
    def sample port=-1
      data = run(:func => "powerList", :port => port)
      unless data.key?("value")
        raise "No data available"
      end

      data["value"].shift
      number = 0
      data["value"].map { |value| MPowerReading.new(number += 1, value) }
    end

    # Write enable port, allowing relay toggling
    # +port+ the port option, default is all
    def enable port=-1
      run(:func => "enableWrite", :port => port)
    end

    # Write disable port, disabling relay toggling
    # +port+ the port option, default is all
    def disable port=-1
      run(:func => "enableRead", :port => port)
    end

    # Switch off, or disable power on a given port
    # +port+ the port option, default is all
    def switch_off port=-1
      run(:func => "relayWrite", :port => port, :value => 0)
    end

    # Switch on, or enable power on a given port
    # +port+ the port option, default is all
    def switch_on port=-1
      run(:func => "relayWrite", :port => port, :value => 1)
    end

    private

    def run opts
      env = opts.map { |k,v| "#{k}=#{v}" }.join(" ")
      cmd = "#{env} cgi -q /usr/www/mfi/io.cgi"
      JSON.parse(@ssh.exec!(cmd).strip)
    end

  end
end