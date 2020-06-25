module ApplicationHelper
  def convert_newlines_to_paragraphs(text)
    return unless text.present?

    text.split("\n").map{|paragraph| "<p>#{paragraph}</p>"}.join('').html_safe
  end
end
