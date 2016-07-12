module ApplicationHelper

  # Returns the full page titile on a per-page basis.
  def full_title(page_title = '')
    base_title = "Synergy Metaphysician Information Location Engine"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Displays object errors
  def form_errors_for(object=nil)
    render('shared/form_errors', object: object) unless object.blank?
  end

end
