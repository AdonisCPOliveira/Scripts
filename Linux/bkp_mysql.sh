# CRIPT PARA BACKUP MYSQL ####################
# LEONARDO GRILLO (LEONARDO.GRILLO@GMAIL.COM)                    #
# Created ABR, 2015                                              #
# Update --                                                      #

# Definindo parametros do MySQL
echo "  -- Definindo parametros do MySQL ..."
DB_NAME='cacti'
DB_NAME2='ocsweb'
DB_NAME3='ocs'
DB_USER='root'
DB_PASS='new-password'
DB_PARAM='--add-drop-table --add-locks --extended-insert --single-transaction -quick'

# Definindo parametros do sistema
echo "  -- Definindo parametros do sistema ..."
DATE=`date +%Y-%m-%d`
MYSQLDUMP=/usr/bin/mysqldump
BACKUP_DIR=/mnt/backup
BACKUP_NAME=mysql_cacti-$DATE.sql
BACKUP_NAME2=mysql_ocsweb-$DATE.sql
BACKUP_NAME3=mysql_ocs-$DATE.sql
BACKUP_TAR=mysql-$DATE.tar

#Gerando arquivo sql
echo "  -- Gerando Backup da base de dados $DB_NAME em $BACKUP_DIR/$BACKUP_NAME ..."
$MYSQLDUMP $DB_NAME $DB_PARAM -u $DB_USER -p$DB_PASS > $BACKUP_DIR/$BACKUP_NAME
$MYSQLDUMP $DB_NAME2 $DB_PARAM -u $DB_USER -p$DB_PASS > $BACKUP_DIR/$BACKUP_NAME2
$MYSQLDUMP $DB_NAME3 $DB_PARAM -u $DB_USER -p$DB_PASS > $BACKUP_DIR/$BACKUP_NAME3

# Compactando arquivo em tar
echo "  -- Compactando arquivo em tar ..."
tar -cf $BACKUP_DIR/$BACKUP_TAR -C $BACKUP_DIR $BACKUP_NAME $BACKUP_NAME2 $BACKUP_NAME3

# Compactando arquivo em bzip2
echo "  -- Compactando arquivo em bzip2 ..."
bzip2 $BACKUP_DIR/$BACKUP_TAR

# Excluindo arquivos desnecessarios
echo "  -- Excluindo arquivos desnecessarios ..."
rm -rf $BACKUP_DIR/$BACKUP_NAME
rm -rf $BACKUP_DIR/$BACKUP_NAME2
rm -rf $BACKUP_DIR/$BACKUP_NAME3
