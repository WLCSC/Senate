raw_config = File.read("#{Rails.root}/config/app_config.yml")
APP_CONFIG = YAML.load(raw_config)[Rails.env].symbolize_keys

ActionMailer::Base.smtp_settings = {  
   :address              => APP_CONFIG[:email_server],  
   :port                 => APP_CONFIG[:email_server_port],  
   :domain               => APP_CONFIG[:ldap_domain_email],  
   :enable_starttls_auto => APP_CONFIG[:email_tls_auto]  
}  

