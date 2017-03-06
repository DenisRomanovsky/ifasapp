ActiveAdmin.register User do
  permit_params :email, :user_info_id
end
