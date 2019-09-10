# # Add our new class for Percona
 class percona_server (
 	$config
 ) {
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
	 }

	 exec { 'percona_apt_update':
		 command => 'sudo apt-get update',
		 path    => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ],
		 require => Exec['dpkg_percona'],
	 }

	 package { 'percona-server-server-5.7':
		 ensure  => installed,
		 require => Exec['percona_apt_update'],
	 }
 }
