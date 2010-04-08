class UserService

  def initialize(user_repository = UserRepository.new)
      @user_repository = user_repository
  end

  

end