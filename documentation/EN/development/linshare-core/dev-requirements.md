# System requirements to develop Linshare Core

| LinShare Version | OS                    | JVM core version<sup>1</sup> | Recommended JVM distribution<sup>2</sup> | Maven |
|------------------|-----------------------|------------------------------|------------------------------------------|-------|
| 7.0              | Debian 11             | OpenJDK 17.0.9+8 or upper    | Debian `openjdk-17-jdk`                  | 3.6.3 |
| 6.2              | Debian 11             | -                            | Debian `openjdk-11-jdk`                  | 3.6.3 |
| 6.1              | Debian 11             | -                            | Debian `openjdk-11-jdk`                  | 3.6.3 |
| 6.0              | Debian 11             | -                            | Debian `openjdk-11-jdk`                  | 3.6.3 |
| 5.1              | Debian 10             | -                            | Debian `openjdk-11-jdk`                  | 3.6.3 |
| 5.0              | Debian 10             | -                            | Debian `openjdk-11-jdk`                  | 3.6.3 |
| 4.2              | Debian 10             | -                            | Debian `openjdk-11-jdk`                  | 3.6.3 |
| 4.1              | Debian 10             | -                            | Debian `openjdk-11-jdk`                  | 3.6.3 |
| 4.0              | Debian 10             | -                            | Debian `openjdk-11-jdk`                  | 3.6.3 |

  1. Each available JVM distribution are based on a common JVM core, mainly OpenJDK. Linshare could work with all distributions based on this given JVM core or upper. For JVM distributions based on a **minor update** of the JVM core, all should works fine. For JVM distributions based on a **major update** of the JVM core, all should works fine **if no breaking change was introduced**.
  1. Even if Linshare could work<sup>1</sup> with other JVM distributions based on the given JVM core, as we can't support LinShare on all compliant JVM distributions, we recommend to use this given JVM distribution in a production environment.
