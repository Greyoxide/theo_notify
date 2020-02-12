module FlashMessagesHelper

  def flash_messages(flash)
    unless flash.blank?
      content_tag :div, class: "message-container" do
        flash.collect do |key, value|
          content_tag :div, value, class: "flash-message #{key}"
        end.join.html_safe
      end
    end
  end

end

