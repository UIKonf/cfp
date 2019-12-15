module ModesHelper
  def check_mode_for_object(object)
    unless can?(requested_action, object)
      flash[:danger] = "In #{Cfp.mode.mode} mode, you cannot #{action_name} a #{object}"
      redirect_to root_path
    end
  end

  def can?(action, object)
    Cfp.mode.can?(action, object)
  end

  def requested_action
    case action_name
    when 'index', 'show'
      :view
    when 'create', 'new'
      :create
    when 'edit', 'update'
      :update
    else
      action_name.to_sym
    end
  end
end
