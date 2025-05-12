module AdoptionsHelper
    def status_color(status)
      case status
      when "requested" then "warning"
      when "accepted"  then "success"
      when "rejected"  then "danger"
      else "secondary"
      end
    end
  
    def status_badge(status)
      content_tag(:span, status.titleize, class: "badge bg-#{status_color(status)}")
    end
  end
  