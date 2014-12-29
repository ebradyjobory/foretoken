class NotificationMailer < MassMandrill::MandrillMailer

  def sign_up_notification(user)

    address =[]
    address << user.email

    mail(   :to => address,
            :from => 'foretoken@cuneiform.io',
            template: 'welcome_email',
            :subject => "Welcome to Foretoken beta!"   
        )         
  end  

  def terminate_notification(user)
    address =[]
    address << user.email

    mail(   :to => address,
            :from => 'foretoken@cuneiform.io',
            template: 'terminate_email',
            :subject => "Farewell"   
        )   
     
  end 
end


