module TabsHelper
  def set_active(path)
    "active" if current_page?(path)
  end
end