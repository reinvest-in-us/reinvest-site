module ApplicationHelper
  def convert_newlines_to_paragraphs(text)
    return unless text.present?

    text.split("\n").map{|paragraph| "<p>#{paragraph}</p>"}.join('').html_safe
  end

  def open_graph_description
    @district.present? ? "Find where and how to give public comment on #{@district.name} police budgets" : "Find where and how to give public comment on police budgets."
  end

  def open_graph_title
    @district.present? ? "#{@district.name} | Reinvest in us." : "Reinvest in us."
  end
end
