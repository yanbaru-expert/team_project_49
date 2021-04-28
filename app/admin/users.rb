ActiveAdmin.register User do
  permit_params :name, :age, :address
end
