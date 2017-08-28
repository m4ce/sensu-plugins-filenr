# Sensu plugin for monitoring the number of allocated file handles

A sensu plugin to monitor the number of allocated file handles (file descriptors) on a system.

## Files

 * bin/check-filenr.rb
 * bin/metrics-filenr.rb


## Usage

### check-filenr.rb

The plugin accepts the following command line options:

```
Usage: check-filenr.rb (options)
    -c, --critical <NR>              Critical if NR exceeds the current number of file handles (default: 383786)
    -w, --warn <NR>                  Warn if NR exceeds current number of file handles (default: 345407)
```

The default critical value is set to the fs.file-max (/proc/sys/fs/file-max), whereas the warning is set to 90% of the file-max value.

### metrics-filenr.rb

```
Usage: metrics-filenr.rb (options)
    -s, --scheme SCHEME              Metric naming scheme, text to prepend to queue_name.metric
```


## Author
Matteo Cerutti - <matteo.cerutti@hotmail.co.uk>
Bekir Dogan - <bekirdo@gmail.com>
