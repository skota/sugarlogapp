defmodule Sugarlogapp.Data.User do
    use Ecto.Schema
    import Ecto.Changeset

    alias Sugarlogapp.Data.User
    alias Sugarlogapp.PasswordValidator

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

    #only these fields can be cast
    def blank_changeset(%User{} = user, attrs) do
        user
        |> cast(attrs, [:first_name, :last_name,:email,:password])
    end    

    def changeset(%User{} = user, attrs) do        
        # password = Map.get(attrs , :password)        
        user
        |> cast(attrs, [:first_name, :last_name,:email,:password, :password_hash,:activation_token, :activation_token_created_at ])        
        |> validate_required([:first_name, :last_name,:email,:password])        
        |> validate_format(:email, ~r/@/, message: "Email is invalid")        
        |> unique_constraint(:email)    
        |> password_valid?   
        |> hash_password     
    end

    # changeset for activation
    def activate_user_changeset(%User{} = user, attrs) do            
        user
        |> cast(attrs, [:email, :activation_token, :activation_token_created_at ] )                      
        |> validate_required([:email, :activation_token, :activation_token_created_at ])        
    end

    # changeset for forgot password
    defp password_valid?(changeset) do
        if changeset.valid? do
            pass=get_field(changeset, :password)
            result = PasswordValidator.validate(pass)
            case result do                    
                true ->
                    changeset        
                false ->
                    changeset
                    |> add_error(:password, "Invalid Password. Must be atleast 8 chars long. Must contain 1 or more capital letter, 1 number and 1 special character.")      
                    |> put_change(:valid?, false)        
            end
        else
            changeset      
        end
    end

    defp hash_password(changeset) do
        case changeset.valid? do
            true ->
                changes = changeset.changes
                put_change(changeset, :password_hash, hashpwsalt(changes.password))
            _->
                changeset    
        end  
    end



end