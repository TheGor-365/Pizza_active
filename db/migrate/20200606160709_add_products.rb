class AddProducts < ActiveRecord::Migration[5.2]
  def change
    Product.create ({
      title: 'Hawaiian',
      description: 'This is Hawaiian pizza',
      price: 350,
      size: 30,
      is_spicy: false,
      is_veg: false,
      is_best_offer: false,
      path_to_image: '/images/hawayan.jpg'
    })

    Product.create ({
      title: 'Pepperoni',
      description: 'Nice Pepperoni pizza',
      price: 380,
      size: 30,
      is_spicy: true,
      is_veg: false,
      is_best_offer: false,
      path_to_image: '/images/pepperoni.jpg'
    })

    Product.create ({
      title: 'Veg',
      description: 'This is Veg pizza',
      price: 320,
      size: 30,
      is_spicy: false,
      is_veg: true,
      is_best_offer: false,
      path_to_image: '/images/veg.jpg'
    })
  end
end
