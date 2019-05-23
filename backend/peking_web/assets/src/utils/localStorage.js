const Storage = {
  get (key) {
    return localStorage.getItem(key)
  },
  set (key, value) {
    localStorage.setItem(key, value)
  },
  has (key, value) {
    return localStorage.has(key, value)
  },
  remove (key) {
    localStorage.removeItem(key)
  }
}

export default Storage
