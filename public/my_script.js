function something () {
  let x = window.localStorage.getItem('item_2')
  x++
  window.localStorage.setItem('item_2', x)
  alert(x)
}
