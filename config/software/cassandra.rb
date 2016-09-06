name "cassandra"
default_version "3.7"

dependency "server-jre"

license "Apache"
skip_transitive_dependency_licensing true

version "3.7" do
  source md5: "39968c48cbb2a333e525f852db59fb48"
end

source url: "http://mirror.cogentco.com/pub/apache/cassandra/#{version}/apache-cassandra-#{version}-bin.tar.gz"



build do
  delete "apache-cassandra-#{version}/lib/sigar-bin/libsigar-amd64-solaris.so"

  # Change a couple config files
  patch source: "cassandra.yaml.patch"
  patch source: "cassandra-env.sh.patch"

  # Cleanup javadoc, we don't need that here and it take over 100MB!
  delete "apache-cassandra-#{version}/javadoc"

  # General copy of all the decompressed tarball
  sync "apache-cassandra-#{version}", "#{install_dir}/embedded/apache-cassandra"

  # Init files ...
  erb source: "cassandra.init.debian.erb", dest: "#{install_dir}/embedded/apache-cassandra/tools/bin/cassandra.init.debian",
  erb source: "cassandra.init.rhel.erb", dest: "#{install_dir}/embedded/apache-cassandra/tools/bin/cassandra.init.rhel",


 "#{install_dir}/embedded/apache-cassandra/tools/bin"

end

