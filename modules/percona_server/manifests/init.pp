# # Add our new class for Percona
 class percona_server (
 	$config
 ) {
	 package { 'mysql-*':
		 ensure => absent,
		 require => Package['mysql-server']
	 }

	 exec { 'wget_percona_deb':
		 command => 'wget https://repo.percona.com/apt/percona-release_latest.$(lsb_release -sc)_all.deb',
		 path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
		 onlyif  => "test ! -f percona-release_latest.$(lsb_release -sc)_all.deb"
	 }

	 exec { 'dpkg_percona':
		 command => 'sudo dpkg -i percona-release_latest.$(lsb_release -sc)_all.deb',
		 path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
		 require => Exec['wget_percona_deb'],
		 onlyif  => "test -f percona-release_latest.$(lsb_release -sc)_all.deb",
		 notify  => Exec['apt_update']
	 }

	 package { 'percona-server-server-5.7':
		 ensure  => installed,
		 require => Exec['dpkg_percona'],
	 }
 }
