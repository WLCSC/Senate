Senate::Application.config.middleware.use ExceptionNotifier,
  :email_prefix => "[SENATE ERROR] ",
  :sender_address => APP_CONFIG[:email_support_from],
  :exception_recipients => [APP_CONFIG[:email_support_recipients].split(';')]
