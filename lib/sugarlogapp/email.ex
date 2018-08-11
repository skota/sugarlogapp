defmodule Sugarlogapp.Email do
    import Bamboo.Email
  
    def welcome_email(url, email) do
      new_email(
        to: email,
        from: "support@sugarlogapp.com",
        subject: "Welcome to the Sugarlogapp",
        html_body: "<strong>Please click the link below to activate your account </strong> <br/> <a href='" <> url <> "'> " <> url <> "</a>",
        text_body: "Thanks for joining!"
      )
    end

    def reset_email(url, email) do
      new_email(
        to: email,
        from: "support@sugarlogapp.com",
        subject: "Sugarlogapp password reset",
        html_body: "<strong>Please click the link below to reset your password </strong> <br/> <a href='" <> url <> "'> " <> url <> "</a>",
        text_body: "Please click the link below to reset your email "<> url 
      )
    end
  end