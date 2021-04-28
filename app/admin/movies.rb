ActiveAdmin.register Movie do
  permit_params :genre, :title, :url
end
