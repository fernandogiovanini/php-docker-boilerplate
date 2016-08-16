#++++++++++++++++++++++++++++++++++++++
# PostgreSQL Docker container
#++++++++++++++++++++++++++++++++++++++
#
# Official images:
#
#   postgres - official PostgreSQL
#              https://hub.docker.com/r/library/postgres/
#
#++++++++++++++++++++++++++++++++++++++

FROM postgres:9.4

# add backup script
ADD bin/backup.sh /usr/local/bin/backup
RUN chmod +x /usr/local/bin/backup

# add restore script
ADD bin/restore.sh /usr/local/bin/restore
RUN chmod +x /usr/local/bin/restore