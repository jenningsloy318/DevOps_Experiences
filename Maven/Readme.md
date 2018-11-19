**Maven Plugin configurations**
---

Tips:
- show all parameters for plugins 
  ```
  mvn help:describe -Dplugin=com.spotify:dockerfile-maven-plugin:1.3.5 -Ddetail
  ```



1. Get git commit ID via [`buildnumber-maven-plugin`](http://www.mojohaus.org/buildnumber-maven-plugin/usage.html) plugin. it will create several var which can be used in the pom
    - ${buildNumber}
    - ${scmBranch}

    ```
    <plugin>
        <groupId>org.codehaus.mojo</groupId>
        <artifactId>buildnumber-maven-plugin</artifactId>
        <version>1.4</version>  
        <executions>
          <execution>
            <phase>validate</phase>
            <goals>
              <goal>create</goal>
            </goals>
          </execution>
        </executions>
        <configuration>
          <doCheck>false</doCheck>
          <doUpdate>false</doUpdate>
        </configuration>
    </plugin>
    ```

2. add docker registry user auth info in `~/.m2/settings`, add following codes into in `<settings> xxx</settings>`, refer to [Maven Settings Reference](https://maven.apache.org/settings.html#Settings_Details):
    
    ```
    <servers>
      <server>
        <id>myregistry.lmy.com</id>
        <username>admin</username>
        <password>{yNCPqkc8oh8HTaCVfIKiGzsxxpRLwYi20KxX0IwE4yo=}</password>
      </server>
    </servers>
    ```

    for encrypting the passord,  following steps:
    - create master password
      ```
      #mvn --encrypt-master-password mavenmaster
      {8aPZy0IEvhcHVja5fIliJhAzfO6bri0HMKm640lfZxw=}
      ```
    - create file `~/.m2/settings-security.xml` to store this password
      ```
      <settingsSecurity>
        <master>{8aPZy0IEvhcHVja5fIliJhAzfO6bri0HMKm640lfZxw=}</master>
      </settingsSecurity>
      ```
    - encrypt our password
      ```
      #mvn --encrypt-password password
      {yNCPqkc8oh8HTaCVfIKiGzsxxpRLwYi20KxX0IwE4yo=}
      ```
    

3. configure docker build via `docker-maven-plugin` plugin, use `git commit ID` for the image tag, var `${buildNumber}` is created by `buildnumber-maven-plugin`, and `<serverId>myregistry.lmy.com</serverId>` must be set in order to use the registry setting in  `~/.m2/settings`.
    ```
    <plugin>
        <groupId>com.spotify</groupId>
        <artifactId>docker-maven-plugin</artifactId> 
        <version>1.0.0</version>
        <executions>
          <execution>
            <id>build-image</id>
            <phase>install</phase>
            <goals>
              <goal>build</goal>
            </goals>
          </execution>
          <execution>
            <id>push-image</id>
            <phase>deploy</phase>
            <goals>
              <goal>push</goal>
            </goals>
          </execution>                  
        </executions>
        <configuration>
          <skipDockerBuild>false</skipDockerBuild>
          <imageName>registry.lmy.com/project/image-name</imageName>
          <imageTags>
            <imageTag>${buildNumber}</imageTag> 
          </imageTags>
          <dockerDirectory>${project.basedir}/docker</dockerDirectory>
          <noCache>true</noCache>  
          <serverId>myregistry.lmy.com</serverId>
          <resources>
                <resource>
                  <targetPath>html</targetPath> <!-- targetPath is the path in docker image that the files can be copied to -->
                  <directory>${project.basedir}/dist</directory> <!-- project.basedir  is project root directory -->
                  <include>*/**</include>
                </resource>
          </resources>
        </configuration>
    </plugin>
    ```
    or
    ```
    <plugin>
      <groupId>com.spotify</groupId>
      <artifactId>docker-maven-plugin</artifactId>
      <version>1.0.0</version>
      <configuration>
          <skipDockerBuild>false</skipDockerBuild>
        <imageName>registry.lmy.com/project/image-name</imageName>
        <imageTags>
          <imageTag>${buildNumber}</imageTag> 
        </imageTags>
        <dockerDirectory>${project.basedir}/docker</dockerDirectory>
        <serverId>myregistry.lmy.com</serverId>
        <resources>
          <resource>
              <targetPath>/hygieia</targetPath>    <!-- targetPath is the path in docker image that the files can be copied to -->
              <directory>${project.build.directory}</directory>    <!-- project.build.directory  is build target directory -->
              <include>${project.build.finalName}.jar</include>
          </resource>
        </resources>
      </configuration>
    </plugin>
    ```


4. for multi-module project, cases we don't want to build  it    at top level, and want to build in  individual modules, so we can skip this plugin at parent pom explictly and enable it in individual sub modules.

5. based on #5 ( plugin which disable in top level and used in submodule ), it will prompt the error:
    ```
    No plugin found for prefix 'docker' in the current project and in the plugin groups
    ```
    we will need to add plugin groups setting in maven settings.xml as 
  
    ```
    <settings>
    ...
      <pluginGroups>
          <pluginGroup>com.sap.ldi</pluginGroup>
          <pluginGroup>com.spotify</pluginGroup>
      </pluginGroups>
    </settings>
    ```
