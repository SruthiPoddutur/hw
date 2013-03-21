ActiveAdmin.register Forum do
  scope :recent
  
  index do
    column :title
    column :description
    column :created_at
    default_actions
  end
end
