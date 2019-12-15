module ModesHelper
  def check_mode_for_object(object)
    unless can?(action_name.to_sym, object)
      flash[:danger] = "In #{Cfp.mode.mode} mode, you cannot #{action_name} a #{object}"
      redirect_to root_path
    end
  end

  def can?(action, object)
    Cfp.mode.can?(action, object)
  end
end
