+++
date = "2013-12-18"
title = "Part IV: Parsing GDELT with Spark/Shark on EC2"
url = "signals/part-iv-parsing-gdelt-with-spark-shark-on-ec2"
+++

This tutorial walks through how to query the GDELT dataset using Spark/Shark.

I [highlighted a few of Spark's advantages earlier in a prior post](http://chrismeserole.com/signals/big-data-in-the-cloud#spark-shark), but two bear repeating here. First, since Spark holds your dataset in memory across a cluster, queries run up to 100x faster than they would in a more common engine like Hive. Second, since there's no need to reload data with each iteration, machine learning and maximum likelihood estimation all run *much* faster in Spark. (I hope to show how to take advantage of this in a future tutorial.)

Before getting started I should probably also note that this tutorial was written for use on Mac OS X, but it should be fairly trivial to replicate on Linux. With a bit of work it should also be adaptable for use with Windows. 

Also, although I try not to assume familiarity with the command line, there may be some things I've overlooked. If you're new to working with the shell and run into any problems, [let me know](http://chrismeserole.com/contact). 


### SET UP

This is an optional first step, but to make the rest of the tutorial easier to follow for those just starting out on the command line, I'm including it here. 

To start off, [open Terminal](http://blog.teamtreehouse.com/introduction-to-the-mac-os-x-command-line) in your Applications folder and for each line enter the following at the `$` prompt:


	mkdir ~/workspace
	mkdir ~/workspace/spark
	mkdir ~/workspace/scala


If you type `ls` you should see 'workspace' listed. Likewise, if you type `ls workspace`, you should now see both 'spark' and 'scala' listed. 

In case you're curious, the logic here is that since Spark and Scala are under active development, a directory structure like this makes it easy to switch between versions as they're released.  

### BUILD SPARK LOCALLY

Now that we've got a basic workspace set up, let's download the latest stable version of Spark, and the version of Scala it depends on. At present, that means we need to [download Spark 0.8.0](http://spark-project.org/download/spark-0.8.0-incubating.tgz) and [download Scala 2.9.3](http://www.scala-lang.org/files/archive/scala-2.9.3.tgz). 

Once you've got each downloaded, unpack them to their appropriate directories: 

	tar -xf ~/Downloads/spark-0.8.0-incubating.tgz -C ~/workspace/spark
	tar -xf ~/Downloads/scala-2.9.3.tgz -C ~/workspace/scala

Now we need to tell Spark how to find Scala. You can use any text editor for this, but for the sake of consistency, I'm going to use [vim](http://www.vim.org/) here. (We'll also use vim later on.) 

To edit the file, run the following: 

	cd ~/workspace/spark/spark-0.8.0-incubating/conf/
	vim spark-env.sh.template

The first line changes to the shell to the appropriate directory. The second opens the file in vim. Type `G` to move to the end of the file. Then type `i` so that you can insert text. 

Then enter:

	SCALA_HOME=~/workspace/scala/scala-2.9.3/

Now, hit `esc` and then `:wq`. That will save the file and return you to your shell session. 

Once you've edited the template file, you need to rename it as just 'spark-env.sh'. You can do this from the command line as follows:

	mv spark-env.sh.template spark-env.sh

Finally, since the build process for Spark requires Git, you'll also need to install Git if you haven't already. You can [install it very easily here](http://git-scm.com/downloads). 

At this point you should be ready to build Spark. To do that, run:

	~/workspace/spark/spark-0.8.0-incubating/sbt/sbt assembly

You should see a bunch of lines start whizzing by. Basically, the command is downloading a slew of libraries and dependencies and then compiling everything for you. Depending on your internet connection, it could take a little while, so you may want to go grab a cup of coffee.

Once the build process is done, you should be able to run Spark locally. Run:

	cd ~/workspace/spark/spark-0.8.0-incubating
	./spark-shell

If a Scala interpreter opens, you've got everything running. Enter `exit;` to close the interpreter.

Alternately, if you prefer Python to Scala, you can run: 

	./pyspark

For more on using PySpark (especially how to use it with any of Python's scientific computing libraries), see [the official docs here](http://spark.incubator.apache.org/docs/latest/python-programming-guide.html). 


### CONFIGURING SPARK AND AWS

It's nice to have Spark running locally, but to fully make use of it we want to get it going on a computer cluster.

There are several ways to do this, but using Amazon's Web Services is probably the easiest. To set up a cluster with Amazon, you'll need to do three things: 

1. [Create an AWS account](http://docs.aws.amazon.com/AmazonSimpleDB/latest/DeveloperGuide/AboutAWSAccounts.html).
2. [Get your security credentials](http://docs.aws.amazon.com/general/latest/gr/getting-aws-sec-creds.html). 
3. [Generate a keypair](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html). 

Each of those steps is fairly straightforward. Although the first step takes the longest, if you want you can speed things up by linking your AWS account to a pre-existing Amazon account. 

At the end of steps 2 and 3, your browser should download a .csv file and a .pem file, respectively.

Once the .pem file has downloaded, return to Terminal and run the following: 

	mkdir ~/.aws
	mv ~/Downloads/YOURKEYNAME.pem ~/.aws/ 
	chmod 400 ~/.aws/YOURKEYNAME.pem

The first command creates a 'hidden' folder to hold your AWS key, and the last sets permissions for how it's to be accessed. Don't skip this step; later on you won't be able to launch an EC2 instance unless your key has the proper permissions.

Once you've set permissions, you then need to tell your shell how to access each file. The variables you create here are what your local install of Spark uses under the hood to talk to Amazon's servers. To do this, in your Terminal session, enter the following:

	export AWS_KEY_FILE='/Users/YOURUSERNAME/.aws/YOURKEYNAME.pem'
	export AWS_KEY_PAIR='YOURKEYNAME'

Note that in the second command, the '.pem' should NOT appear in the key name. You just enter the name itself. 

Finally, open the .csv file that you downloaded in step 2 above in a spreadsheet or text editor. Go back to Terminal in a separate window, and based on the information in the spreadsheet, enter the appropriate information as follows: 

	export AWS_ACCESS_KEY_ID='YOURACCESSKEYID'
	export AWS_SECRET_ACCESS_KEY='YOURSECRETACCESSKEY'

Again, those are variables that Spark will use later on to talk with your Amazon account. Note that if you'll be running Spark or EC2 frequently, you'll probably want to store all the AWS security variables more permanently, possibly in a .bash_profile or .bashrc file. That way you won't have to enter them each time you want to spin up a cluster. 

Finally, one option I would *HIGHLY* recommend before going any further is setting alerts on your AWS account. If you start a cluster and forget to stop or terminate it, you could be in for a nasty surprise at the end of the month. By setting an alert, Amazon will email you any time your monthly bill increases above a specified threshold. To set an alert, see [here](https://portal.aws.amazon.com/gp/aws/developer/account?ie=UTF8&action=billing-alerts). 


### CONNECTING TO AWS

Now that you've defined your AWS credentials for your environment, you can finally try to get a cluster up and running.

Before you begin though, you'll want to know what kind of EC2 instances you want in your cluster. The available types, and their prices, are [listed here](http://aws.amazon.com/ec2/pricing/). Since Spark runs in memory, what you'll want to pay attention to is the memory per instance; make sure the total memory in your cluster will be a sufficient multiple of the data you'll be working with. 

For this tutorial, to keep the costs down, we're only going to analyze a few GB of data. So we'll only use a small instance (it'll cost less than $1/hr). To launch your cluster, run:

	cd ~/workspace/spark/spark-0.8.0-incubating/ec2/
	./spark-ec2 -k $AWS_KEY_PAIR -i $AWS_KEY_FILE -s 1 --instance-type m1.large launch YOURINSTANCENAME

You should see a bunch of status updates scroll by over a couple minutes. At the end, if everything works, you should see output like this: 

	Ganglia started at http://ec2-XXX-XX-XXX-XXX.compute-1.amazonaws.com:5080/ganglia
	Done!

There are a few cases in which the launch script doesn't work, mostly notably when there aren't any instances available at a given moment. In that case, you'll see some Boto messages such as "The requested Availability Zone is currently constrained ... " If that happens, either specify a separate availability zone, or just wait a few seconds. I've never had to wait longer than a minute or so for one to become available. 

Once you've got a cluster up and running, you'll want to login to the master. To do that, run: 

	./spark-ec2 -k $AWS_KEY_PAIR -i $AWS_KEY_FILE login YOURINSTANCENAME

Alternately, you can also run the following manually, using the same URL that's provided at the very end of output when Spark finishes launching the cluster:

	ssh -i $AWS_KEY_FILE root@ec2-XXX-XX-XXX-XXX.compute-1.amazonaws.com

Either way, that should put you through to your EC2 instance. 

### LOAD YOUR DATA

At this point we've got everything we need, except we don't yet have data. There are a lot of different ways to handle this, but for this tutorial we're going to store some data in S3. To do that, set up an S3 bucket. You can name it whatever you want. Then also create one subdirectory entitled 'tutorial_data' and another 'tutorial_output'.  You can read [how to create an S3 bucket and subdirectories here](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html). 

Once you've set up your S3 bucket and subdirectories, you need to get the data from GDELT into the S3 bucket. 

One way to do that is to download GDELT to your desktop/laptop, and then upload to S3. I don't recommend that. Unless you work at Amazon it will take forever. Instead, download GDELT to your EC2 instance, and then upload to S3. That way, the upload trip happens entirely within Amazon's internal network, which is much faster.

First we need to set up a way to send data to S3. Once you're logged into your EC2 shell, run:

	curl https://raw.github.com/timkay/aws/master/aws -o aws
	chmod +x aws
	export EC2_ACCESS_KEY='YOURACCESSKEYHERE'
	export EC2_SECRET_KEY='YOURSECRETACCESSKEYHERE'
	perl aws --install

Now that we can talk with S3, let's download some GDELT data: 

	curl -O http://chrismeserole.com/code/gdelt_downloader.sh
	sh gdelt_download_tutorial.sh
	
That script downloads the files for 2000 and 2001. If you'd like to download different years, just edit gdelt_downloader.sh. For most years the changes you'd have to make are pretty self-explanatory, though for 2006-present, GDELT releases the files by month, so be sure to account for that. In that case be sure to visit the [GDELT downloads page](http://gdelt.utdallas.edu/data/backfiles/?O=D) to see what the URL pattern is.

Once the files have all downloaded, upload them to your bucket:

	s3put YOURBUCKETNAME/tutorial_data/ 2000.csv
	s3put YOURBUCKETNAME/tutorial_data/ 2001.csv

When the uploads are finished, you can check that the files are where they should be by running `s3ls YOURBUCKETNAME/tutorial_data` or visting the [s3 console in your browser](https://console.aws.amazon.com/s3/). 


### CONFIGURING SPARK/SHARK AND S3

Now that we've got our data, we need to tell Shark how to access it. Hopefully in the future Spark will automatically pass your AWS keys to Shark, but for now we need to use the following work-around: 

	vim ephemeral-hdfs/conf/core-site.xml

That opens a config file in Vim. Type `G`, then scroll up a line so you're just above `</configuration>`. Press `i` to switch to edit mode, then paste the following to the file, using your own key and ID:  

	<property>
	  <name>fs.s3.awsAccessKeyId</name>
	  <value>XXXXXXXXXXXX</value>
	</property>

	<property>
	  <name>fs.s3.awsSecretAccessKey</name>
	  <value>XXXXXXXXXXXX</value>
	</property>

	<property>
	  <name>fs.s3n.awsAccessKeyId</name>
	  <value>XXXXXXXXXXXX</value>
	</property>

	<property>
	  <name>fs.s3n.awsSecretAccessKey</name>
	  <value>XXXXXXXXXXXX</value>
	</property>

Press `esc`, then `:wq`. That will save the config file with the changes you made. Don't worry if the tab-spacing gets distorted. 

### LAUNCHING SHARK

Now that everything is set up, you can finally run Shark. In your shell, enter:

	export MASTER=`cat /root/spark-ec2/cluster-url`
	./shark/bin/shark

The first command above specifies where the master node is located. If you leave it out, the 'slave' nodes can't communicate with the master, and the master node will effectively run everything on its own. Be sure to include it.

The second command launches the Shark shell. By default, I \*think\* it allocates the maximum RAM minus 2gb to each machine, but if need be you can allocate memory manually.

At this point, the Spark interpeter should be open. (Just a tip: Shark is still fairly immature, and will often seem to hang. Sometimes you may need to hit `enter` to make the shell interactive again.)

Also, if you need to set the number of mapreduce tasks, you can use something like: 

	set mapred.reduce.tasks=10;

### QUERYING SHARK

Now that Shark is working, let's import our data from S3. 

First we need to create a table to house the data. Fortunately the syntax for Shark is effectively identical to Hive, which in turn is very similar to basic SQL syntax. To set up a table for GDELT, just run:

	CREATE EXTERNAL TABLE IF NOT EXISTS gdelt (
	 GLOBALEVENTID BIGINT,
	 SQLDATE INT,
	 MonthYear INT,
	 Year INT,
	 FractionDate DOUBLE,
	 Actor1Code STRING,
	 Actor1Name STRING,
	 Actor1CountryCode STRING,
	 Actor1KnownGroupCode STRING,
	 Actor1EthnicCode STRING,
	 Actor1Religion1Code STRING,
	 Actor1Religion2Code STRING,
	 Actor1Type1Code STRING,
	 Actor1Type2Code STRING,
	 Actor1Type3Code STRING,
	 Actor2Code STRING,
	 Actor2Name STRING,
	 Actor2CountryCode STRING,
	 Actor2KnownGroupCode STRING,
	 Actor2EthnicCode STRING,
	 Actor2Religion1Code STRING,
	 Actor2Religion2Code STRING,
	 Actor2Type1Code STRING,
	 Actor2Type2Code STRING,
	 Actor2Type3Code STRING,
	 IsRootEvent INT,
	 EventCode STRING,
	 EventBaseCode STRING,
	 EventRootCode STRING,
	 QuadClass INT,
	 GoldsteinScale DOUBLE,
	 NumMentions INT,
	 NumSources INT,
	 NumArticles INT,
	 AvgTone DOUBLE,
	 Actor1Geo_Type INT,
	 Actor1Geo_FullName STRING,
	 Actor1Geo_CountryCode INT,
	 Actor1Geo_ADM1Code STRING,
	 Actor1Geo_Lat FLOAT,
	 Actor1Geo_Long FLOAT,
	 Actor1Geo_FeatureID INT,
	 Actor2Geo_Type INT,
	 Actor2Geo_FullName STRING,
	 Actor2Geo_CountryCode STRING,
	 Actor2Geo_ADM1Code STRING,
	 Actor2Geo_Lat FLOAT,
	 Actor2Geo_Long FLOAT,
	 Actor2Geo_FeatureID INT,
	 ActionGeo_Type INT,
	 ActionGeo_FullName STRING,
	 ActionGeo_CountryCode STRING,
	 ActionGeo_ADM1Code STRING,
	 ActionGeo_Lat FLOAT,
	 ActionGeo_Long FLOAT,
	 ActionGeo_FeatureID INT,
	 DATEADDED INT,
	 SOURCEURL STRING )
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY '\t'
	STORED AS TEXTFILE
	LOCATION 's3n://cmes-gdelt-tutorial/tutorial_data/' ;

Now we've got a full copy of all our data stored in the ephemeral-hdfs. But this is still stored on the hard drive, and as I mentioned above, what we want is for the data to be stored in RAM. 

For that, all you have to do is run: 

	CREATE TABLE gdelt_cached as SELECT * FROM gdelt;

All the magic happens in that '_cached' suffix! Or put differently, it's the whole point of this tutorial. Any table with that suffix appended will automatically be stored in memory rather than to disk, which makes it much faster to query.

Once Shark finishes building the cache -- in this case, it'll probably take seven or eight minutes -- 
try the following:

	SELECT count(*) from gdelt_cached;

That should produce output like this: 

	shark> SELECT count(*) FROM gdelt_cached;
	OK
	9536449
	Time taken: 1.86 seconds

Not too bad. 


### EXPORTING SUBSETS

Often times you'll work with your data and want to export some portion of it. I don't generally think it's best practice to subset with Shark (Hive or Impala is a lot more cost effective), but there are times you might need to. 

Shark currently doesn't have an ability to export to s3 directly, so instead let's grab all the protest events in our data and store them locally on your cluster:

	INSERT OVERWRITE LOCAL DIRECTORY '/home/tmp/protestdata' select * from gdelt_cached WHERE EventRootCode=='14';

Now type `exit;` to quit Shark and return to the EC2 shell. Then run: 

	cd /home/tmp/protestdata/
	s3put YOURBUCKETNAME/tutorial_output/ 000000_0
	s3put YOURBUCKETNAME/tutorial_output/ 000001_0


### END EC2 SESSION

Once your subset is exported, you'll definitely want to pause or terminate the EC2 cluster when you're done, so that you don't have to pay an exorbitant bill. 

If you think you'll use the cluster again and want your data to persist, type `exit` in the EC2 shell and then run: 

	./spark-ec2 -k $AWS_KEY_PAIR -i $AWS_KEY_FILE stop YOURINSTANCENAME 

If you do this, you won't be charged for EC2, but you will be charged for any data in an attached EBS volume. 

If you're not going to be using this again for a while, you may want to terminate the cluster altogether. In that case, run:

	./spark-ec2 -k $AWS_KEY_PAIR -i $AWS_KEY_FILE destroy YOURINSTANCENAME 

And that's it. If you created a subset and exported to S3, you can download it locally to your machine via the aws command line tools, or just visit the aws web console.





	