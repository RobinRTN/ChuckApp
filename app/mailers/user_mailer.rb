class UserMailer < Devise::Mailer

  def confirmation_instructions(record, token, opts = {})
    opts[:subject] = "Confirmer mon adresse email pour ChuckApp"
    super
  end
end
