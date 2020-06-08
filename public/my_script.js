const add_to_cart = (id) => {
  let key = 'product_' + id;
  let x = window.localStorage.getItem(key);
  x = x * 1 + 1;
  window.localStorage.setItem(key, x);

  update_orders_input();
  update_orders_button();
}


const update_orders_input = () => {
  let orders = cart_get_orders();
  $('#orders_input').val(orders);
}


const update_orders_button = () => {
  let text = 'Cart (' + cart_get_number_of_items() + ')';
  $('#orders_button').val(text);
}


const cart_get_number_of_items = () => {
  let cnt = 0
  for (let i = 0; i < window.localStorage.length; i++) {
    let key = window.localStorage.key(i); // get key, hh[x] = hh[(x += 1)]
    let value = window.localStorage.getItem(key); // get value, in ruby: y = hh[x]
    if (key.indexOf('product_') === 0) {
      cnt = cnt + value * 1;
    }
  }
  return cnt;
}


const cart_get_orders = () => {
  let orders = '';
  for (let i = 0; i < window.localStorage.length; i++) {
    let key = window.localStorage.key(i);
    let value = window.localStorage.getItem(key);

    if (key.indexOf('product_') == 0) {
      orders = orders + key + '=' + value + ',';
    }
  }
  return orders;
}

const cancel_order = () => {
  window.localStorage.clear()

  update_orders_input()
  update_orders_button()

  $('#cart').text('Your cart is now empty')

  return false
}
