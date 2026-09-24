# Idempotent: safe to run after db:prepare (which seeds a new database) and again by hand.

[
  { name: "Maya Okafor", email_address: "manager@pantry.test", password: "pantry-manager", role: "manager" },
  { name: "Theo Lindqvist", email_address: "cook@pantry.test", password: "pantry-cook", role: "cook" }
].each do |attrs|
  user = User.find_or_initialize_by(email_address: attrs[:email_address])
  user.update!(attrs)
end

suppliers = [
  { name: "Greenfold Farm", contact_name: "Ruth Amari", email: "orders@greenfold.test", phone: "555-0141",
    delivery_days: "Tue, Fri", lead_time_days: 2, notes: "Seasonal produce and herbs from a farm forty minutes out." },
  { name: "Harbor Dairy Co-op", contact_name: "Sam Whitlock", email: "dispatch@harbordairy.test", phone: "555-0187",
    delivery_days: "Mon, Wed, Fri", lead_time_days: 1, notes: "Milk, cream, butter and cultured dairy." },
  { name: "Northgate Meats", contact_name: "Dario Ferri", email: "desk@northgate.test", phone: "555-0112",
    delivery_days: "Tue, Thu, Sat", lead_time_days: 2, notes: "Whole-animal butcher; cuts to spec with a day's notice." },
  { name: "Common Grain Mill", contact_name: "Ines Paredes", email: "mill@commongrain.test", phone: "555-0163",
    delivery_days: "Mon", lead_time_days: 5, notes: "Flour, grains and legumes, milled weekly." },
  { name: "Spice Route Traders", contact_name: "Anand Rao", email: "hello@spiceroute.test", phone: "555-0129",
    delivery_days: "Thu", lead_time_days: 7, notes: "Whole and ground spices, oils and vinegars." }
].to_h do |attrs|
  supplier = Supplier.find_or_initialize_by(name: attrs[:name])
  supplier.update!(attrs)
  [attrs[:name], supplier]
end

[
  [ "Shallots",            "Produce",   "Dry store", "kg",    4,    6,    420,  "Greenfold Farm",      "Keep away from the potatoes." ],
  [ "Flat-leaf parsley",   "Produce",   "Walk-in",   "bunch", 3,    8,    150,  "Greenfold Farm",      "Stand stems in water, cover loosely." ],
  [ "Lemons",              "Produce",   "Walk-in",   "each",  36,   30,   45,   "Greenfold Farm",      nil ],
  [ "Heirloom tomatoes",   "Produce",   "Line",      "kg",    2.5,  5,    780,  "Greenfold Farm",      "Never refrigerate." ],
  [ "Yukon Gold potatoes", "Produce",   "Dry store", "kg",    22,   20,   160,  "Greenfold Farm",      nil ],
  [ "Whole milk",          "Dairy",     "Walk-in",   "l",     12,   10,   130,  "Harbor Dairy Co-op",  nil ],
  [ "Double cream",        "Dairy",     "Walk-in",   "l",     1.5,  4,    620,  "Harbor Dairy Co-op",  "Check dates, first in first out." ],
  [ "Cultured butter",     "Dairy",     "Walk-in",   "kg",    3,    3,    1450, "Harbor Dairy Co-op",  nil ],
  [ "Parmigiano Reggiano", "Dairy",     "Walk-in",   "kg",    0,    1.5,  2800, "Harbor Dairy Co-op",  "Wrap cut faces in paper, not film." ],
  [ "Chicken thighs",      "Protein",   "Walk-in",   "kg",    8,    10,   990,  "Northgate Meats",     "Bone-in, skin-on." ],
  [ "Pork shoulder",       "Protein",   "Freezer",   "kg",    6,    4,    870,  "Northgate Meats",     nil ],
  [ "Beef short rib",      "Protein",   "Freezer",   "kg",    2,    6,    2150, "Northgate Meats",     "Thaw two days ahead in the walk-in." ],
  [ "Bread flour",         "Dry goods", "Dry store", "kg",    18,   25,   110,  "Common Grain Mill",   nil ],
  [ "Arborio rice",        "Dry goods", "Dry store", "kg",    9,    5,    480,  "Common Grain Mill",   nil ],
  [ "Black lentils",       "Dry goods", "Dry store", "kg",    4,    4,    390,  "Common Grain Mill",   nil ],
  [ "Sourdough loaves",    "Bakery",    "Line",      "each",  6,    12,   550,  "Common Grain Mill",   "Baked in-house from the mill's flour." ],
  [ "Smoked paprika",      "Spices",    "Dry store", "g",     250,  200,  4,    "Spice Route Traders", nil ],
  [ "Cumin seed",          "Spices",    "Dry store", "g",     80,   200,  3,    "Spice Route Traders", "Toast whole, grind to order." ],
  [ "Extra virgin olive oil", "Oils",   "Dry store", "l",     7,    10,   1320, "Spice Route Traders", nil ],
  [ "Sherry vinegar",      "Oils",      "Dry store", "l",     2,    1,    940,  "Spice Route Traders", nil ],
  [ "Frozen peas",         "Frozen",    "Freezer",   "kg",    5,    5,    310,  nil,                   "Bought retail when the order runs short." ]
].each do |name, category, location, unit, quantity, par, cost, supplier_name, notes|
  item = Item.find_or_initialize_by(name: name)
  item.update!(category: category, location: location, unit: unit, quantity: quantity, par_level: par,
               unit_cost_cents: cost, supplier: suppliers[supplier_name], notes: notes)
end

[
  [ "PO-1041", "Greenfold Farm",      "received", -6, 9,  18_450 ],
  [ "PO-1042", "Harbor Dairy Co-op",  "received", -5, 6,  12_980 ],
  [ "PO-1043", "Northgate Meats",     "received", -3, 4,  41_200 ],
  [ "PO-1044", "Common Grain Mill",   "placed",    2, 5,  22_760 ],
  [ "PO-1045", "Greenfold Farm",      "placed",    1, 7,  15_300 ],
  [ "PO-1046", "Spice Route Traders", "placed",    6, 3,  9_870  ],
  [ "PO-1047", "Northgate Meats",     "draft",   nil, 2,  30_150 ],
  [ "PO-1048", "Harbor Dairy Co-op",  "draft",   nil, 3,  8_420  ]
].each_with_index do |(reference, supplier_name, status, days, lines, total), index|
  order = Order.find_or_initialize_by(reference: reference)
  order.update!(supplier: suppliers[supplier_name], status: status, line_count: lines, total_cents: total,
                expected_on: days && Date.current + days, created_at: (8 - index).days.ago)
end
