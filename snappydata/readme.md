
```
docker tag dad95b949913 ifire/snappydata:latest
docker login
docker push ifire/snappydata
```

# Notes

To allow the docker image to run on openshift you have to create a placeholder uid. On image startup you replace the uid with the user and write it to the passwd file.

https://github.com/openshift-qe/ssh-git-docker/blob/master/ssh-git-openshift/Dockerfile

```
adduser --system -s /bin/bash -u 1234321 -g 0 git # uid to replace later #Create usergroup
echo -e ",s/1234321/`id -u`/g\\012 w" | ed -s /etc/passwd # Replace UID
```

From https://rboci.blogspot.ca/2016/06/creating-docker-images-suitable-for.html

>    What I found out (see the official guidelines in the References section) is that regardless of your `USER` directive in Dockerfile, unless you give the user or service account that would launch pod as some random UID. The group will be static though - root. 

>    Because that random UID will not be part of the passwd file, some programs will fail to start with an error message like what I saw above. Another issue is that pre-setup of SSH becomes impossible as some files need to be with permissions 700 for ssh to accept them. Obviously as a random UID we cannot repair that once pod stats. 

