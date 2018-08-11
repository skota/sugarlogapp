defmodule SugarlogappWeb.RegisterView do
    use SugarlogappWeb, :view

    def render("activation-sent.json", %{message: message}) do
        %{message: message}
    end

    def render("registration-error.json", %{changeset: changeset}) do
        %{errors: translate_errors(changeset)} 
    end

    defp translate_errors(changeset) do
        Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
    end

  end
  