## How to add new upgrade task :

#### What is an upgrade task :

An upgrade task is created to automate the migration from one version to the next and apply the necessary changes added in this new version.

To add an upgrade task in the LinShare backend you must do the following steps :

#### 1 Add UpgradeTask Enum

* First you need to create a new task_group, to do this go on `UpgradeTaskGroup` and add new Enum :
      UPGRADE_[VERSION]

* Now you need to add an Enum for your new upgrade task on the java enum class `UpgradeTaskType`.

    UPGRADE_[VERSION]\_[SUBJECT]

#### 2 Create your upgradeTask class

 * You need to create a new class and extends `GeniricUpgradeTaskImpl` for your new upgradeTask.

 * You have to return your new upgradeTaskType on this methode `getUpgradeTaskType()`.

 * And now you can write your specific code for your upgrade task on `getAll` method to get a list of object to be iterated and `execute` method to apply your changes to those objects.

#### 3 Add your upgradeTask insert query to import_**\_sample.sql :

To test your upgrade task you need to create a SQL script `import-upgrade-task-[version]-sample.sql`, and add inside it the SQL queries to insert in the table `upgrade_task` for all your new UpgradeTaskType

Example :

     INSERT INTO upgrade_task
       (id,  uuid,  identifier,  task_group,  parent_uuid,  parent_identifier,  task_order,  status, priority,  creation_date,  modification_date,  extras)
     VALUES
       (15,  'UNDEFINED',  'UPGRADE_2_1_REMOVE_ALL_THREAD_ENTRIES',  'UPGRADE_2_1',  null,  null,  15,  'NEW',  'MANDATORY',  now(),  now(),  null);

Fields :

* identifier : your new UpgradeTaskType
* task_group : your new UpgradeTaskGroup
* parent_identifier : add the identifier of parent task if you need to run it before running this task.
* priority : MANDATORY or REQUIRED

> Criticality <br>
  Every tasks have to be executed in order to complete the update. While some 'Mandatory' tasks are not done,
  it will be impossible for the users to use the system. While some 'Required'
  tasks are not done, the system will work in a downgraded mode.
  Some functionalities or data might not be accessible. Those tasks might be executed while the system is being used.

Now you can execute your SQL script.

In most cases, you may want to add your SQL queries to a migration script so that, the upgrade tasks are avalaible and ready to be lauched after the upgrade of your LinShare application.

#### 4 Add your upgradeTask bean in the adminUpgradeTaskRestService bean into scriptContext-upgrade.xml :

Example :

    <bean class="org.linagora.linshare.core.upgrade.v2_2.YOUR_NEW_UPGRADE_TASK_CLASS_IMPL.java">
		<constructor-arg ref="accountRepository" />
		<constructor-arg ref="upgradeTaskLogMongoRepository" />
		...
	</bean>

#### 5 Run your upgradeTask on ui-admin :

To run your upgrade task, go on LinShare ui-admin, on the left menu select Domains, Upgrades Tasks and run your task by click on the pencil icon.
