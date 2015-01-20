require 'mandrill'

class MandrillDelivery

  def initialize(mail)
  end

  def deliver!(mail)
    build_meta_mandrill(mail)
    send_mandrill(mail)
  end

  #Message stuff

  def build_meta_mandrill(mail)

    #build Mandrill message hash
    @message = {
      :from_name=> "Essam",
      :from_email=>"essam.joubori@gmail.com",
      :subject=> "#{mail['subject']}",
      :to=>[
            {
              :email=> "#{mail['to']}",
              :name=> "#{mail['name']}"
            }
           ],
      :auto_text => true,
      :global_merge_vars => [
                             {
                               :name => "LISTCOMPANY",
                               :content => "Company Name Here"
                             }
                            ]
    }

    true
  end

  #sends email via Mandrill
  def send_mandrill(mail)
   
    m = Mandrill::API.new

    sending = m.messages.send_template('welcome_email',
                                       [
                                        {
                                          :name => 'main',
                                          :content => "#{mail.body}"
                                        },
                                       ],
                                       message = @message)
    Rails.logger.info sending
  end

end
