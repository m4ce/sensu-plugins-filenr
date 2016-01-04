#!/usr/bin/env ruby
#
# check-filenr.rb
#
# Author: Matteo Cerutti <matteo.cerutti@hotmail.co.uk>
#

require 'sensu-plugin/check/cli'

class CheckFileNr < Sensu::Plugin::Check::CLI
  option :warn,
         :description => "Warn if NR exceeds current number of file handles (default: #{File.read("/proc/sys/fs/file-max").chomp.to_i * 90 / 100})",
         :short => "-w <NR>",
         :long => "--warn <NR>",
         :proc => proc(&:to_i),
         :default => (File.read("/proc/sys/fs/file-max").chomp.to_i * 90 / 100)

  option :crit,
         :description => "Critical if NR exceeds the current number of file handles (default: #{File.read("/proc/sys/fs/file-max").chomp.to_i})",
         :short => "-c <NR>",
         :long => "--critical <NR>",
         :proc => proc(&:to_i),
         :default => File.read("/proc/sys/fs/file-max").chomp.to_i

  def initialize()
    super
  end

  def run
    allocated = File.read("/proc/sys/fs/file-nr").split(' ')[0].to_i

    critical("Too many allocated file handles (#{allocated} >= #{config[:crit]})") if allocated >= config[:crit]
    warning("#{allocated} allocated file handles (>= #{config[:warn]})") if allocated >= config[:warn]

    ok("#{allocated} allocated file handles")
  end
end
