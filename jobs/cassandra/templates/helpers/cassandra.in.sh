if [ "x$CASSANDRA_HOME" = "x" ]; then
    export CASSANDRA_HOME=/var/vcap/packages/cassandra
fi

# The directory where Cassandra's configs live (required)
if [ "x$CASSANDRA_CONF" = "x" ]; then
    export CASSANDRA_CONF=/var/vcap/jobs/cassandra/config
fi

# This can be the path to a jar file, or a directory containing the 
# compiled classes. NOTE: This isn't needed by the startup script,
# it's just used here in constructing the classpath.
cassandra_bin=$CASSANDRA_HOME/build/classes/main
cassandra_bin=$cassandra_bin:$CASSANDRA_HOME/build/classes/thrift
#cassandra_bin=$cassandra_home/build/cassandra.jar

# JAVA_HOME can optionally be set here
#JAVA_HOME=/usr/local/jdk6

# The java classpath (required)
export CLASSPATH=${CLASSPATH:-''} # default to empty
export CLASSPATH=$CASSANDRA_CONF:$cassandra_bin:$CLASSPATH

for jar in $CASSANDRA_HOME/lib/*.jar; do
    export CLASSPATH=$CLASSPATH:$jar
done

export JVM_OPTS="${JVM_OPTS} -Djava.net.preferIPv4Stack=true  -Djava.rmi.server.hostname=0.0.0.0 -Dcom.sun.management.jmxremote.port=7199 -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false"
