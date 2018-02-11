class RegistrationsController < Devise::RegistrationsController


    def sign_up_params
        params.require(:user).permit(:name, :email, :password, :password_conformation)
    end

    def account_update_params
        params.require(:user).permit(:name, :email, :password, :password_conformation, :current_password)
    end
    
end