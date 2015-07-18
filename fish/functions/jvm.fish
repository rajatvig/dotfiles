function jvm --description 'switch jvm'
  set -gx JAVA_HOME (/usr/libexec/java_home -v $argv)
end
