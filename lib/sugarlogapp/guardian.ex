defmodule Sugarlogapp.Guardian do
    use Guardian, otp_app: :sugarlogapp

    alias Sugarlogapp.Repo
    alias Sugarlogapp.Data
    alias Sugarlogapp.Data.User

    def subject_for_token(user, _claims) do
        {:ok, to_string(user.id)}
    end

    def subject_for_token(_, _) do
        {:error, :reason_for_error}
    end
    
    def resource_from_claims(claims) do
        case Data.get_user(claims["sub"]) do
            nil -> {:error, :resource_not_found}
            user -> {:ok, user}
        end
    end

    def resource_from_claims(_claims) do
    {:error, :reason_for_error}
    end
end