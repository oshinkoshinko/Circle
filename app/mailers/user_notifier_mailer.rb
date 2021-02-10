class UserNotifierMailer < ApplicationMailer
    default :from => ENV['SECRET_ADDRESS']

    def send_signup_email(member)
        @member = member
        mail( :to => @member.email, :subject => "会員登録が完了しました。" )
    end
end
