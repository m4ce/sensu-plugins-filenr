#!/usr/bin/env ruby
#
#   metrics-filenr
#
# DESCRIPTION:
#   This plugin collects maximum number of file handles and current usage
#   for the entire system.
#
# OUTPUT:
#   metrics data in graphite
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#
# USAGE:
#   metrics-filenr.rb
#
#
# LICENCE:
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/metric/cli'
require 'socket'

#
# File Handle Metrics
#
class MetricsFileNr < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to queue.metric',
         short: '-s SCHEME',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.file_nr"

  def run
    used, unused, max = File.read('/proc/sys/fs/file-nr').split(' ').map(&:to_i)

    output("#{config[:scheme]}.used", used)
    output("#{config[:scheme]}.unused", unused)
    output("#{config[:scheme]}.max", max)

    ok
  end
end
