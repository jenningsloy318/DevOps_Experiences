Jira Tips
---

## 1. configure jira via sql 
a. update the anouncement banner   
-  set the visibility to public     
   ```sql
   update propertystring set propertyvalue = 'public' where ID=(select id from propertyentry where property_key='jira.alertheader.visibility');
   ```
-  set the anouncement banner content
  ```sql

  update propertytext set propertyvalue='<!-- Message Banner -->

  <div style="background-color: Green; border: 3px solid SeaGreen; margin: 4px; padding: 2px; font-weight: bold; text-align: center;">
  This is SCE TEST  JIRA HA CLUSTER
  </a>
  </div>' where ID=(select id from propertyentry where property_key='jira.alertheader');
  ```

b. License operations
- update the license  
  ```sql
  SELECT @LICENCEID:=ID FROM productlicense;

  update productlicense set license ='license string' WHERE id= @LICENCEID;
  ```
- get license info
```sql
SELECT * FROM productlicense;
```

c. add current user to jira-administrator
- To find out which group(s) have been granted the JIRA Administrators global permission, run the following database query:
```sql
select group_id from globalpermissionentry where PERMISSION='ADMINISTER';
```
- To find out which group(s) have been granted the JIRA System Administrators global permission, run the following database query:
```sql
select group_id from globalpermissionentry where PERMISSION='SYSTEM_ADMIN';
```
- Now that you know which group(s) have the global permission, run the following database query to find out which users are in that group (replace "jira-administrators" with the group returned by the above query):

```sql
select parent_id,child_name, directory_id from cwd_membership where parent_name='jira-administrators';
```

now we can get the `parent_id`, since all users within same group (`jira-administrators`) have same `parent_id`
- get the user membership which would be added into jira-administrators
```sql
select * from cwd_membership  where child_name='I336589';
```
now we can see the `child_id` of the user, each user has its uniq `child_id` 

- add user to the `jira-administrators`

  - generate the ID of new entry
  ```sql
  select @MAXID:=max(ID)+1   from cwd_membership ;
  ```
  - add the user membership   
  ```
  insert into cwd_membership values (@MAXID,parent_id,child_id,'GROUP_USER',NULL,'parent_name','lower_parent_name',child_name,'lower_child_name',1);
  ```
- link https://confluence.atlassian.com/jira/retrieving-the-jira-administrator-192836.html


d. update the baseurl 
```sql
update propertystring, propertyentry 
set propertystring.propertyvalue = 'https://jira.servername.com' 
where propertystring.ID = propertyentry.ID 
and propertyentry.PROPERTY_KEY = 'jira.baseurl'

```
  links:
  - https://community.atlassian.com/t5/Jira-questions/In-which-db-table-Jira-holds-JIRA-Base-URL-confluguration/qaq-p/102773
  - https://confluence.atlassian.com/jirakb/how-do-i-manually-change-the-base-url-733940375.html
## HA cluster

when configure the cluster, the node name of the cluster should not contain any special characters.