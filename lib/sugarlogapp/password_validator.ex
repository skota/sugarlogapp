defmodule Sugarlogapp.PasswordValidator do
    @valid_upper 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    @valid_lower 'abcdefghijklmnopqrstuvwxyz'
    @valid_num '0123456789'
    @valid_special '~!@#$%^&*()'
  
    def validate(pass) do        
      chars =
        pass
        |> String.to_charlist()
  
      valid_length?(chars) and has_valid_chars?(chars) and has_required_chars?(chars)
    end
  
    defp valid_length?(chars) when is_list(chars) do
      length(chars) >= 8 and length(chars) <= 32
    end
  
    defp has_valid_chars?(chars) when is_list(chars) do
      Enum.all?(chars, &validate_char/1)
    end
  
    defp has_required_chars?(chars) when is_list(chars) do
      [&has_upper/1, &has_lower/1, &has_num/1, &has_special/1 ]
      |> Enum.all?(&Enum.any?(chars, &1))
    end
  
    defp validate_char(char) do
      has_upper(char) or has_lower(char) or has_num(char) or has_special(char)
    end
  
    defp has_upper(char) do
      char in @valid_upper
    end
  
    defp has_lower(char) do
      char in @valid_lower
    end
  
    defp has_num(char) do
      char in @valid_num
    end

    defp has_special(char) do
      char in @valid_special
    end
  end