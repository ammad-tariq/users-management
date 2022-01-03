require 'csv'

class UserImport
  def self.create_bulk_users(file)
    new(file).create_bulk_users
  end

  private

  attr_reader :file

  def initialize(file = nil)
    @file = file
  end

  public

  def create_bulk_users
    data = CSV.parse(@file, headers: true)
    row = 0
    data.map do |user|
      user = User.new({name: user['name'], password: user['password']})
      row = row +1 
      if user.save
        {
          row: row,
          result: "#{user.name} was successful",
          errors: "None"
        }
      else
        {
          row: row,
          result: "Change #{user.errors.count} characters of #{user['name']}'s password",
          errors: user.errors.full_messages.uniq.to_sentence
        }
      end
    end
  end
end