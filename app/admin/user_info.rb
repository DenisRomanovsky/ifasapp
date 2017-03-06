ActiveAdmin.register UserInfo do
  permit_params :first_name, :last_name, :phone_number, :city_id, :user_status_cd, :unp, :send_email
end
