This file provides a list of dependencies's versions required by **LinShare**

# System requirements

| LinShare Version | OS                    | JVM core version<sup>1</sup> | Recommended JVM distribution<sup>2</sup> | PostgreSQL    | MongoDB            | Tomcat   | Apache  HTTPD |
|------------------|-----------------------|------------------------------|------------------------------------------|---------------|--------------------|----------|---------------|
| 7.0              | Debian 11             | OpenJDK 17.0.9+8             | Azul Zulu 17.46.19 (JRE Edition)         | PostgreSql 13 | MongoDB 5.0        | Tomcat 9 | Apache 2.4    |
| 6.2              | Debian 11             | -                            | Debian OpenJDK 11 (JRE Edition)          | PostgreSql 13 | MongoDB 5.0        | Tomcat 9 | Apache 2.4    |
| 6.1              | Debian 11             | -                            | Debian OpenJDK 11 (JRE Edition)          | PostgreSql 13 | MongoDB 5.0        | Tomcat 9 | Apache 2.4    |
| 6.0              | Debian 11             | -                            | Debian OpenJDK 11 (JRE Edition)          | PostgreSql 13 | MongoDB 5.0        | Tomcat 9 | Apache 2.4    |
| 5.1              | Debian 10             | -                            | Debian OpenJDK 11 (JRE Edition)          | PostgreSql 11 | MongoDB 4.2        | Tomcat 9 | Apache 2.4    |
| 5.0              | Debian 10             | -                            | Debian OpenJDK 11 (JRE Edition)          | PostgreSql 11 | MongoDB 4.2        | Tomcat 9 | Apache 2.4    |
| 4.2              | Debian 10             | -                            | Debian OpenJDK 11 (JRE Edition)          | PostgreSql 11 | MongoDB 4.2        | Tomcat 9 | Apache 2.4    |
| 4.1              | Debian 10             | -                            | Debian OpenJDK 11 (JRE Edition)          | PostgreSql 11 | MongoDB 4.2        | Tomcat 9 | Apache 2.4    |
| 4.0              | Debian 10             | -                            | Debian OpenJDK 11 (JRE Edition)          | PostgreSql 11 | MongoDB 4.2        | Tomcat 9 | Apache 2.4    |
| 2.3              | Debian 8, 9, Centos 7 | -                            | Debian OpenJDK 8 (JRE Edition)           | PostgreSql 9  | MongoDB 3.2 to 3.6 | Tomcat 8 | Apache 2.4    |
| 2.2              | Debian 8, Centos 7    | -                            | Debian OpenJDK 8 (JRE Edition)           | PostgreSql 9  | MongoDB 3.2        | Tomcat 8 | Apache 2.4    |
| 2.1              | Debian 8, Centos 7    | -                            | Debian OpenJDK 8 (JRE Edition)           | PostgreSql 9  | MongoDB 3.2        | Tomcat 8 | Apache 2.4    |
| 2.0              | Debian 8, Centos 7    | -                            | Debian OpenJDK 8 (JRE Edition)           | PostgreSql 9  | MongoDB 3.2        | Tomcat 8 | Apache 2.4    |
| 1.12             | Debian 8, Centos 7    | -                            | Debian OpenJDK 7 (JRE Edition)           | PostgreSql 9  |      -             | Tomcat 7 | Apache 2.2    |


Notes:
  1. Each available JVM distribution are based on a common JVM core, mainly OpenJDK. Linshare could work with all distributions based on this given JVM core or upper. For JVM distributions based on a **minor update** of the JVM core, all should works fine. For JVM distributions based on a **major update** of the JVM core, all should works fine **if no breaking change was introduced**.
  1. Even if Linshare could work<sup>1</sup> with other JVM distributions based on the given JVM core, as we can't support LinShare on all compliant JVM distributions, we recommend to use this given JVM distribution in a production environment.

# Supported browsers

This is the list of supported browsers' versions required by **LinShare**:

| Browsers    | version |
|-------------|---------|
| Chrome      | 90+     |
| Firefox     | 88+     |
| Firefox ESR | 78+     |
