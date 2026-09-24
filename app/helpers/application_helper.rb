module ApplicationHelper
  def nav_link(label, path, active: current_page?(path))
    link_to label, path, class: "site-nav__link", aria: { current: (active ? "page" : nil) }
  end

  def money(cents)
    number_to_currency(cents / 100.0, unit: "$")
  end

  def qty(value)
    number_with_precision(value, precision: 2, strip_insignificant_zeros: true)
  end

  def stock_label(item)
    { "out" => "Out", "low" => "Below par", "ok" => "Stocked" }.fetch(item.stock_status)
  end
end
