defmodule Sugarlogapp.Data.User do
    use Ecto.Schema
    import Ecto.Changeset
    alias Sugarlogapp.Data.User

    #brcrypt for hashing password
    import Comeonin.Bcrypt, only: [hashpwsalt: 1] 

    #schema definition
    schema "users" do
        field :first_name, :string
        field :last_name, :string
        field :email, :string
        field :deleted_at, :utc_datetime, null: true
        field :remember_token, :string
        field :date_of_birth, :naive_datetime, null: true
        field :role, :string, size: 1, default: "u"
        field :active, :boolean, default: true
        field :password, :string, virtual: true
        field :password_hash, :string
        field :activation_token, :string
        field :activation_token_created_at, :utc_datetime, null: true
        field :password_reset_token, :string
        field :password_reset_token_created_at, :utc_datetime, null: true        
        timestamps()
    end
    
    #allowed columns

    #validations

    # changesets ---------

    #only these fields can be cast
    def blank_changeset(%User{} = user, attrs) do
        user
        |> cast(attrs, [:first_name, :last_name,:email,:password])
    end    

    def changeset(%User{} = user, attrs) do        
        # password = Map.get(attrs , :password)        
        user
        |> cast(attrs, [:first_name, :last_name,:email,:password,:activation_token, :activation_token_created_at, :activated_at ])        
        |> validate_required([:first_name, :last_name,:email,:password])        
        |> validate_format(:email, ~r/@/, message: "is invalid")        
        
    end

    # |> unique_constraint(:email)        
    # |> password_valid?
    # |> put_hashed_password


    # todo:
    # validate email
    # check password strength

    # hash password


end