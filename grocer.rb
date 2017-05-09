def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |items|
    items.each do |item, attributes|
      if consolidated_cart[item]
        attributes[:count] += 1
      else
        attributes[:count] = 1
        consolidated_cart[item] = attributes
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  cart.each do |items|
    items.each do |item, attributes|
    coupons.each do |coupon|
      if coupon[:item] == item && attributes[:count] >= coupon[:num]
        if cart[item + "W/COUPON}"]
          cart[item + "W/COUPON}"][:count] += 1
        elsif
          cart[item + "W/COUPON}"] = {:price => coupon[:cost], :clearance => cart[item][:clearance], :count => 1}
        end
        cart[item][:count] -= coupon[:num]
      end
    end
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |items|
    items.each do |item, attributes|
      if attributes[:clearance]
        attributes[:price] = (attributes[:price] * 0.8).round(2)
      end
    end
  end
  cart
end


def checkout(cart, coupons)
  # code here
end
