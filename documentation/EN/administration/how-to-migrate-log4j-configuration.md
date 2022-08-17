##  How to migrate your Log4j 1.x configuration to Log4j 2.x

### 1) Introduction

During the LinShare release 5.1.0, we upgraded the version of Log4j we are using; 
from `1.2.17` to `2.17.2`.  
This upgrade is coming with breaking changes regarding its configuration file, 
hence, you have to modify your `log4j.properties` configuration file.


### 2) Migration guide

#### 2.1) Renaming configuration file

First and more important part, the configuration file name has to be changed;
from `log4j.properties` to `log4j2.properties`.  
Then, you will have to take care of this change in case you are defining it in your runtime command.  
Example:  
```
JAVA_OPTS="${JAVA_OPTS} -Dlog4j2.configurationFile=file:/etc/linshare/log4j2.properties"
```

#### 2.2) Root elements

For the entire migration, you can notice that all `log4j.` prefixes are not needed any more.

The root elements had been renamed.  
For example, root log level is defined that way
```
# version 1.x
log4j.rootCategory=INFO, CONSOLE
# version 2.x
rootLogger=INFO, CONSOLE
```

#### 2.3) Appenders

The definition of the appenders is split in two mandatory lines instead of one:  
```
# version 1.x
log4j.appender.LINSHARE=org.apache.log4j.DailyRollingFileAppender
# version 2.x
appender.LINSHARE.type=RollingFile
appender.LINSHARE.name=LINSHARE
```

Then, you can have a look on the extra elements for each appenders on this documentation:  
https://logging.apache.org/log4j/2.0/manual/appenders.html

You can define a `LOG4J2_APPENDER` environment variable in order to change the default value: `CONSOLE`.  
In the default configuration, the available appenders are: 
- `CONSOLE`: append to the default system log
- `CONSOLE_JSON`:  append to the default system log, but in JSON format
- `LINSHARE`: append to a specific file (`/var/log/tomcat9/linshare.log`)

You can also use specify multiple appenders in the env variable by joining them with a comma (ex. `CONSOLE, LINSHARE`)

#### 2.4) Loggers

As for appenders, loggers are now defined in two lines:
```
# version 1.x
log4j.category.org.linagora.linshare=info
# version 2.x
logger.linshare = INFO, ${LOG4J2_APPENDER}
logger.linshare.name = org.linagora.linshare
```

You can notice that:
* `category` doesn't exist anymore, it has been replaced by `logger`
* the first line contains the log level and the appenders to which the logger will be appended
* the second line is the package (or class name) of the logger.

#### 3) Other configuration formats

Log4j2 is coming with multiple configuration formats (`properties`, `xml`, `yaml`, ...),  
you can follow this documentation if you want to switch to another format:  
https://logging.apache.org/log4j/2.0/manual/configuration.html

