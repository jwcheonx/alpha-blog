module ArticlesHelper
  include Pagy::Frontend

  def can_infer_author?
    controller_name == 'users' && action_name == 'show'
  end
end
