# == Define: layman::repository
#
# add a reposity url to layman.cfg
#
# === Parameters
# [*ensure*]
#   should this repolist get added to layman, present or absent
# [*url*]
#   replace name as the main url
# [*cfg_file*]
#   what config file to add the repos
#
# === Example Usage
#
#  layman::repository {'http://example.com/repositories.xml':}
#
# alternative syntax
#
#  layman::repository { 'example':
#    ensure => present,
#    url    => 'http://example.com/repositories.xml'
#  }
#
define layman::repository ($ensure = present, $url = undef, $cfg_file = undef) {
  include layman::params

  $cfg_file_real = $cfg_file ? {
    undef   => layman::params::cfg_file,
    default => $cfg_file
  }

  $url_real      = $url ? {
    undef   => $name,
    default => $url
  }

  file_line { "layman::repository-layman.cfg-${name}":
    ensure  => $ensure,
    line    => "            ${url_real}",
    path    => $layman::params::cfg_file,
    require => File[$layman::params::cfg_file]
  }

}

