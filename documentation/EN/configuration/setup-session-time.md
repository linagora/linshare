# How to setup session live time

Open web.xml  

```sudo vi usr/local/tomcat/conf/web.xml```

Find this block and now you can set the default *(30)* session timeout by change the value inside, be careful the time is in minutes!
Remplace 30 by 1
```
    <session-config>
        <session-timeout>1</session-timeout>
    </session-config>
```

Save the file and reload the service 
```sudo service tomcat7 reload```
