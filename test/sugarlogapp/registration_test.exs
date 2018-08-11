#  user registration tests....................
defmodule Sugarlopapp.RegistrationTest do
    use ExUnit.Case  
    
    import Timex.Time   
    import Sugarlogapp.DataCase 
    alias Sugarlogapp.Data.User
    alias Sugarlogapp.Data

    @reading_dt Timex.to_datetime({{2018,8,6}, {15,48,0}}, "Etc/UTC") 
    @valid_attrs %{first_name: "sriram", last_name: "kota",email: "sri@mail.com", 
                    password: "Password!23", 
                    activation_token: "abc123", 
                    activation_token_created_at: @reading_dt }
    @valid_activation_attrs %{ email: "sri@mail.com", activation_token: "abc123", activation_token_created_at: @reading_dt}
    
    setup do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Sugarlogapp.Repo)
        Ecto.Adapters.SQL.Sandbox.mode(Sugarlogapp.Repo, {:shared, self()})
        :ok
      end
    
    test "changeset with valid attributes" do
        changeset = User.changeset(%User{}, @valid_attrs)
        assert changeset.valid?
    end
    
    test "changeset with invalid email" do
        attrs = %{@valid_attrs | email: "srimail.com"}
        changeset = User.changeset(%User{}, attrs)        
        assert %{email: ["Email is invalid"]} = errors_on(changeset)
    end

    test "changeset with insufficient attributes" do
        changeset = User.changeset(%User{}, Map.delete(@valid_attrs, :password))
        refute changeset.valid?
    end

    test "changeset with empty password" do 
        attrs = %{@valid_attrs | password: ""}
        changeset = User.changeset(%User{}, attrs)
        assert %{password: ["can't be blank"]} = errors_on(changeset)
    end    

    test "changeset with invalid password" do 
        attrs = %{@valid_attrs | password: "abc"}
        changeset = User.changeset(%User{}, attrs)
        assert %{password: ["Invalid Password. Must be atleast 8 chars long. Must contain 1 or more capital letter, 1 number and 1 special character."]} = errors_on(changeset)
    end

    test "User can be created with valid attributes" do 
        assert {:ok, user} = Data.create_user(@valid_attrs)
        assert user.first_name == "sriram"
        assert user.last_name == "kota"
        assert user.email == "sri@mail.com"        
        assert user.activation_token == "abc123"
        assert user.activation_token_created_at == @reading_dt
    end    

    # TODO: how do i do a negative test - ex: try to create user with invalid params?

    # activation
    test "activation changeset with valid attributes" do
        changeset = User.activate_user_changeset(%User{}, @valid_activation_attrs)
        assert changeset.valid?
    end
    
    test "activation changeset with insufficient attributes" do
        changeset = User.activate_user_changeset(%User{}, Map.delete(@valid_activation_attrs, :activation_token))
        refute changeset.valid?
    end

    # login


    # forgot password

end