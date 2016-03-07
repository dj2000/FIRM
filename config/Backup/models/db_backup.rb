# encoding: utf-8

##
# Backup Generated: db_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t db_backup [-c <path_to_configuration_file>]
#
db_config = YAML.load_file("#{DIRECTORY}/config/database.yml")['production']

Backup::Model.new(:db_backup, 'Description for db_backup') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # PostgreSQL [Database]
  #
  database PostgreSQL do |db|
    db.name               = db_config['database']
    db.username           = db_config['username']
    db.password           = db_config['password']
    db.host               = "localhost"
    db.port               = 5432
  end

  ##
  # SCP (Secure Copy) [Storage]
  #
  store_with SCP do |server|
    server.username   = 'root'
    server.password   = 'firmprod'
    server.ip         = '162.243.49.199'
    server.port       = 22
    server.path       = BACKUP_DIRECTORY
    server.keep       = 5
  end

  ##
  # Mail [Notifier]
  #
  # The default delivery method for Mail Notifiers is 'SMTP'.
  # See the Wiki for other delivery options.
  # https://github.com/meskyanichi/backup/wiki/Notifiers
  #
  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true
    mail.from                 = "no-reply@example.com"
    mail.to                   = "himesh@pixelcrayons.com"
    mail.address              = "smtp.gmail.com"
    mail.port                 = 587
    mail.user_name            = "firm.inspection@gmail.com"
    mail.password             = "firmi123"
    mail.authentication       = "plain"
    mail.encryption           = :ssl
  end

end
