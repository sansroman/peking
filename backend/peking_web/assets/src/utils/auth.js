import Storage from './localStorage'

const TokenKey = 'Admin-Token'

export function getToken () {
  return Storage.get(TokenKey)
}

export function setToken (token) {
  return Storage.set(TokenKey, token)
}

export function removeToken () {
  return Storage.remove(TokenKey)
}
