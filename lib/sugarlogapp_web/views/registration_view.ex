defmodule SugarlogappWeb.RegistrationView do
    use SugarlogappWeb, :view

    def render("activation-sent.json", %{message: message, user: user}) do
        %{message: message, user: user}
    end

    def render("registration-error.json", %{changeset: changeset}) do
        %{errors: translate_errors(changeset)} 
    end

    defp translate_errors(changeset) do
        Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    end

  end
  