def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |items|
    items.each do |item_name, item_attributes|
      if consolidated_cart[item_name]
        item_attributes[:count] += 1
      else
        item_attributes[:count] = 1
        consolidated_cart[item_name] = item_attributes
      end
    end
  end
  consolidated_cart
end


def apply_coupons(cart, coupons)
  new_cart = cart.clone
  coupons.each do |coupon|
    cart.each do |item_name, item_attributes|
      if coupon[:item] == item_name && item_attributes[:count] >= coupon[:num]
        if cart[item_name + "W/COUPON"]
          new_cart[item_name + " W/COUPON"][:count] += 1
        elsif
          new_cart[item_name + " W/COUPON"] = {:price => coupon[:cost], :clearance => cart[item_name][:clearance], :count => 1}
        end
        new_cart[item_name][:count] -= coupon[:num]
      end
    end
  end
  cart = new_cart
end


def apply_clearance(cart)
  cart.each do |item_name, item_attributes|
      if item_attributes[:clearance]
        item_attributes[:price] = (item_attributes[:price] * 0.8).round(2)
      end
  end
  cart
end


def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total_cost = 0
    final_cart.each do |item_name, item_attributes|
      total_cost += item_attributes[:count] * item_attributes[:price]
    end
    if total_cost >= 100
      total_cost *= 0.9
    end
    total_cost
end
