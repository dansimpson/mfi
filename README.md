#### mFi for ruby

Gem for integrating with mFi devices over SSH.

##### Install

```
gem install mfi
```

##### mPower

mPower ports are linux based wifi-enabled power strips.  Each port has sensors for amps, voltage, and power factor.  Additionally each port has a relay.  Here is a script that samples all powers, and disables a port if the energy exceeds 10kWh.

```ruby
mpower = MFi::MPower.new(
  :host => "hostname",
  :user => "username",
  :pass => "password"
)

mpower.exec { |remote| 
  remote.sample.each { |reading|
    puts reading.to_s
    if reading.energy > 10
      puts "Port #{reading.port} has consumed >= 10 kWh. Switching off..."
      remote.switch_off(reading.port)
    end
  }
}
```

##### Rake

You can also run the rakefile when checking out the repository

```
$ rake sample HOST=192.168.3.201 USER=ubnt PASS=ubnt
Port 1:  20.5W (  0.7pf   0.3A 112.3V)
Port 2:   0.0W (  0.0pf   0.0A 113.9V)
Port 3:   0.0W (  0.0pf   0.0A 113.2V)
```

##### Notes

This is a quick sunday hack, so use at your own risk.  If you extend or enhance this, send a pull request.
