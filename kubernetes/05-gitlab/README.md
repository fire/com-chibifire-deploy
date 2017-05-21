https://github.com/sameersbn/docker-gitlab

gcloud docker -- pull gtaylor/nginx-for-drone
gcloud docker -- tag gtaylor/nginx-for-drone us.gcr.io/quassel-chibifire/nginx-for-drone:p0
gcloud docker -- push us.gcr.io/quassel-chibifire/nginx-for-drone:p0

> A backup will be created in the backups folder of the Data Store. You can change the location of the backups using the GITLAB_BACKUP_DIR configuration parameter.

Copy backup to /home/git/data/backups

kubectl cp .\1495322559_2017_05_20_gitlab_backup.tar gitlab-6tr6z:/home/git/data/backups

There may be some special situations where you want to disable 2FA for everyone even when forced 2FA is disabled. There is a rake task for that:

```
entrypoint.sh app:rake gitlab:two_factor:disable_for_all_users
```