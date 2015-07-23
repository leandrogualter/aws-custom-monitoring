name             'aws-custom-monitoring'
maintainer       'Leandro Gualter'
maintainer_email 'leandrogualter@gmail.com'
license          'MIT License'
description      'Installs monitoring aws sample available at http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/mon-scripts-perl.html'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

supports         'ubuntu'

recipe           'aws-custom-monitoring::default', 'Installs monitoring for disk-space-util, swap-util and mem-util running each 5 mins.'
