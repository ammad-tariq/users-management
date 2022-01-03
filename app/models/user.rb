class User < ApplicationRecord
  PASSWORD_MIN_LENGTH = 10
  PASSWORD_MAX_LENGTH = 16
  validates :name, presence: true
  validates :password, presence: true
  validate :custom_password_validation
  validate :password_repeating_chars_validation

  def custom_password_validation
    rules = {
      " must contain at least one lowercase letter"  => /[a-z]+/,
      " must contain at least one uppercase letter"  => /[A-Z]+/,
      " must contain at least one digit"             => /\d+/,
      " length should be between 10 to 16"           =>/(?!\b[A-Z]+\b)\b[A-Z1-8]{5,12}\b/
    }

    rules.each do |message, regex|
      
      unless password.match( regex )
        if (message == " length should be between 10 to 16")
          password_length = password.length
          if password_length < User::PASSWORD_MIN_LENGTH
            (User::PASSWORD_MIN_LENGTH - password_length).times{|n| errors.add( :password, message ) } 
          elsif password_length > User::PASSWORD_MAX_LENGTH
            (password_length - User::PASSWORD_MAX_LENGTH).times{|n| errors.add( :password, message ) }
          end
        else
          errors.add( :password, message )
        end
      end 
    end
  end

  def password_repeating_chars_validation
    chars = password&.gsub(/(.)\1{2,}/).to_a
    if !chars.empty?
      chars.map { |char| errors.add(:password, "not allowed: '#{char[0]}' is occuring #{char.length} times") }
    end
  end
end
