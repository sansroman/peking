import axios from 'axios'

function fetchList (query) {
  return axios({
    url: '/api/article/list',
    method: 'get',
    params: query
  })
}

function fetchArticle (id) {
  return axios({
    url: '/api/article/detail',
    method: 'get',
    params: { id }
  })
}

function fetchPv (pv) {
  return axios({
    url: '/api/article/pv',
    method: 'get',
    params: { pv }
  })
}

function createArticle (data) {
  return axios({
    url: '/api/article/create',
    method: 'post',
    data
  })
}

function updateArticle (data) {
  return axios({
    url: '/article/update',
    method: 'post',
    data
  })
}
export { fetchArticle, fetchList, fetchPv, createArticle, updateArticle }
