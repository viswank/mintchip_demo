class UsersController < ApplicationController
  def new
    @transaction = Transaction.new
  end
end
