const something = () => {
  let x = window.localStorage.getItem('item_2')
  x++
  window.localStorage.setItem('item_2', x)
  alert(x)
}

const add_to_cart = (id) => {
  let key = 'product_' + id
  let x = window.localStorage.getItem(key)
  x++
  window.localStorage.setItem(key, x)
  // show count of items in cart
  alert('Items in your cart ' + cart_get_number_of_items())
}

const cart_get_number_of_items = () => {
  let cnt = 0
  for (let i = 0; i < window.localStorage.length; i++) {
    let key = window.localStorage.key(i) // get key, hh[x] = hh[(x += 1)]
    let value = window.localStorage.getItem(key) // get value, in ruby: y = hh[x]
    if (key.indexOf('product_') === 0) {
      cnt += value * 1
    }
  }
  return cnt
}
