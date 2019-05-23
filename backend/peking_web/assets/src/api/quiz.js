import axios from 'axios'

function fetchList (query) {
  return axios({
    url: '/api/answers/me',
    method: 'get',
    params: query
  })
}

function fetchQuiz (query) {
  return axios({
    url: '/api/answers/own',
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

function updateAnswer (data) {
  return axios({
    url: `/api/answers/${data.answer.id}`,
    method: 'put',
    data
  })
}
export { fetchArticle, fetchQuiz, fetchList, fetchPv, createArticle, updateAnswer }
