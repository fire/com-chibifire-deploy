swale [8:24 AM] 
@kientt86 @ifire Do you want to start all of locators, leads and servers in foreground? The local mode can be done in foreground, of course. There are LocatorImpl, LeadImpl, ServerImpl classes which are used by the launcher scripts that can be used but it will be need some careful doing to start all of them properly in a custom distributed application.

ifire [8:25 AM] 
@swale I want to start a locator in the foreground. A server in the foreground and a lead in the foreground. Yes seperately.

swale [8:26 AM] 
@kientt86 @ifire If all you need is to wait for the processes to start up, you can use SparkListener, or poll SYS.MEMBERS table or a MembershipListener. What exactly is the requirement?

kientt86 [8:26 AM] 
@swale i need to start all locators, servers and leads in foreground

ifire [8:26 AM] 
Can you tell me more? "There are LocatorImpl, LeadImpl, ServerImpl classes which are used by the launcher scripts"

[8:27] 
currently doing this.

```
/opt/snappydata/bin/snappy leader start -dir=/snappydata/leader -zeppelin.interpreter.enable=true -locators=snappydata-locator-0.snappydata-locator.$MY_POD_NAMESPACE.svc.cluster.local:10334,snappydata-locator-1.snappydata-locator.$MY_POD_NAMESPACE.svc.cluster.local:10334 -client-bind-address=$(hostname -f) -heap-size=4096m -membership-port-range=21000-21020 -J-XX:MaxPermSize=512m -enable-network-partition-detection=true && tail -f /snappydata/leader/snappyleader.log
```

swale [8:27 AM] 
@kientt86 How do you intend to manage them in a distributed setup?

ifire [8:28 AM] 
The issue is that I need the poller to be in the foreground so when it crashes the whole docker instance crashes (edited)

[8:28] 
and the poller needs to be able to poll the existing servers

[8:29] 
So there's two parts

kientt86 [8:29 AM] 
@swale i will need to start those processes independently via Marathon, so i can run snappydata on Mesos

[8:30] 
Marathon required the process to be in foreground

ifire [8:30 AM] 
A) there's an init container that polls for the (locator, server) as Lead / Server. B) the starting of the server, lead, locator so the docker instance 's life cycle is tied to the one process

[8:31] 
B.1) also want the logging to be in the foreground

[8:33] 
Solutions for B) that aren't good are 1) loop forever 2) tail the log files

kientt86 [8:34 AM] 
@swale do you have an example of using LocatorImpl, ...

ifire [8:34 AM] 
Basically we need an alternative to "/opt/snappydata/bin/snappy leader start"

swale [8:38 AM] 
@ifire @kientt86 Check out how the distrubuted unit test framework does it: https://github.com/SnappyDataInc/snappydata/blob/master/cluster/src/dunit/scala/io/snappydata/cluster/ClusterManagerTestBase.scala#L92
Get a locator instance using ServiceManager.getLocatorInstance first on one of the nodes, setup the properties, start it, start a network server. Likewise setup servers next using ServiceManager.getServerInstance (see startSnappyServer). Lastly start lead -- see startSnappyLead there.

[8:39] 
@ifire @kientt86 Have all these as independent JVMs and not embedded inside other programs (except for adding minimal controls) as far as possible.

ifire [8:40 AM] 
`/bin/spark-class org.apache.spark.deploy.master.Master ` is how spark starts in the foreground

[8:40] 
spark (regular version)

[8:41] 
As of Spark 2.1 (and this commit) it is possible to set the environment variable SPARK_NO_DAEMONIZE and have supervisor invoke the provided start scripts $SPARK_HOME/sbin/start-master.sh and $SPARK_HOME/sbin/start-slave.sh directly.``
https://unix.stackexchange.com/a/335998
unix.stackexchange.com
Launch Spark in Foreground via Supervisor
We have a spark cluster that launches via supervisor. Excerpts: /etc/supervisor/conf.d/spark_master.conf: command=./sbin/start-master.sh directory=/opt/spark-1.4.1 /etc/supervisor/conf.d/spark_w...
 
swale [8:42 AM] 
@ifire @kientt86 About logging, you can control using log4j.properties where ConsoleAppender should work. Spark's standalone is its own cluster manager and has separate implementations for Yarn/Mesos. The Snappy cluster manager is different. Using API it should be possible to make it work with Mesos/Yarn but has not been tested yet.

ifire [8:42 AM] 
Note: I'm working on kubernetes and @kientt86 is working on  Yarn/Mesos

[8:45] 
Also will 1.0 be upgraded to new versions of spark?

[8:45] 
It's not a priority, but would be interested to know.

kientt86 [8:47 AM] 
@swale thanks, i guess for now we have to write some startup scrip by ourself in order to run it in foreground

[8:48] 
(using Impl api)

ifire [8:48 AM] 
Thanks @swale it seems like I have to write a startup scala script and a scala poller implementation for kubernetes.

swale [8:51 AM] 
@ifire Ok. See the distributed unit setup I linked above. It requires fairly minimal configuration. Also would recommend the default JVM parameters we use in the cluster: https://github.com/SnappyDataInc/snappy-store/blob/snappy/master/gemfirexd/tools/src/main/java/com/pivotal/gemfirexd/tools/internal/GfxdServerLauncher.java#L707 . And critical-heap-percentage of 90-95%: https://github.com/SnappyDataInc/snappy-store/blob/snappy/master/gemfire-core/src/main/java/com/gemstone/gemfire/internal/cache/CacheServerLauncher.java#L1117
GitHub
SnappyDataInc/snappy-store
snappy-store - SnappyStore
 

ifire [8:52 AM] 
@swale Can you describe more about the poller to check for existing servers / locators?

swale [8:52 AM] 
@ifire We have a 2.1.0 merge branch which will definitely be there for 1.0 release. Could jump to 2.2.0 also.

swale [8:58 AM] 
@ifire There are various internal APIs (MembershipListener, jgroups APIs etc). Public APIs are: SYS.MEMBERS virtual table (if on a lead/server JVM itself then created an embedded connection with URL "jdbc:snappydata:" and select on SYS.MEMBERS or thin connection with usual URL "jdbc:snappydata://host:port"). It has the nodes, types, status etc. Or SparkListener on lead JVMs.

ifire [9:00 AM] 
The purpose of the poller for the lead is to determine a) if the servers exist b) shutdown the lead if error conditions. It is possible to connect to the sys.member table before the lead starts through the thin driver?

[9:04] 
I believe the poller and the actual lead instance should be in two different jvms / docker instances according to the kubernetes design.

swale [9:04 AM] 
@ifire Yes you can connect using the thin driver to the locator (which will redirect to one of the running servers). As long as one of the servers is up, you can query that table.

