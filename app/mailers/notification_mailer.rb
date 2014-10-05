class NotificationMailer < MassMandrill::MandrillMailer

  def sign_up_notification(user)

    address =[]
    address << user.email

    mail(   :to => address,
            :from => 'essam.joubori@gmail.com',
            template: 'welcome_email',
            :subject => "Welcome to Datacast!"   
        )         
  end  

  def terminate_notification(user)
    address =[]
    address << user.email

    mail(   :to => address,
            :from => 'essam.joubori@gmail.com',
            template: 'terminate_email',
            :subject => "Farewell"   
        )   
     
  end 
end


