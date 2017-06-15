if ENV['STAYTUS_SMTP_HOSTNAME']
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    openssl_verify_mode: "none",
    :address    => ENV['STAYTUS_SMTP_HOSTNAME'],
    :port       => ENV['STAYTUS_SMTP_PORT'],
    :user_name  => ENV['STAYTUS_SMTP_USERNAME'],
    :password   => ENV['STAYTUS_SMTP_PASSWORD'],
    :enable_starttls_auto => ENV['STAYTUS_SMTP_STARTTLS'] == '1',
    :domain                 => ENV['STAYTUS_SMTP_DOMAIN'],
    :openssl_verify_mode   => ENV['STAYTUS_SMTP_VERIFY_SSL'] == OpenSSL::SSL::VERIFY_PEER
  }
else
  puts "\e[33m=> You haven't configured an SMTP server. Mail will be sent using sendmail.\e[0m"
  ActionMailer::Base.delivery_method = :sendmail
end

Mail.defaults do
  if ActionMailer::Base.delivery_method == :smtp
    delivery_method :smtp, ActionMailer::Base.smtp_settings
  else
    delivery_method ActionMailer::Base.delivery_method
  end
end
