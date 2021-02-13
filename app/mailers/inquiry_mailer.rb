class InquiryMailer < ApplicationMailer

  def send_mail(inquiry)
    @inquiry = inquiry
    mail(
      from: @inquiry.email,
      to: ENV['SECRET_ADDRESS'],
      subject: 'お問い合わせ通知'
    )
  end

end
